Class {
	#name : #CAKModelTests,
	#superclass : #TestCase,
	#category : #'Carrack-Tests-Model'
}

{ #category : #'as yet unclassified' }
CAKModelTests >> testAssociationSelectors [
	| model association1 association2 |
	
	model := CAKModel new.
	
	self assert: (model associationSelectors isMemberOf: OrderedCollection).
	self assert: model associationSelectors size equals: 0.
	
	association1 := CAKAssociation new.
	association2 := CAKAssociation new.
	model associationSelectors add: association1.
	model associationSelectors add: association2.
	
	self assert: (model associationSelectors isMemberOf: OrderedCollection).
	self assert: model associationSelectors size equals: 2.
	
]

{ #category : #'as yet unclassified' }
CAKModelTests >> testContainmentSelectors [
	| model containment1 containment2 |
	
	model := CAKModel new.
	
	self assert: (model containmentSelectors isMemberOf: OrderedCollection).
	self assert: model containmentSelectors size equals: 0.
	
	containment1 := CAKContainment new.
	containment2 := CAKContainment new.
	model containmentSelectors add: containment1.
	model containmentSelectors add: containment2.
	
	self assert: (model containmentSelectors isMemberOf: OrderedCollection).
	self assert: model containmentSelectors size equals: 2.
	
]

{ #category : #'as yet unclassified' }
CAKModelTests >> testModelCreation [
	| model |
	
	model := CAKModel new.
	
	self assert: (model isMemberOf: CAKModel).
	self assert: (model associationSelectors isMemberOf: OrderedCollection).
	self assert: model associationSelectors size equals: 0.
	self assert: (model containmentSelectors isMemberOf: OrderedCollection).
	self assert: model containmentSelectors size equals: 0.
	
]
