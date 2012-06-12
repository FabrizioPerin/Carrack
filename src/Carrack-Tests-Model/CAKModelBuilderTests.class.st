Class {
	#name : #CAKModelBuilderTests,
	#superclass : #TestCase,
	#category : #'Carrack-Tests-Model'
}

{ #category : #'as yet unclassified' }
CAKModelBuilderTests >> testAssociationSelectors [
	| model fake1|
	
	model := CAKModelBuilder new.
	
	self assert: (model associationDefinitions isMemberOf: OrderedCollection).
	self assert: model associationDefinitions size equals: 0.
	
	fake1 := CAKFakeObject new.
	model associationDefinitions add: fake1.

	
	self assert: (model associationDefinitions isMemberOf: OrderedCollection).
	self assert: model associationDefinitions size equals: 1.
	
]

{ #category : #'as yet unclassified' }
CAKModelBuilderTests >> testContainmentSelectors [
	| model containment1 containment2 |
	
	model := CAKModelBuilder new.
	
	self assert: (model containmentDefinitions isMemberOf: OrderedCollection).
	self assert: model containmentDefinitions size equals: 0.

	model containmentDefinitions add: (OrderedCollection with: #aSelector with: #aClassName with: #anotherClassName).
	model containmentDefinitions add: (OrderedCollection with: #aSelector with: #aClassName with: #anotherClassName).
	
	self assert: (model containmentDefinitions isMemberOf: OrderedCollection).
	self assert: model containmentDefinitions size equals: 2.
	
]

{ #category : #'as yet unclassified' }
CAKModelBuilderTests >> testCreateAssociationRelations [
	| builder cakFakeContainer fakeTarget1 fakeTarget2 containmentRelations |
	
	self flag: #TODO.
	
	builder := CAKModelBuilder new.
	cakFakeContainer := CAKFakeContainerObject new.
	fakeTarget1 := CAKFakeContentObject new.
	fakeTarget2 := CAKFakeContentObject new.
	cakFakeContainer fakeContainment add: fakeTarget1.
	cakFakeContainer fakeContainment add: fakeTarget2.
	
	builder nodes: (OrderedCollection with: cakFakeContainer with: fakeTarget1 with: fakeTarget2).
	builder cacheEntities.
	
	builder defineAssociation: #fakeContainment from: #CAKFakeContainerObject to: #CAKFakeContentObject.
	
	containmentRelations := builder createAssociationRelations: builder identifyTypes.
	
	self assert: containmentRelations size = 2.
	self assert: containmentRelations first associationSource model equals: cakFakeContainer.
	self assert: (containmentRelations first associationTarget model = fakeTarget1 or: [ containmentRelations first associationTarget model = fakeTarget2 ]).
	self assert: (containmentRelations second associationTarget model = fakeTarget1 or: [ containmentRelations second associationTarget model = fakeTarget2 ]).
]

{ #category : #'as yet unclassified' }
CAKModelBuilderTests >> testCreateAssociationRelationsOnTwoLevels [
	| cakModel top1 top2 assocs interestingAssoc |
	
	cakModel := FakeModelProvider build cakModelOnModelWithTwoLevels. 
	
	top1 := (cakModel allEntities select: [:each | each entityName = #topContainer1]) first.
	top2 := (cakModel allEntities select: [:each | each entityName = #topContainer2]) first.
	
	self assert: (top1 isMemberOf: CAKEntity).
	self assert: (top2 isMemberOf: CAKEntity).
	
	assocs := cakModel allAssociations.
	
	interestingAssoc := assocs select: [:each | each associationSource = top1].
	
	self assert: (top1 outgoingAssociations isMemberOf: FMMultivalueLink). 
	self assert: top1 outgoingAssociations size = 1.
	self assert: (top1 outgoingAssociations first isMemberOf: CAKAssociation). 
	self assert: top1 outgoingAssociations first to equals: top2.
]

{ #category : #'as yet unclassified' }
CAKModelBuilderTests >> testCreateContainmentRelations [
	| builder cakFakeContainer fakeTarget1 fakeTarget2 containmentRelations |
	
	builder := CAKModelBuilder new.
	cakFakeContainer := CAKFakeContainerObject new.
	fakeTarget1 := CAKFakeContentObject new.
	fakeTarget2 := CAKFakeContentObject new.
	cakFakeContainer fakeContainment add: fakeTarget1.
	cakFakeContainer fakeContainment add: fakeTarget2.
	
	builder nodes: (OrderedCollection with: cakFakeContainer with: fakeTarget1 with: fakeTarget2).
	builder cacheEntities.
	
	builder defineContainmentFrom: #yourself to: #fakeContainment on: cakFakeContainer.
	
	containmentRelations := builder createContainmentRelations.
	
	self assert: (containmentRelations asMooseGroup isMemberOf: MooseGroup). 
	self assert: containmentRelations size = 2.
	self assert: (containmentRelations allSatisfy: [:each | each isMemberOf: CAKContainment]).
	self assert: containmentRelations first container model equals: cakFakeContainer.
	self assert: (containmentRelations first content model = fakeTarget1 or: [ containmentRelations first content model = fakeTarget2 ]).
	self assert: (containmentRelations second content model = fakeTarget1 or: [ containmentRelations second content model = fakeTarget2 ]).
]

{ #category : #'as yet unclassified' }
CAKModelBuilderTests >> testDefineAssociationSelectorFromTo [
	| builder |
	
	builder := CAKModelBuilder new.
	
	self assert: (builder associationDefinitions isMemberOf: OrderedCollection).
	self assert: builder associationDefinitions size equals: 0.
	
	builder defineAssociationFrom: #aSelector to: #anotherClassName on: self.
	
	self assert: builder associationDefinitions size equals: 1.
	self assert: (builder associationDefinitions first isMemberOf: CAKAssociationDef).
	self assert: builder associationDefinitions first from equals: #aSelector.
	self assert: builder associationDefinitions first to equals: #anotherClassName.
	
]

{ #category : #'as yet unclassified' }
CAKModelBuilderTests >> testDefineContainerSelectorFromTo [
	| builder |
	
	builder := CAKModelBuilder new.
	
	self assert: (builder containmentDefinitions isMemberOf: OrderedCollection).
	self assert: builder containmentDefinitions size equals: 0.
	
	builder defineContainmentFrom: #aSelector to: #anotherClassName on: self.
	
	self assert: builder containmentDefinitions size equals: 1.
	self assert: (builder containmentDefinitions first isMemberOf: CAKContainmentDef).
	self assert: builder containmentDefinitions first from equals: #aSelector.
	self assert: builder containmentDefinitions first to equals: #anotherClassName.
	
]

{ #category : #'as yet unclassified' }
CAKModelBuilderTests >> testFindCakEntityFor [
	| builder cakContainer cakContent1 cakContent2 cakFakObj1 cakFakObj2 types |

	self flag: #TODO.

	builder := CAKModelBuilder new.
	cakContainer := CAKFakeContainerObject new.
	cakContent1 := CAKFakeContentObject new.
	cakContent2 := CAKFakeContentObject new.
	cakFakObj1 := CAKFakeObject new.
	cakFakObj2 := CAKFakeObject new.

	builder nodes: (OrderedCollection with: cakContainer with: cakContent1 with: cakContent2 with: cakFakObj1 with: cakFakObj2).
	
	builder defineContainmentFrom: #yourself to: #fakeContainment on: cakContainer.
	

]

{ #category : #'as yet unclassified' }
CAKModelBuilderTests >> testFindCakEntityForFail [
	| builder cakFakeContainer fakeTarget1 fakeTarget2 containmentRelations result |
	
	builder := CAKModelBuilder new.
	cakFakeContainer := CAKFakeContainerObject new.
	fakeTarget1 := CAKFakeContentObject new.
	fakeTarget2 := CAKFakeContentObject new.
	builder nodes: (OrderedCollection with: cakFakeContainer with: fakeTarget1).
	builder cacheEntities.
	
	result := builder findCakEntityFor: fakeTarget2.

	self assert: (result isMemberOf: OrderedCollection). 
	self assert: result size = 0.
]

{ #category : #'as yet unclassified' }
CAKModelBuilderTests >> testFindCakEntityForSuccess [
	| builder cakFakeContainer fakeTarget1 fakeTarget2 containmentRelations result |
	
	builder := CAKModelBuilder new.
	cakFakeContainer := CAKFakeContainerObject new.
	fakeTarget1 := CAKFakeContentObject new.
	fakeTarget2 := CAKFakeContentObject new.
	builder nodes: (OrderedCollection with: cakFakeContainer with: fakeTarget1 with: fakeTarget2).
	builder cacheEntities.
	
	result := builder findCakEntityFor: fakeTarget2.

	self assert: (result isMemberOf: OrderedCollection). 
	self assert: result size = 1.
	self assert: (result first isMemberOf: CAKEntity).
	self assert: result first model equals: fakeTarget2.
	
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
CAKModelBuilderTests >> testInferAssociationsOn [
	| builder cakContainer1 cakContainer2 cakContent1 cakContent2 cakFakObj1 cakFakObj2 types |

	builder := CAKModelBuilder new.
	cakContainer1 := CAKFakeContainerObject new.
	cakContent1 := CAKFakeContentObject new.
	cakContent2 := CAKFakeContentObject new.
	cakContainer1 fakeContainment add: cakContent1.
	cakContainer1 fakeContainment add: cakContent2.
	cakContainer2 := CAKFakeContainerObject new.
	cakFakObj1 := CAKFakeObject new.
	cakFakObj2 := CAKFakeObject new.
	cakContainer2 fakeContainment add: cakFakObj1.
	cakContainer2 fakeContainment add: cakFakObj2.
	
	cakContent1 fakeAssociation add: cakFakObj1.
	cakContent1 fakeAssociation add: cakFakObj2.
	
	builder nodes: (OrderedCollection with: cakContainer1 with: cakContent1 with: cakContent2 with: cakContainer2 with: cakFakObj1 with: cakFakObj2).

	builder defineContainmentFrom: #yourself to: #fakeContainment on: (Array with: cakContainer1 with: cakContainer2).
	builder defineAssociationFrom: #yourself to: #fakeAssociation on: (Array with: cakContent1 with: cakContent2).
	
	
	types := builder identifyTypes.
	
	"self assert: (builder consistencyCheck: types)."
	
	self assert: builder model allAssociations size equals: 0.
	builder cacheEntities.
	
	builder createContainmentRelations.
	builder createAssociationRelations.
	
	self assert: builder model allAssociations size equals: 2.
	
	builder inferAssociationRelations.
	
	self assert: builder model allAssociations size equals: 3.
]

{ #category : #'as yet unclassified' }
CAKModelBuilderTests >> testModelBuilderCreation [
	| builder |

	builder := CAKModelBuilder new.
	
	self assert: (builder isMemberOf: CAKModelBuilder).
	self assert: (builder model isMemberOf: CAKModel).
	self assert: (builder associationDefinitions isMemberOf: OrderedCollection). 
	self assert: builder associationDefinitions size equals: 0. 
	self assert: (builder containmentDefinitions isMemberOf: OrderedCollection). 
	self assert: builder containmentDefinitions size equals: 0. 
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
