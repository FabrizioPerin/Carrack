Class {
	#name : #CAKModelTests,
	#superclass : #TestCase,
	#category : #'Carrack-Tests-Model'
}

{ #category : #'as yet unclassified' }
CAKModelTests >> testEntitiesOfType [
	| builder cak cak1 cak2 cakContent cakContent1 |

	builder := CAKModelBuilder new.
	cak := CAKFakeObject new.
	cak1 := CAKFakeObject new.
	cak2 := CAKFakeObject new.
	cakContent := CAKFakeContentObject new.
	cakContent1 := CAKFakeContentObject new.

	builder nodes: (OrderedCollection with: cak with: cak1 with: cak2 with: cakContent1 with: cakContent).
	
	self assert: ((builder model entitiesOfType: #CAKFakeContentObject) isMemberOf: CAKEntityGroup).
	self assert: (builder model entitiesOfType: #CAKFakeContentObject) size equals: 0.
	self assert: ((builder model entitiesOfType: #CAKFakeObject) isMemberOf: CAKEntityGroup).
	self assert: (builder model entitiesOfType: #CAKFakeObject) size equals: 0.
	
	builder createGroups: builder identifyTypes.
	
	self assert: ((builder model entitiesOfType: #CAKFakeContentObject) isMemberOf: CAKEntityGroup).
	self assert: (builder model entitiesOfType: #CAKFakeContentObject) size equals: 2.
	self assert: ((builder model entitiesOfType: #CAKFakeObject) isMemberOf: CAKEntityGroup).
	self assert: (builder model entitiesOfType: #CAKFakeObject) size equals: 3.
]

{ #category : #'as yet unclassified' }
CAKModelTests >> testModelCreation [
	| model |
	
	model := CAKModel new.
	
	self assert: (model isMemberOf: CAKModel).
]
