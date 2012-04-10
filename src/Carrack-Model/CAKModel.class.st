Class {
	#name : #CAKModel,
	#superclass : #MooseModel,
	#category : #'Carrack-Model'
}

{ #category : #'as yet unclassified' }
CAKModel class >> annotation [
	<MSEClass: #CAKModel super: #MooseAbstractGroup>
	<package: #'Carrack-Model'>
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
CAKModel >> allGroups [
	^self allWithType: CAKEntityGroup.
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
CAKModel >> entitiesOfType: aSymbol [
	^self allGroups detect: [:group | group type = aSymbol] ifNone: [CAKEntityGroup new]
]
