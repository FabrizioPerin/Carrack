Class {
	#name : #CAKModelBuilder,
	#superclass : #Object,
	#instVars : [
		'cakModel',
		'groups'
	],
	#category : #'Carrack-Model'
}

{ #category : #'as yet unclassified' }
CAKModelBuilder >> consistencyCheck: aDictionary [
	| allKnownSelectors |
	
	self model containmentSelectors
		do: [ :selectorVector | 
			((aDictionary keys anySatisfy: [ :key | key name asSymbol = selectorVector first ])
				and: [ aDictionary keys anySatisfy: [ :key | key name asSymbol = selectorVector second ] ])
				ifFalse: [ ^ false ] ].
	
	allKnownSelectors := Set new.
	allKnownSelectors
		addAll:
			(self model containmentSelectors flatCollect: [ :each | OrderedCollection with: each first with: each second ]).
	(allKnownSelectors size = aDictionary keys size)
		ifFalse: [ ^ false ].
		
	^ true
]

{ #category : #'as yet unclassified' }
CAKModelBuilder >> create [
	| types |

	types := self identifyTypes.
	self consistencyCheck: types
]

{ #category : #'as yet unclassified' }
CAKModelBuilder >> createContainmentRelations: aDictionary [

	self model containmentSelectors do: [:vector | 
		aDictionary keys do: [:key |
			(aDictionary at: vector first) do: [:value |self halt.
				value model perform: vector third.
				]]
			].
		
		"
		 Period or right bracket expected ->keysAndValuesDo: [:key :value |
		| cakGroup |
		cakGroup := CAKEntityGroup new.
		cakGroup type: key.
		cakGroup addAll: value.
		self model add: cakGroup. ].

		]
	

	"
]

{ #category : #'as yet unclassified' }
CAKModelBuilder >> createGroups: aDictionary [

	aDictionary keysAndValuesDo: [:key :value |
		| cakGroup |
		cakGroup := CAKEntityGroup new.
		cakGroup type: key.
		cakGroup addAll: value.
		self model add: cakGroup. ].


	
]

{ #category : #'as yet unclassified' }
CAKModelBuilder >> defineAssociationSelector: aSelector from: aClassName to: anotherClassName [

	self model associationSelectors add: (OrderedCollection with: aClassName with: anotherClassName with: aSelector). 


]

{ #category : #'as yet unclassified' }
CAKModelBuilder >> defineContainementSelector: aSelector from: aClassName to: anotherClassName [

	self model containmentSelectors add: (OrderedCollection with: aClassName with: anotherClassName with: aSelector). 


]

{ #category : #'as yet unclassified' }
CAKModelBuilder >> identifyTypes [
	| types |
	
	types := Dictionary new.
	
	self model do: [ :cakEl | 
		types 
			at: cakEl model class name
			ifPresent: [:value | value add: cakEl] 
			ifAbsent: [types at: cakEl model class name put: (OrderedCollection with: cakEl) ] ].
	
	^ types
]

{ #category : #'as yet unclassified' }
CAKModelBuilder >> initialize [ 

	super initialize.

	cakModel := CAKModel new.
	
	^self
]

{ #category : #'as yet unclassified' }
CAKModelBuilder >> model [
	^cakModel
]

{ #category : #'as yet unclassified' }
CAKModelBuilder >> model: aCAKModel [
	cakModel := aCAKModel.
]

{ #category : #'as yet unclassified' }
CAKModelBuilder >> node: anObject [
	
	^self nodes: (OrderedCollection with: anObject). 
]

{ #category : #'as yet unclassified' }
CAKModelBuilder >> nodes: aCollection [
	| nodes |

	self assert: [ aCollection isCollection ] description: 'A collection should be provided, else use #node: instead'.

	nodes := aCollection
		collect: [ :anEntity | 
			| cakEntity |
			cakEntity := CAKEntity new.
			cakEntity model: anEntity.
			self model add: cakEntity.
			cakEntity ].

	^ nodes
]
