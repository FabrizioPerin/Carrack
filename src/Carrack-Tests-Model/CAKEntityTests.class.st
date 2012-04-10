Class {
	#name : #CAKEntityTests,
	#superclass : #TestCase,
	#category : #'Carrack-Tests-Model'
}

{ #category : #'as yet unclassified' }
CAKEntityTests >> testContainerEntitiesWithTarget [
	| entity containment targetEntity |
	
	entity := CAKEntity new.
	targetEntity := CAKEntity new.
	containment := CAKContainment new.
	 
	self assert: (entity containerEntities isMemberOf: OrderedCollection). 
	self assert: entity containerEntities size equals: 0.

	entity addContainerEntity: containment.
	containment container: targetEntity.

	self assert: (entity containerEntities isMemberOf: OrderedCollection). 
	self assert: entity containerEntities size equals: 1.
	self assert: entity containerEntities first equals: targetEntity.
	
	
	
]

{ #category : #'as yet unclassified' }
CAKEntityTests >> testContainerEntitiesWithoutTarget [
	| entity containment targetEntity |
	
	entity := CAKEntity new.
	containment := CAKContainment new.
	 
	self assert: (entity containerEntities isMemberOf: OrderedCollection). 
	self assert: entity containerEntities size equals: 0.

	entity addContainerEntity: containment.
	
	self assert: (entity containers isMemberOf: FMMultivalueLink).
	self assert: entity containers size equals: 1.
	self assert: (entity containerEntities isMemberOf: OrderedCollection). 
	self assert: entity containerEntities size equals: 0.
	
	
]

{ #category : #'as yet unclassified' }
CAKEntityTests >> testContainers [
	| entity containment |
	
	entity := CAKEntity new.
	containment := CAKContainment new.
	
	self assert: (entity isMemberOf: CAKEntity).
 
	self assert: (entity containers isMemberOf: FMMultivalueLink). 
	self assert: entity containers size equals: 0.

	entity addContainerEntity: containment.

	self assert: (entity containers isMemberOf: FMMultivalueLink). 
	self assert: entity containers size equals: 1.
	self assert: entity containers first equals: containment.
	
	
	
]

{ #category : #'as yet unclassified' }
CAKEntityTests >> testContents [
	| entity containment |
	
	entity := CAKEntity new.
	containment := CAKContainment new.
	
	self assert: (entity isMemberOf: CAKEntity).
 
	self assert: (entity contents isMemberOf: FMMultivalueLink). 
	self assert: entity contents size equals: 0.

	entity addContainedEntity: containment.

	self assert: (entity contents isMemberOf: FMMultivalueLink). 
	self assert: entity contents size equals: 1.
	self assert: entity contents first equals: containment.
	
	
	
]

{ #category : #'as yet unclassified' }
CAKEntityTests >> testEntityCreation [
	| entity |
	
	entity := CAKEntity new.
	
	self assert: (entity isMemberOf: CAKEntity).
	
	self assert: (entity outgoingAssociations isMemberOf: FMMultivalueLink). 
	self assert: entity outgoingAssociations size equals: 0.
	self assert: (entity incomingAssociations isMemberOf: FMMultivalueLink).
	self assert: entity incomingAssociations size equals: 0.

	self assert: (entity containers isMemberOf: FMMultivalueLink). 
	self assert: entity containers size equals: 0.
	self assert: (entity contents isMemberOf: FMMultivalueLink).
	self assert: entity contents size equals: 0.
]

{ #category : #'as yet unclassified' }
CAKEntityTests >> testIncomingAssociationEntitiesWithTarget [
	| entity association targetEntity |
	
	entity := CAKEntity new.
	association := CAKAssociation new.
	targetEntity := CAKEntity new.
	
	self assert: (entity isMemberOf: CAKEntity).
 
	self assert: (entity incomingAssociationEntities isMemberOf: OrderedCollection). 
	self assert: entity incomingAssociationEntities size equals: 0.

	entity addIncomingAssociation: association.
	association associationSource: targetEntity. 

	self assert: (entity incomingAssociations isMemberOf: FMMultivalueLink). 
	self assert: entity incomingAssociations size equals: 1.
	self assert: (entity incomingAssociationEntities isMemberOf: OrderedCollection).
	self assert: entity incomingAssociationEntities size equals: 1.
	self assert: entity incomingAssociationEntities first equals: targetEntity.
]

{ #category : #'as yet unclassified' }
CAKEntityTests >> testIncomingAssociationEntitiesWithoutTarget [
	| entity association |
	
	entity := CAKEntity new.
	association := CAKAssociation new.
	
	self assert: (entity isMemberOf: CAKEntity).
 
	self assert: (entity incomingAssociationEntities isMemberOf: OrderedCollection). 
	self assert: entity incomingAssociationEntities size equals: 0.

	entity addIncomingAssociation: association.

	self assert: (entity incomingAssociations isMemberOf: FMMultivalueLink). 
	self assert: entity incomingAssociations size equals: 1.
	self assert: (entity incomingAssociationEntities isMemberOf: OrderedCollection).
	self assert: entity incomingAssociationEntities size equals: 0.
]

{ #category : #'as yet unclassified' }
CAKEntityTests >> testIncomingAssociations [
	| entity association |
	
	entity := CAKEntity new.
	association := CAKAssociation new.
	
	self assert: (entity isMemberOf: CAKEntity).
 
	self assert: (entity incomingAssociations isMemberOf: FMMultivalueLink). 
	self assert: entity incomingAssociations size equals: 0.

	entity addIncomingAssociation: association.

	self assert: (entity incomingAssociations isMemberOf: FMMultivalueLink). 
	self assert: entity incomingAssociations size equals: 1.
	self assert: entity incomingAssociations first equals: association.
	
	
	
]

{ #category : #'as yet unclassified' }
CAKEntityTests >> testModel [
	| entity anObject |
	
	entity := CAKEntity new.
	anObject := Object new.
	
	self assert: (entity isMemberOf: CAKEntity).
 	self assert: entity model equals: nil.
	
	entity model: anObject.
	
	self assert: entity model equals: anObject.
]

{ #category : #'as yet unclassified' }
CAKEntityTests >> testOutgoingAssociations [
	| entity association |
	
	entity := CAKEntity new.
	association := CAKAssociation new.
	
	self assert: (entity isMemberOf: CAKEntity).
 
	self assert: (entity outgoingAssociations isMemberOf: FMMultivalueLink). 
	self assert: entity outgoingAssociations size equals: 0.
	
	entity addOutgoingAssociation: association.
	
	self assert: (entity outgoingAssociations isMemberOf: FMMultivalueLink). 
	self assert: entity outgoingAssociations size equals: 1.
	self assert: entity outgoingAssociations first equals: association.
	
	
	
]

{ #category : #'as yet unclassified' }
CAKEntityTests >> testPrintOn [
	| entity anObject aStream |
	
	entity := CAKEntity new.
	aStream := ReadWriteStream on: ''.
	entity printOn: aStream.
	
	self assert: aStream contents equals: 'a CAKEntity #noname model: nil'.

	anObject := Object new.
	aStream := ReadWriteStream on: ''.
	
	entity model: anObject.
	entity printOn: aStream.
	
	self assert: aStream contents equals: 'a CAKEntity #noname model: an Object'
]
