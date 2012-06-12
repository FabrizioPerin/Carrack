Class {
	#name : #CAKModelBuilderTheRevengeTests,
	#superclass : #TestCase,
	#category : #'Carrack-Tests-OldModel'
}

{ #category : #'as yet unclassified' }
CAKModelBuilderTheRevengeTests >> testCreateContainment [
	| nodes containmentRelations associationRelations builder |
	
	nodes := #(1 2 3 4).
	containmentRelations := OrderedCollection with: #(1 2) with: #(3 4).
	associationRelations := OrderedCollection with: #(3 4).
	
	builder := CAKModelBuilderTheRevenge new.
	
	builder nodes: nodes.
	
	builder defineContainemntFor: nodes with: [:each | each ]. 
	
	self assert: (builder model nodes isMemberOf: OrderedCollection).
	self assert: builder model nodes size equals: 4.

	
]

{ #category : #'as yet unclassified' }
CAKModelBuilderTheRevengeTests >> testCreateContainmentDirectly [
	| nodes containmentRelations associationRelations builder |
	
	nodes := #(1 2 3 4).
	containmentRelations := OrderedCollection with: #(1 2) with: #(3 4).
	associationRelations := OrderedCollection with: #(3 4).
	
	builder := CAKModelBuilderTheRevenge new.
	
	builder defineContainemnt: containmentRelations from: #first to: #second.
	
	self assert: (builder model containmentRelations isMemberOf: OrderedCollection).
	self assert: builder model containmentRelations size equals: 1.
	self assert: (builder model containmentRelations first isMemberOf: CAKContainment).
	
	
]

{ #category : #'as yet unclassified' }
CAKModelBuilderTheRevengeTests >> testNodeCreation [
	| nodes builder |
	
	nodes := #(1 2 3 4).
	
	builder := CAKModelBuilderTheRevenge new.
	
	builder nodes: nodes.
	
	self assert: (builder model nodes isMemberOf: OrderedCollection).
	self assert: builder model nodes size equals: 4.
]
