Class {
	#name : #CAKModel,
	#superclass : #MooseModel,
	#category : #'Carrack-Model'
}

{ #category : #meta }
CAKModel class >> annotation [
	<MSEClass: #Model super: #MooseModel>
	<package: #CAK>
	^self
]

{ #category : #accessing }
CAKModel >> allAssociations [
	<navigation: 'allAssociations'>
	^self allWithType: CAKAssociation.
]

{ #category : #accessing }
CAKModel >> allContainment [
	<navigation: 'allContainment'>
	^self allWithType: CAKContainment.
]

{ #category : #accessing }
CAKModel >> allEntities [
	<navigation: 'allEntities'>
	^self allWithType: CAKEntity.
]

{ #category : #accessing }
CAKModel >> allEntitiesByType [
	<navigation: 'allEntiesWithType'>
	| types result |
	types := self identifyTypes.

	result := CAKEntityGroupGroup withDescription: 'entities by type'.
	
	types keysAndValuesDo: [:key :value |
		| group |
		group := value asMooseGroup.
		group type: key.
		result add: group].
	MooseModel resetMeta.
	
	^ result
]

{ #category : #accessing }
CAKModel >> allEntitiesOfType: aSymbol [
	| res |
	res := self allEntities select: [:entity | entity model class name = aSymbol ].
	res isEmpty ifFalse: [
		res := res asMooseGroup.
		res type: res first model class name ].

	^res
]

{ #category : #accessing }
CAKModel >> cacheGroups [
	| selectors |
	self privateState flushGroups.
	selectors := self navigationSelectors.
	MooseCustomTask
		runWithProgress: [:bar|
			selectors do: [:sel|
				self perform: sel.
				bar increment]
			]
		description: ('Caching <1p> groups in Moose model' expandMacrosWith: selectors size)
		length: selectors size
]

{ #category : #accessing }
CAKModel >> identifyTypes [
	| types |
	
	types := Dictionary new.
	
	self allEntities do: [ :cakEl | 
		types 
			at: cakEl model class name
			ifPresent: [:value | value add: cakEl] 
			ifAbsent: [types at: cakEl model class name put: (OrderedCollection with: cakEl) ] ].
	
	^ types
]

{ #category : #accessing }
CAKModel >> viewDSMExample3 [
	| dSMMatrix view model |

	view := MOViewRenderer new.
	model := self allEntitiesOfType: #FAMIXClass.
	dSMMatrix := DSMMatrix withNodes: model edges: model allOutgoingAssociations from:#to to: #from.

	ColoredDSM new 
			open: dSMMatrix
			on: view.
	view open
]
