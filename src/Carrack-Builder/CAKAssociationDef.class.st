Class {
	#name : #CAKAssociationDef,
	#superclass : #Object,
	#instVars : [
		'model',
		'from',
		'to'
	],
	#category : #'Carrack-Builder'
}

{ #category : #'as yet unclassified' }
CAKAssociationDef class >> on: aModel from: aSelectorOrBlock to: anotherSelectorOrBlock [

	^self new
		model: aModel;
		from: aSelectorOrBlock;
		to: anotherSelectorOrBlock.
]

{ #category : #accessing }
CAKAssociationDef >> from [
	^ from
]

{ #category : #accessing }
CAKAssociationDef >> from: aSelectorOrBlock [
	from := aSelectorOrBlock
]

{ #category : #accessing }
CAKAssociationDef >> model [
	^ model
]

{ #category : #accessing }
CAKAssociationDef >> model: aModel [
	model := aModel
]

{ #category : #accessing }
CAKAssociationDef >> to [
	^ to
]

{ #category : #accessing }
CAKAssociationDef >> to: aSelectorOrBlock [
	to := aSelectorOrBlock
]
