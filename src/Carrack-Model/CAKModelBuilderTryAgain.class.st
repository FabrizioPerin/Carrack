Class {
	#name : #CAKModelBuilderTryAgain,
	#superclass : #Object,
	#instVars : [
		'cakModel',
		'groups',
		'entitiesCache',
		'containmentsDefinition',
		'associationsDefinition'
	],
	#category : #'Carrack-Model'
}

{ #category : #accessing }
CAKModelBuilderTryAgain >> associationDefinitions [
	^ associationsDefinition
]

{ #category : #accessing }
CAKModelBuilderTryAgain >> cacheEntities [
	entitiesCache := OrderedCollection withAll: self model allEntities
]

{ #category : #'as yet unclassified' }
CAKModelBuilderTryAgain >> consistencyCheck: aDictionary [
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
CAKModelBuilderTryAgain >> containmentDefinitions [
	^ containmentsDefinition
]

{ #category : #'as yet unclassified' }
CAKModelBuilderTryAgain >> create [
	| types |
	
	self cacheEntities.

	self createContainmentRelations.
	Transcript show: 'Containment DONE.' , String cr.
	Transcript show: DateAndTime now asTimeStamp asString , String cr.
	
	self createAssociationRelations.
	Transcript show: 'Association DONE.' , String cr.
	Transcript show: DateAndTime now asTimeStamp asString , String cr.
	
	self inferAssociationRelations.
	Transcript show: 'Infer associations DONE.' , String cr.
	Transcript show: DateAndTime now asTimeStamp asString , String cr.

]

{ #category : #'as yet unclassified' }
CAKModelBuilderTryAgain >> createAssociationRelations [
	| result |
	self associationDefinitions
		do: [ :aCakAssociationDef |
			| association |
			association := CAKAssociation new.
			association associationSource: ( self findCakEntityFor: ( aCakAssociationDef from value: aCakAssociationDef model ) ). 
			association associationTarget: ( self findCakEntityFor: ( aCakAssociationDef to value: aCakAssociationDef model ) ).
			association model: aCakAssociationDef model.
			self model add: association ].
]

{ #category : #'as yet unclassified' }
CAKModelBuilderTryAgain >> createContainmentRelations [
	| result |
	result := OrderedCollection new.
	self containmentDefinitions
		do: [ :aCakContainmentDef |
			| containment |
			containment := CAKContainment new.
			containment container: ( self findCakEntityFor: ( aCakContainmentDef from value: aCakContainmentDef model ) ). 
			containment content: ( self findCakEntityFor: ( aCakContainmentDef to value: aCakContainmentDef model ) ).
			containment model: aCakContainmentDef model.
			result add: containment.
			self model add: containment ].
]

{ #category : #'as yet unclassified' }
CAKModelBuilderTryAgain >> createGroups: aDictionary [

	aDictionary keysAndValuesDo: [:key :value |
		| cakGroup |
		cakGroup := CAKEntityGroup new.
		cakGroup type: key.
		cakGroup addAll: value.
		self model add: cakGroup. ].


	
]

{ #category : #'as yet unclassified' }
CAKModelBuilderTryAgain >> defineAssociationFrom: aSelectorOrBlock to: anotherSelectorOrBlock on: aModel [

	self associationDefinitions add: (CAKAssociationDef on: aModel from: aSelectorOrBlock to: anotherSelectorOrBlock). 


]

{ #category : #'as yet unclassified' }
CAKModelBuilderTryAgain >> defineAssociationsFrom: aSelectorOrBlock to: anotherSelectorOrBlock on: aModelsCollection [

	aModelsCollection do: [:aModel | self associationDefinitions add: (CAKAssociationDef on: aModel from: aSelectorOrBlock to: anotherSelectorOrBlock) ].

]

{ #category : #'as yet unclassified' }
CAKModelBuilderTryAgain >> defineContainmentFrom: aSelectorOrBlock to: anotherSelectorOrBlock on: aModel [

	self containmentDefinitions add: (CAKContainmentDef on: aModel from: aSelectorOrBlock to: anotherSelectorOrBlock). 


]

{ #category : #'as yet unclassified' }
CAKModelBuilderTryAgain >> defineContainmentsFrom: aSelectorOrBlock to: anotherSelectorOrBlock on: aModelsCollection [

	aModelsCollection do: [:aModel | self containmentDefinitions add: (CAKAssociationDef on: aModel from: aSelectorOrBlock to: anotherSelectorOrBlock) ].

]

{ #category : #accessing }
CAKModelBuilderTryAgain >> entitiesCache [
	^ entitiesCache
]

{ #category : #'as yet unclassified' }
CAKModelBuilderTryAgain >> findCakEntitiesFor: aCollectionOfObjects [
	| result |

	result := OrderedCollection new.
	aCollectionOfObjects do: [:each |
		result add: (self findCakEntityFor: each) ].
	^result flatten
]

{ #category : #'as yet unclassified' }
CAKModelBuilderTryAgain >> findCakEntityFor: anObject [
	| result |
	result := self entitiesCache detect: [:entity | entity model = anObject] ifNone: [nil].
	result isNil
		ifTrue: [^OrderedCollection new].
	
	^OrderedCollection with: result
	
]

{ #category : #accessing }
CAKModelBuilderTryAgain >> identifyTypes [
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
CAKModelBuilderTryAgain >> inferAssociationRelations [
	"inferAssociationRelationsOn: method return the newly created associations if non are created means that all the entities has been covered"
	| associations |
	
	associations := self model allAssociations.
	
	[associations isEmpty not] whileTrue: [associations := self inferAssociationRelationsOn: associations]
]

{ #category : #'as yet unclassified' }
CAKModelBuilderTryAgain >> inferAssociationRelationsOn: aCollectionOfAssociations [
	| associations result assocToCreate |
	
	result := OrderedCollection new.
	assocToCreate := Dictionary new.
	
	aCollectionOfAssociations
		do: [ :association | 
			| sourceContainers targetContainers |
			sourceContainers := association associationSource containers.
			targetContainers := association associationTarget containers.
			sourceContainers
				do: [ :sourceContainer | 
					targetContainers
						do: [ :targetContainer | 
							assocToCreate
								at: sourceContainer container -> targetContainer container
								ifPresent: [ :value | value add: association ]
								ifAbsent: [ assocToCreate at: sourceContainer container -> targetContainer container put: (OrderedCollection with: association) ] ] ] ].

	result := self instanciateAssociationFrom: assocToCreate.
	
	^ result
]

{ #category : #initialization }
CAKModelBuilderTryAgain >> initialize [ 

	super initialize.

	cakModel := CAKModel new.
	associationsDefinition := OrderedCollection new. 
	containmentsDefinition := OrderedCollection new.
	
	^self
]

{ #category : #'as yet unclassified' }
CAKModelBuilderTryAgain >> instanciateAssociationFrom: aDictionary [
	| result |

	result := OrderedCollection new.

	aDictionary
		keysAndValuesDo: [ :key :value | 
			| newAssociation |
			newAssociation := CAKAssociation new.
			newAssociation associationSource: key key.
			newAssociation associationTarget: key value.
			newAssociation model: value.
			self model add: newAssociation.
			result add: newAssociation.
			 ].
	
	^ result
]

{ #category : #accessing }
CAKModelBuilderTryAgain >> model [
	^cakModel
]

{ #category : #accessing }
CAKModelBuilderTryAgain >> model: aCAKModel [
	cakModel := aCAKModel.
]

{ #category : #accessing }
CAKModelBuilderTryAgain >> node: anObject [
	
	^self nodes: (OrderedCollection with: anObject). 
]

{ #category : #accessing }
CAKModelBuilderTryAgain >> nodes: aCollection [
	| nodes |

	self assert: [ aCollection isCollection ] description: 'A collection should be provided, else use #node: instead'.

	nodes := aCollection
		collect: [ :anEntity | 
			| cakEntity |
			cakEntity := CAKEntity new.
			cakEntity entityName: anEntity name.
			cakEntity model: anEntity.
			self model add: cakEntity.
			cakEntity ].

	^ nodes
]
