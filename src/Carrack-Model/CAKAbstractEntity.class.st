Class {
	#name : #CAKAbstractEntity,
	#superclass : #MooseEntity,
	#instVars : [
		'model'
	],
	#category : #'Carrack-Model'
}

{ #category : #'as yet unclassified' }
CAKAbstractEntity class >> annotation [
	<MSEClass: #AbstractEntity super: #Object>
	<package: #CAK>
	^self
]

{ #category : #accessing }
CAKAbstractEntity >> model [
	^ model
]

{ #category : #accessing }
CAKAbstractEntity >> model: anObject [
	model := anObject
]

{ #category : #accessing }
CAKAbstractEntity >> mooseDisplayStringOn: aStream [
	self printOn: aStream
]
