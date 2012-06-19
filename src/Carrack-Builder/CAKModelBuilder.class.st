Class {
	#name : #CAKModelBuilder,
	#superclass : #Object,
	#instVars : [
		'cakModel',
		'groups',
		'containmentsDefinition',
		'associationsDefinition'
	],
	#category : #'Carrack-Builder'
}

{ #category : #accessing }
CAKModelBuilder >> associationDefinitions [
	^ associationsDefinition
]

{ #category : #accessing }
CAKModelBuilder >> cacheEntities [
	self model cacheEntities
]

{ #category : #accessing }
CAKModelBuilder >> containmentDefinitions [
	^ containmentsDefinition
]

{ #category : #'as yet unclassified' }
CAKModelBuilder >> create [
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
CAKModelBuilder >> createAssociationRelations [
	| result |
	result := OrderedCollection new.

	self associationDefinitions
		do: [ :aCakAssocDef |
			| sourceModels sourceCakEntities targetModels targetCakEntities |
			
			sourceModels := aCakAssocDef from value: aCakAssocDef model.
			sourceModels isCollection
				ifTrue: [ sourceCakEntities := self findCakEntitiesFor: sourceModels ]
				ifFalse: [ sourceCakEntities := self findCakEntityFor: sourceModels ].	
			
			targetModels := aCakAssocDef to value: aCakAssocDef model.
			targetModels isCollection 
				ifTrue: [ targetCakEntities := self findCakEntitiesFor: targetModels ]
				ifFalse: [ targetCakEntities := self findCakEntityFor: targetModels ].

			sourceCakEntities
				do: [ :source |
					targetCakEntities
						do: [:target |
							| association |
							association := CAKAssociation new.
							association associationSource: source.
							association associationTarget: target.
							association model: aCakAssocDef model.
							result add: association.
							self model add: association ] ] ].
	^result
]

{ #category : #'as yet unclassified' }
CAKModelBuilder >> createContainmentRelations [
	| result |
	result := OrderedCollection new.
	self containmentDefinitions
		do: [ :aCakContainmentDef |
			| sourceModels sourceCakEntities targetModels targetCakEntities |
			
			sourceModels := aCakContainmentDef from value: aCakContainmentDef model.
			sourceModels isCollection
				ifTrue: [ sourceCakEntities := self findCakEntitiesFor: sourceModels ]
				ifFalse: [ sourceCakEntities := self findCakEntityFor: sourceModels ].	
			
			targetModels := aCakContainmentDef to value: aCakContainmentDef model.
			targetModels isCollection 
				ifTrue: [ targetCakEntities := self findCakEntitiesFor: targetModels ]
				ifFalse: [ targetCakEntities := self findCakEntityFor: targetModels ].
			
			sourceCakEntities
				do: [ :source |
					targetCakEntities
						do: [:target |
							| containment |
							containment := CAKContainment new.
							containment container: source.
							containment content: target.
							containment model: aCakContainmentDef model.
							result add: containment.
							self model add: containment ] ] ].
	^result
]

{ #category : #'as yet unclassified' }
CAKModelBuilder >> createContainmentRelations2 [
	| result |
	result := OrderedCollection new.
	self containmentDefinitions
		do: [ :aCakContainmentDef |
			| sourceModels sourceCakEntities targetModels targetCakEntities |
			
			sourceCakEntities := self findEntitiesFor: ( aCakContainmentDef from value: aCakContainmentDef model ). 
			
			sourceModels := 
			sourceModels isCollection
				ifTrue: [ sourceCakEntities := self findCakEntitiesFor: sourceModels ]
				ifFalse: [ sourceCakEntities := self findCakEntityFor: sourceModels ].	
			
			targetModels := aCakContainmentDef to value: aCakContainmentDef model.
			targetModels isCollection 
				ifTrue: [ targetCakEntities := self findCakEntitiesFor: targetModels ]
				ifFalse: [ targetCakEntities := self findCakEntityFor: targetModels ].
			
			sourceCakEntities
				do: [ :source |
					targetCakEntities
						do: [:target |
							| containment |
							containment := CAKContainment new.
							containment container: source.
							containment content: target.
							containment model: aCakContainmentDef model.
							result add: containment.
							self model add: containment ] ] ].
	^result
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
CAKModelBuilder >> defineAssociationFrom: aSelectorOrBlock to: anotherSelectorOrBlock on: aModel [

	aModel isCollection 
		ifTrue: [aModel do: [:each |
				self associationDefinitions add: (CAKAssociationDef on: each from: aSelectorOrBlock to: anotherSelectorOrBlock)]]
		ifFalse: [self associationDefinitions add: (CAKAssociationDef on: aModel from: aSelectorOrBlock to: anotherSelectorOrBlock)]. 


]

{ #category : #'as yet unclassified' }
CAKModelBuilder >> defineAssociationsFrom: aSelectorOrBlock to: anotherSelectorOrBlock on: aModelsCollection [

	aModelsCollection do: [:aModel | self associationDefinitions add: (CAKAssociationDef on: aModel from: aSelectorOrBlock to: anotherSelectorOrBlock) ].

]

{ #category : #'as yet unclassified' }
CAKModelBuilder >> defineContainmentFrom: aSelectorOrBlock to: anotherSelectorOrBlock on: aModel [

	aModel isCollection 
		ifTrue: [aModel do: [:each |
				self containmentDefinitions add: (CAKContainmentDef on: each from: aSelectorOrBlock to: anotherSelectorOrBlock)]]
		ifFalse: [self containmentDefinitions add: (CAKContainmentDef on: aModel from: aSelectorOrBlock to: anotherSelectorOrBlock)]. 


]

{ #category : #'as yet unclassified' }
CAKModelBuilder >> defineContainmentsFrom: aSelectorOrBlock to: anotherSelectorOrBlock on: aModelsCollection [

	aModelsCollection do: [:aModel | self containmentDefinitions add: (CAKAssociationDef on: aModel from: aSelectorOrBlock to: anotherSelectorOrBlock) ].

]

{ #category : #accessing }
CAKModelBuilder >> entitiesCache [
	^ self model entitiesCache
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
	| result |
	result := self entitiesCache at: anObject ifAbsent: [nil].
	result isNil
		ifTrue: [^OrderedCollection new].
	
	^OrderedCollection with: result
	
]

{ #category : #'as yet unclassified' }
CAKModelBuilder >> findEntitiesFor: aCollectionOfModels [
	| result |

	aCollectionOfModels isCollection
				ifTrue: [ result := self findCakEntitiesFor: aCollectionOfModels ]
				ifFalse: [ result := self findCakEntityFor: aCollectionOfModels ].
	^result
]

{ #category : #accessing }
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
CAKModelBuilder >> initialize [ 

	super initialize.

	cakModel := CAKModel new.
	associationsDefinition := OrderedCollection new. 
	containmentsDefinition := OrderedCollection new.
	
	^self
]

{ #category : #'as yet unclassified' }
CAKModelBuilder >> instanciateAssociationFrom: aDictionary [
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
			cakEntity entityName: anEntity name.
			cakEntity model: anEntity.
			self model add: cakEntity.
			cakEntity ].

	^ nodes
]
