Class {
	#name : #CAKModelBuilderOldTests,
	#superclass : #TestCase,
	#category : #'Carrack-Tests-OldModel'
}

{ #category : #'as yet unclassified' }
CAKModelBuilderOldTests >> testAssociationSelectors [
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
CAKModelBuilderOldTests >> testConsistencyCheck [
	| builder cakContainer cakContent1 cakContent2 cakFakObj1 cakFakObj2 types |

	builder := CAKModelBuilder new.
	cakContainer := CAKFakeContainerObject new.
	cakContent1 := CAKFakeContentObject new.
	cakContent2 := CAKFakeContentObject new.

	builder nodes: (OrderedCollection with: cakContainer with: cakContent1 with: cakContent2).
	
	builder defineContainement: #fakeContainment from: #CAKFakeContainerObject to: #CAKFakeContentObject.
			
	self assert: (builder consistencyCheck: builder identifyTypes).
]

{ #category : #'as yet unclassified' }
CAKModelBuilderOldTests >> testConsistencyCheckDeny [
	| builder cakContainer cakContent1 cakContent2 cakFakObj1 cakFakObj2 types |

	builder := CAKModelBuilder new.
	cakContainer := CAKFakeContainerObject new.
	cakContent1 := CAKFakeContentObject new.
	cakContent2 := CAKFakeContentObject new.
	cakFakObj1 := CAKFakeObject new.
	cakFakObj2 := CAKFakeObject new.

	builder nodes: (OrderedCollection with: cakContainer with: cakContent1 with: cakContent2 with: cakFakObj1 with: cakFakObj2).
	
	builder defineContainement: #fakeContainment from: #CAKFakeContainerObject to: #CAKFakeContentObject.
			
	self deny: (builder consistencyCheck: builder identifyTypes).
]

{ #category : #'as yet unclassified' }
CAKModelBuilderOldTests >> testContainmentSelectors [
	| model containment1 containment2 |
	
	model := CAKModelBuilder new.
	
	self assert: (model containmentSelectors isMemberOf: OrderedCollection).
	self assert: model containmentSelectors size equals: 0.

	model containmentSelectors add: (OrderedCollection with: #aSelector with: #aClassName with: #anotherClassName).
	model containmentSelectors add: (OrderedCollection with: #aSelector with: #aClassName with: #anotherClassName).
	
	self assert: (model containmentSelectors isMemberOf: OrderedCollection).
	self assert: model containmentSelectors size equals: 2.
	
]

{ #category : #'as yet unclassified' }
CAKModelBuilderOldTests >> testCreateAssociationRelations [
	| builder cakFakeContainer fakeTarget1 fakeTarget2 containmentRelations |
	
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
CAKModelBuilderOldTests >> testCreateAssociationRelationsOnTwoLevels [
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
CAKModelBuilderOldTests >> testCreateContainmentRelations [
	| builder cakFakeContainer fakeTarget1 fakeTarget2 containmentRelations |
	
	builder := CAKModelBuilder new.
	cakFakeContainer := CAKFakeContainerObject new.
	fakeTarget1 := CAKFakeContentObject new.
	fakeTarget2 := CAKFakeContentObject new.
	cakFakeContainer fakeContainment add: fakeTarget1.
	cakFakeContainer fakeContainment add: fakeTarget2.
	
	builder nodes: (OrderedCollection with: cakFakeContainer with: fakeTarget1 with: fakeTarget2).
	builder cacheEntities.
	
	builder defineContainement: #fakeContainment from: #CAKFakeContainerObject to: #CAKFakeContentObject.
	
	containmentRelations := builder createContainmentRelations: builder identifyTypes.
	
	self assert: (containmentRelations isMemberOf: MooseGroup). 
	self assert: containmentRelations size = 2.
	self assert: (containmentRelations allSatisfy: [:each | each isMemberOf: CAKContainment]).
	self assert: containmentRelations first container model equals: cakFakeContainer.
	self assert: (containmentRelations first content model = fakeTarget1 or: [ containmentRelations first content model = fakeTarget2 ]).
	self assert: (containmentRelations second content model = fakeTarget1 or: [ containmentRelations second content model = fakeTarget2 ]).
]

{ #category : #'as yet unclassified' }
CAKModelBuilderOldTests >> testDefineAssociationSelectorFromTo [
	| builder |
	
	builder := CAKModelBuilder new.
	
	builder defineAssociation: #aSelector from: #aClassName to: #anotherClassName.
	
	self assert: builder associationSelectors size equals: 1.
	self assert: builder associationSelectors first first equals: #aClassName.
	self assert: builder associationSelectors first second equals: #anotherClassName.
	self assert: builder associationSelectors first third equals: #aSelector.
	
]

{ #category : #'as yet unclassified' }
CAKModelBuilderOldTests >> testDefineContainerSelectorFromTo [
	| builder |
	
	builder := CAKModelBuilder new.
	
	builder defineContainement: #aSelector from: #aClassName to: #anotherClassName.
	
	self assert: builder containmentSelectors size equals: 1.
	self assert: builder containmentSelectors first first equals: #aClassName.
	self assert: builder containmentSelectors first second equals: #anotherClassName.
	self assert: builder containmentSelectors first third equals: #aSelector.
	
]

{ #category : #'as yet unclassified' }
CAKModelBuilderOldTests >> testFindCakEntityFor [
	| builder cakContainer cakContent1 cakContent2 cakFakObj1 cakFakObj2 types |

	builder := CAKModelBuilder new.
	cakContainer := CAKFakeContainerObject new.
	cakContent1 := CAKFakeContentObject new.
	cakContent2 := CAKFakeContentObject new.
	cakFakObj1 := CAKFakeObject new.
	cakFakObj2 := CAKFakeObject new.

	builder nodes: (OrderedCollection with: cakContainer with: cakContent1 with: cakContent2 with: cakFakObj1 with: cakFakObj2).
	
	builder defineContainement: #fakeContainment from: #CAKFakeContainerObject to: #CAKFakeContentObject.
			
	self deny: (builder consistencyCheck: builder identifyTypes).
	
]

{ #category : #'as yet unclassified' }
CAKModelBuilderOldTests >> testFindCakEntityForFail [
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
CAKModelBuilderOldTests >> testFindCakEntityForSuccess [
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
CAKModelBuilderOldTests >> testIdentifyTypes [
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
CAKModelBuilderOldTests >> testInferAssociationsOn [
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
	
	builder defineContainement: #fakeContainment from: #CAKFakeContainerObject to: #CAKFakeContentObject.
	builder defineAssociation: #fakeAssociation from: #CAKFakeContentObject to: #CAKFakeObject.
	
	types := builder identifyTypes.
	
	"self assert: (builder consistencyCheck: types)."
	
	self assert: builder model allAssociations size equals: 0.
	builder cacheEntities.
	
	builder createContainmentRelations: types.
	builder createAssociationRelations: types.
	
	self assert: builder model allAssociations size equals: 2.
	
	builder inferAssociationRelations.
	
	self assert: builder model allAssociations size equals: 3.
]

{ #category : #'as yet unclassified' }
CAKModelBuilderOldTests >> testModelBuilderCreation [
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
CAKModelBuilderOldTests >> testNode [
	| builder anotherObject anObject |

	builder := CAKModelBuilder new.
	anObject := Object new.	
	builder node: anObject.
	
	self assert: builder model entities size equals: 1.
	self assert: (builder model entities first isMemberOf: CAKEntity).
	self assert: builder model entities first model equals: anObject.

]

{ #category : #'as yet unclassified' }
CAKModelBuilderOldTests >> testNodes [
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
