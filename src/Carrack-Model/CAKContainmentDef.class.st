Class {
	#name : #CAKContainmentDef,
	#superclass : #Object,
	#instVars : [
		'model',
		'from',
		'to'
	],
	#category : #'Carrack-Model'
}

{ #category : #'as yet unclassified' }
CAKContainmentDef class >> on: aModel from: aSelectorOrBlock to: anotherSelectorOrBlock [

	^self new
		model: aModel;
		from: aSelectorOrBlock;
		to: anotherSelectorOrBlock.
]

{ #category : #accessing }
CAKContainmentDef >> from [
	^ from
]

{ #category : #accessing }
CAKContainmentDef >> from: aSelectorOrBlock [
	from := aSelectorOrBlock
]

{ #category : #accessing }
CAKContainmentDef >> model [
	^ model
]

{ #category : #accessing }
CAKContainmentDef >> model: aModel [
	model := aModel
]

{ #category : #accessing }
CAKContainmentDef >> to [
	^ to
]

{ #category : #accessing }
CAKContainmentDef >> to: aSelectorOrBlock [
	to := aSelectorOrBlock
]
