Class {
	#name : #CAKModelBuilderTests,
	#superclass : #TestCase,
	#category : #'Carrack-Tests-Model'
}

{ #category : #'as yet unclassified' }
CAKModelBuilderTests >> testConsistencyCheck [
	| builder anotherObject anObject collection smallinteger |

	builder := CAKModelBuilder new.
	anObject := Object new.
	collection := OrderedCollection new.
	smallinteger := 1.

	builder nodes: (OrderedCollection with: anObject with: collection with: smallinteger).
	
	builder defineContainementSelector: #fakeContain from: #Object to: #OrderedCollection.
	builder defineContainementSelector: #fakeContain from: #Object to: #SmallInteger.
	
	self assert: (builder consistencyCheck: builder identifyTypes).
]

{ #category : #'as yet unclassified' }
CAKModelBuilderTests >> testIdentifyTypes [
	| builder anotherObject anObject collection smallinteger |

	builder := CAKModelBuilder new.
	anObject := Object new.
	collection := Collection new.
	smallinteger := 1.

	builder nodes: (OrderedCollection with: anObject with: collection with: smallinteger).

	self assert: builder model entities size equals: 3.
	self assert: (builder identifyTypes isMemberOf: Dictionary). 
	self assert: builder identifyTypes keys size equals: 3.
	
	self assert: (builder identifyTypes keys anySatisfy: [:key | key = SmallInteger]).
	self assert: ((builder identifyTypes at: SmallInteger) isMemberOf: OrderedCollection).
	self assert: ((builder identifyTypes at: SmallInteger) first isMemberOf: CAKEntity). 
	self assert: (builder identifyTypes at: SmallInteger) first model equals: 1.
	
	self assert: (builder identifyTypes keys anySatisfy: [:key | key = Object]).
	self assert: ((builder identifyTypes at: Object) isMemberOf: OrderedCollection).
	self assert: ((builder identifyTypes at: Object) first isMemberOf: CAKEntity). 
	self assert: (builder identifyTypes at: Object) first model equals: anObject.
	
	self assert: (builder identifyTypes keys anySatisfy: [:key | key = Collection]).
	self assert: ((builder identifyTypes at: Collection) isMemberOf: OrderedCollection).
	self assert: ((builder identifyTypes at: Collection) first isMemberOf: CAKEntity). 
	self assert: (builder identifyTypes at: Collection) first model equals: collection.
]

{ #category : #'as yet unclassified' }
CAKModelBuilderTests >> testModelBuilderCreation [
	| builder |

	builder := CAKModelBuilder new.
	
	self assert: (builder isMemberOf: CAKModelBuilder).
	self assert: (builder model isMemberOf: CAKModel).
]

{ #category : #'as yet unclassified' }
CAKModelBuilderTests >> testNode [
	| builder anotherObject anObject |

	builder := CAKModelBuilder new.
	anObject := Object new.	
	builder node: anObject.
	
	self assert: builder model entities size equals: 1.
	self assert: (builder model entities first isMemberOf: CAKEntity).
	self assert: builder model entities first model equals: anObject.

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
