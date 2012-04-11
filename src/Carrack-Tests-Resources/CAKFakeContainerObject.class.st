Class {
	#name : #CAKFakeContainerObject,
	#superclass : #CAKFakeObject,
	#instVars : [
		'fakeContainment'
	],
	#category : #'Carrack-Tests-Resources'
}

{ #category : #'as yet unclassified' }
CAKFakeContainerObject >> fakeContainment [
	
	^fakeContainment
]

{ #category : #accessing }
CAKFakeContainerObject >> fakeContainment: anObject [
	fakeContainment := anObject
]

{ #category : #accessing }
CAKFakeContainerObject >> initialize [
	super initialize.
	
	fakeContainment := OrderedCollection new.
	
	^self 
]
