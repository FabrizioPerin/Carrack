Class {
	#name : #CAKModelBuilderTests,
	#superclass : #TestCase,
	#category : #'Carrack-Tests-Model'
}

{ #category : #'as yet unclassified' }
CAKModelBuilderTests >> testAssociationSelectors [
	| model fake1|
	
	model := CAKModelBuilder new.
	
	self assert: (model associationSelectors isMemberOf: OrderedCollection).
	self assert: model associationSelectors size equals: 0.
	
	fake1 := CAKFakeObject new.
	model associationSelectors add: fake1.

	
	self assert: (model associationSelectors isMemberOf: OrderedCollection).
	self assert: model associationSelectors size equals: 1.
	
]

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
CAKModelBuilderTests >> testContainmentSelectors [
	| model containment1 containment2 |
	
	model := CAKModelBuilder new.
	
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
CAKModelBuilderTests >> testCreateAssociationRelations [
	| builder cakFakeContainer fakeTarget1 fakeTarget2 containmentRelations |
	
	builder := CAKModelBuilder new.
	cakFakeContainer := CAKFakeContainerObject new.
	fakeTarget1 := CAKFakeContainedObject new.
	fakeTarget2 := CAKFakeContainedObject new.
	cakFakeContainer fakeContainment add: fakeTarget1.
	cakFakeContainer fakeContainment add: fakeTarget2.
	
	builder nodes: (OrderedCollection with: cakFakeContainer with: fakeTarget1 with: fakeTarget2).
	
	builder defineAssociationSelector: #fakeContainment from: #CAKFakeContainerObject to: #CAKFakeContainedObject.
	
	containmentRelations := builder createAssociationRelations: builder identifyTypes.
	
	self assert: containmentRelations size = 2.
	self assert: containmentRelations first associationSource model equals: cakFakeContainer.
	self assert: (containmentRelations first associationTarget model = fakeTarget1 or: [ containmentRelations first associationTarget model = fakeTarget2 ]).
	self assert: (containmentRelations second associationTarget model = fakeTarget1 or: [ containmentRelations second associationTarget model = fakeTarget2 ]).
]

{ #category : #'as yet unclassified' }
CAKModelBuilderTests >> testCreateContainmentRelations [
	| builder cakFakeContainer fakeTarget1 fakeTarget2 containmentRelations |
	
	builder := CAKModelBuilder new.
	cakFakeContainer := CAKFakeContainerObject new.
	fakeTarget1 := CAKFakeContainedObject new.
	fakeTarget2 := CAKFakeContainedObject new.
	cakFakeContainer fakeContainment add: fakeTarget1.
	cakFakeContainer fakeContainment add: fakeTarget2.
	
	builder nodes: (OrderedCollection with: cakFakeContainer with: fakeTarget1 with: fakeTarget2).
	
	builder defineContainementSelector: #fakeContainment from: #CAKFakeContainerObject to: #CAKFakeContainedObject.
	
	containmentRelations := builder createContainmentRelations: builder identifyTypes.
	
	self assert: containmentRelations size = 2.
	self assert: containmentRelations first container model equals: cakFakeContainer.
	self assert: (containmentRelations first content model = fakeTarget1 or: [ containmentRelations first content model = fakeTarget2 ]).
	self assert: (containmentRelations second content model = fakeTarget1 or: [ containmentRelations second content model = fakeTarget2 ]).
]

{ #category : #'as yet unclassified' }
CAKModelBuilderTests >> testDefineAssociationSelectorFromTo [
	| builder |
	
	builder := CAKModelBuilder new.
	
	builder defineAssociationSelector: #aSelector from: #aClassName to: #anotherClassName.
	
	self assert: builder associationSelectors size equals: 1.
	self assert: builder associationSelectors first first equals: #aClassName.
	self assert: builder associationSelectors first second equals: #anotherClassName.
	self assert: builder associationSelectors first third equals: #aSelector.
	
]

{ #category : #'as yet unclassified' }
CAKModelBuilderTests >> testDefineContainerSelectorFromTo [
	| builder |
	
	builder := CAKModelBuilder new.
	
	builder defineContainementSelector: #aSelector from: #aClassName to: #anotherClassName.
	
	self assert: builder containmentSelectors size equals: 1.
	self assert: builder containmentSelectors first first equals: #aClassName.
	self assert: builder containmentSelectors first second equals: #anotherClassName.
	self assert: builder containmentSelectors first third equals: #aSelector.
	
]

{ #category : #'as yet unclassified' }
CAKModelBuilderTests >> testIdentifyTypes [
	| builder anotherObject anObject collection smallinteger |

	builder := CAKModelBuilder new.
	anObject := CAKFakeContainerObject new.
	collection := OrderedCollection new.
	smallinteger := 1.

	builder nodes: (OrderedCollection with: anObject with: collection with: smallinteger).

	self assert: builder model entities size equals: 3.
	self assert: (builder identifyTypes isMemberOf: Dictionary). 
	self assert: builder identifyTypes keys size equals: 3.
	
	self assert: (builder identifyTypes keys anySatisfy: [:key | key = SmallInteger name]).
	self assert: ((builder identifyTypes at: SmallInteger name) isMemberOf: OrderedCollection).
	self assert: ((builder identifyTypes at: SmallInteger name) first isMemberOf: CAKEntity). 
	self assert: (builder identifyTypes at: SmallInteger name) first model equals: 1.
	
	self assert: (builder identifyTypes keys anySatisfy: [:key | key = CAKFakeContainerObject name]).
	self assert: ((builder identifyTypes at: CAKFakeContainerObject name) isMemberOf: OrderedCollection).
	self assert: ((builder identifyTypes at: CAKFakeContainerObject name) first isMemberOf: CAKEntity). 
	self assert: (builder identifyTypes at: CAKFakeContainerObject name) first model equals: anObject.
	
	self assert: (builder identifyTypes keys anySatisfy: [:key | key = OrderedCollection name]).
	self assert: ((builder identifyTypes at: OrderedCollection name) isMemberOf: OrderedCollection).
	self assert: ((builder identifyTypes at: OrderedCollection name) first isMemberOf: CAKEntity). 
	self assert: (builder identifyTypes at: OrderedCollection name) first model equals: collection.
]

{ #category : #'as yet unclassified' }
CAKModelBuilderTests >> testModelBuilderCreation [
	| builder |

	builder := CAKModelBuilder new.
	
	self assert: (builder isMemberOf: CAKModelBuilder).
	self assert: (builder model isMemberOf: CAKModel).
	self assert: (builder associationSelectors isMemberOf: OrderedCollection). 
	self assert: builder associationSelectors size equals: 0. 
	self assert: (builder containmentSelectors isMemberOf: OrderedCollection). 
	self assert: builder containmentSelectors size equals: 0. 
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
