Class {
	#name : #CAKModelBuilder,
	#superclass : #Object,
	#instVars : [
		'cakModel',
		'groups',
		'containmentSelectors',
		'associationSelectors'
	],
	#category : #'Carrack-Model'
}

{ #category : #accessing }
CAKModelBuilder >> associationSelectors [
	^ associationSelectors
]

{ #category : #accessing }
CAKModelBuilder >> associationSelectors: anObject [
	associationSelectors := anObject
]

{ #category : #'as yet unclassified' }
CAKModelBuilder >> consistencyCheck: aDictionary [
	| allKnownSelectors |

	self containmentSelectors
		do: [ :selectorVector | 
			((aDictionary keys anySatisfy: [ :key | key = selectorVector first ])
				and: [ aDictionary keys anySatisfy: [ :key | key = selectorVector second ] ])
				ifFalse: [ ^ false ] ].
	
	allKnownSelectors := Set new.
	allKnownSelectors
		addAll:
			(self containmentSelectors flatCollect: [ :each | OrderedCollection with: each first with: each second ]).
	(allKnownSelectors size = aDictionary keys size)
		ifFalse: [ ^ false ].
		
	^ true
]

{ #category : #accessing }
CAKModelBuilder >> containmentSelectors [
	^ containmentSelectors
]

{ #category : #accessing }
CAKModelBuilder >> containmentSelectors: anObject [
	containmentSelectors := anObject
]

{ #category : #tokens }
CAKModelBuilder >> create [
	| types |

	types := self identifyTypes.
	self consistencyCheck: types
]

{ #category : #'as yet unclassified' }
CAKModelBuilder >> createAssociationRelations: aDictionary [
	self associationSelectors
		do: [ :vector | 
			(aDictionary at: vector first)
				do: [ :value | 
					|  values |
					values := value model perform: vector third.
					values
						do: [ :each | 
							| result assocModel |
							each isFamixAssociaton
								ifTrue: [ 
									result := self findCakEntityFor: each to.
									assocModel := each ]
								ifFalse: [ 
									result := self findCakEntityFor: each.
									assocModel := nil ].
							result
								do: [ :targetEntity | 
									| containment |
									containment := CAKAssociation new.
									containment associationSource: value.
									containment associationTarget: targetEntity.
									containment model: assocModel.
									self model add: containment ] ] ] ].
	^ self model allWithType: CAKAssociation
]

{ #category : #'as yet unclassified' }
CAKModelBuilder >> createContainmentRelations: aDictionary [
	self containmentSelectors
		do: [ :vector | 
			(aDictionary at: vector first)
				do: [ :value | 
					|  values |
					values := value model perform: vector third.
					values
						do: [ :each | 
							| result assocModel |
							each isFamixAssociaton
								ifTrue: [ 
									result := self findCakEntityFor: each to.
									assocModel := each ]
								ifFalse: [ 
									result := self findCakEntityFor: each.
									assocModel := nil ].
							result
								do: [ :targetEntity | 
									| containment |
									containment := CAKContainment new.
									containment container: value.
									containment content: targetEntity.
									containment model: assocModel.
									self model add: containment ] ] ] ].
	^ self model allWithType: CAKContainment
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

	self associationSelectors add: (OrderedCollection with: aClassName with: anotherClassName with: aSelector). 


]

{ #category : #'as yet unclassified' }
CAKModelBuilder >> defineContainementSelector: aSelector from: aClassName to: anotherClassName [

	self containmentSelectors add: (OrderedCollection with: aClassName with: anotherClassName with: aSelector). 


]

{ #category : #'as yet unclassified' }
CAKModelBuilder >> findCakEntitiesFor: aCollectionOfObjects [
	| result |

	result := OrderedCollection new.
	aCollectionOfObjects do: [:each |
		result add: (self findCakEntityFor: each) ].
	^result flatten
]

{ #category : #'as yet unclassified' }
CAKModelBuilder >> findCakEntityFor: anObject [
	^self model allEntities select: [:entity | entity model = anObject].
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
CAKModelBuilder >> inferAssociationRelations [
	"inferAssociationRelationsOn: method return the newly created associations if non are created means that all the entities has been covered"
	| associations |
	
	associations := self model allAssociations.
	
	[associations isEmpty not] whileTrue: [associations := self inferAssociationRelationsOn: associations]
]

{ #category : #'as yet unclassified' }
CAKModelBuilder >> inferAssociationRelationsOn: aCollectionOfAssociations [
	| associations result |
	
	associations := self model allAssociations.
	result := OrderedCollection new.
	
	aCollectionOfAssociations
		do: [ :association | 
			| sourceContainer targetContainer |
			sourceContainer := association associationSource containerEntities.
			targetContainer := association associationTarget containerEntities.
			(sourceContainer outgoingAssociations select: [ :each | each associationTarget = targetContainer ]) isEmpty
				ifTrue: [ 
					| newAssociation |
					newAssociation := CAKAssociation new.
					newAssociation associationSource: sourceContainer.
					newAssociation associationTarget: targetContainer.
					newAssociation model: association.
					result add: newAssociation ] ].
	^ result
]

{ #category : #initialization }
CAKModelBuilder >> initialize [ 

	super initialize.

	cakModel := CAKModel new.
	associationSelectors := OrderedCollection new. 
	containmentSelectors := OrderedCollection new.
	
	^self
]

{ #category : #accessing }
CAKModelBuilder >> model [
	^cakModel
]

{ #category : #accessing }
CAKModelBuilder >> model: aCAKModel [
	cakModel := aCAKModel.
]

{ #category : #accessing }
CAKModelBuilder >> node: anObject [
	
	^self nodes: (OrderedCollection with: anObject). 
]

{ #category : #accessing }
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
