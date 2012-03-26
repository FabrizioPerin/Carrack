Class {
	#name : #CAKEntityTests,
	#superclass : #TestCase,
	#category : #'Carrack-Tests-Model'
}

{ #category : #'as yet unclassified' }
CAKEntityTests >> testContainedEntities [
	| entity containment |
	
	entity := CAKEntity new.
	containment := CAKContainment new.
	
	self assert: (entity isMemberOf: CAKEntity).
 
	self assert: (entity containedEntities isMemberOf: FMMultivalueLink). 
	self assert: entity containedEntities size equals: 0.

	entity addContainedEntity: containment.

	self assert: (entity containedEntities isMemberOf: FMMultivalueLink). 
	self assert: entity containedEntities size equals: 1.
	self assert: entity containedEntities first equals: containment.
	
	
	
]

{ #category : #'as yet unclassified' }
CAKEntityTests >> testContainerEntities [
	| entity containment |
	
	entity := CAKEntity new.
	containment := CAKContainment new.
	
	self assert: (entity isMemberOf: CAKEntity).
 
	self assert: (entity containerEntities isMemberOf: FMMultivalueLink). 
	self assert: entity containerEntities size equals: 0.

	entity addContainerEntity: containment.

	self assert: (entity containerEntities isMemberOf: FMMultivalueLink). 
	self assert: entity containerEntities size equals: 1.
	self assert: entity containerEntities first equals: containment.
	
	
	
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

	self assert: (entity containerEntities isMemberOf: FMMultivalueLink). 
	self assert: entity containerEntities size equals: 0.
	self assert: (entity containedEntities isMemberOf: FMMultivalueLink).
	self assert: entity containedEntities size equals: 0.
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