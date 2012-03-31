Class {
	#name : #CAKModelBuilderTests,
	#superclass : #TestCase,
	#category : #'Carrack-Tests-Model'
}

{ #category : #'as yet unclassified' }
CAKModelBuilderTests >> testModelBuilderCreation [
	| builder |

	builder := CAKModelBuilder new.
	
	self assert: (builder isMemberOf: CAKModelBuilder).
	self assert: (builder model isMemberOf: CAKModel).
]

{ #category : #'as yet unclassified' }
CAKModelBuilderTests >> testNodes [
	| builder anotherObject anObject |

	builder := CAKModelBuilder new.
	anotherObject := Object new.
	anObject := Object new.
	
	self assert: (builder model isMemberOf: CAKModel).
	self assert: (builder model entities isMemberOf: OrderedCollection).
	self assert: builder model entities size equals: 0.
	
	builder nodes: (OrderedCollection with: anObject with: anotherObject).
	
	self assert: builder model entities size equals: 2.
	self assert: (builder model entities allSatisfy: [:entity | entity isMemberOf: CAKEntity]).
	self assert: (builder model entities anySatisfy: [:entity | entity model = anObject]).
	self assert: (builder model entities anySatisfy: [:entity | entity model = anotherObject]).
]
