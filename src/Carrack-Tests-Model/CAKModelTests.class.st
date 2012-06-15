Class {
	#name : #CAKModelTests,
	#superclass : #TestCase,
	#category : #'Carrack-Tests-Model'
}

{ #category : #'as yet unclassified' }
CAKModelTests >> testAllAssociationEntitesFrom [
	| builder source1 source2 target1 target2 model |
	
	builder := CAKModelBuilder new.
	source1 := CAKFakeContentObject new.
	source2 := CAKFakeContentObject new.
	target1 := CAKFakeObject new.
	target2 := CAKFakeObject new.
	
	builder nodes: (OrderedCollection with: source1 with: source2 with: target1 with: target2).
	
	source1 fakeAssociation add: target1.
	source2 fakeAssociation add: target2.
	
	builder defineAssociationsFrom: #yourself to: #fakeAssociation on: (OrderedCollection with: source1 with: source2).
	
	model := builder create model.
	
	self assert: ( ( model allAssociationEntitiesFrom: source1) isMemberOf: OrderedCollection ).
	self assert: ( model allAssociationEntitiesFrom: source1 ) size equals: 1.
	self assert: ( ( model allAssociationEntitiesFrom: source1 ) first isMemberOf: CAKEntity).
	self assert: ( model allAssociationEntitiesFrom: source1 ) first model equals: target1.
	
	self assert: ( ( model allAssociationEntitiesFrom: source2) isMemberOf: OrderedCollection ).
	self assert: ( model allAssociationEntitiesFrom: source2) size equals: 1.
	self assert: ( ( model allAssociationEntitiesFrom: source2 ) first isMemberOf: CAKEntity).
	self assert: ( model allAssociationEntitiesFrom: source2 ) first model equals: target2.
]

{ #category : #'as yet unclassified' }
CAKModelTests >> testAllAssociationsFrom [
	| builder source1 source2 target1 target2 model |
	
	builder := CAKModelBuilder new.
	source1 := CAKFakeContentObject new.
	source2 := CAKFakeContentObject new.
	target1 := CAKFakeObject new.
	target2 := CAKFakeObject new.
	
	builder nodes: (OrderedCollection with: source1 with: source2 with: target1 with: target2).
	
	source1 fakeAssociation add: target1.
	source2 fakeAssociation add: target2.
	
	builder defineAssociationsFrom: #yourself to: #fakeAssociation on: (OrderedCollection with: source1 with: source2).
	
	model := builder create model.
	
	self assert: ( ( model allAssociationsFrom: source1) isMemberOf: FMMultivalueLink ).
	self assert: ( model allAssociationsFrom: source1 ) size equals: 1.
	self assert: ( ( model allAssociationsFrom: source1 ) first isMemberOf: CAKAssociation ).
	self assert: ( model allAssociationsFrom: source1 ) first model equals: source1.
	
	self assert: ( ( model allAssociationsFrom: source2) isMemberOf: FMMultivalueLink ).
	self assert: ( model allAssociationsFrom: source2 ) size equals: 1.
	self assert: ( ( model allAssociationsFrom: source2 ) first isMemberOf: CAKAssociation ).
	self assert: ( model allAssociationsFrom: source2 ) first model equals: source2.
]

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
	
	self assert: ((builder model allEntitiesOfType: #CAKFakeContentObject) isMemberOf: CAKEntityGroup).
	self assert: (builder model allEntitiesOfType: #CAKFakeContentObject) size equals: 2.
	self assert: ((builder model allEntitiesOfType: #CAKFakeObject) isMemberOf: CAKEntityGroup).
	self assert: (builder model allEntitiesOfType: #CAKFakeObject) size equals: 3.
]

{ #category : #'as yet unclassified' }
CAKModelTests >> testModelCreation [
	| model |
	
	model := CAKModel new.
	
	self assert: (model isMemberOf: CAKModel).
]

{ #category : #'as yet unclassified' }
CAKModelTests >> testdrillDownAllAssociationsFrom [
	| builder source1 source2 target1 target2 model |
	
	builder := CAKModelBuilder new.
	source1 := CAKFakeContentObject new.
	source2 := CAKFakeContentObject new.
	target1 := CAKFakeObject new.
	target2 := CAKFakeObject new.
	
	builder nodes: (OrderedCollection with: source1 with: source2 with: target1 with: target2).
	
	source1 fakeAssociation add: target1.
	source2 fakeAssociation add: target2.
	
	builder defineAssociationsFrom: #yourself to: #fakeAssociation on: (OrderedCollection with: source1 with: source2).
	
	model := builder create model.
	
	self assert: ( ( model drillDownAllAssociationsFrom: source1) isMemberOf: OrderedCollection ).
	self assert: ( model drillDownAllAssociationsFrom: source1) size equals: 1.
	self assert: ( model drillDownAllAssociationsFrom: source1) first equals: source1.
	
	self assert: ( ( model drillDownAllAssociationsFrom: source2) isMemberOf: OrderedCollection ).
	self assert: ( model drillDownAllAssociationsFrom: source2) size equals: 1.
	self assert: ( model drillDownAllAssociationsFrom: source2) first equals: source2.
	
	self assert: false.
]

{ #category : #'as yet unclassified' }
CAKModelTests >> testdrillDownAllAssociationsFromGraph [
	| builder model |
	
	builder := CAKModelBuilder new.
	
	builder nodes: #(1 2 3 4 5 6 7).
	
	builder defineContainmentsFrom: #first to: #second on: { #(1 3) . #(2 3) . #(4 5) . #(6 7)}.
	builder defineAssociationsFrom: #key to: #value on: { 3->5 . 3->7 }.
	
	model := builder create model.
	
	self assert: ( model drillDownAllAssociationsFrom: 1 ) isCollection.
	self assert: ( model drillDownAllAssociationsFrom: 1) size equals: 2.
	self assert: ( model drillDownAllAssociationsFrom: 1) first equals: 3->5.
	self assert: ( model drillDownAllAssociationsFrom: 1) second equals: 3->7.
]
