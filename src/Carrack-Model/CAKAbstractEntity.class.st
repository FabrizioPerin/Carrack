Class {
	#name : #CAKAbstractEntity,
	#superclass : #MooseEntity,
	#instVars : [
		'model'
	],
	#category : #'Carrack-Model'
}

{ #category : #accessing }
CAKAbstractEntity >> model [
	^ model
]

{ #category : #accessing }
CAKAbstractEntity >> model: anObject [
	model := anObject
]
