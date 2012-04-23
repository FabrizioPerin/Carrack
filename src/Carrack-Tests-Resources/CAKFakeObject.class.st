Class {
	#name : #CAKFakeObject,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'Carrack-Tests-Resources'
}

{ #category : #accessing }
CAKFakeObject >> name [
	^name
]

{ #category : #accessing }
CAKFakeObject >> name: anObject [
	name := anObject
]
