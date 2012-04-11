Class {
	#name : #CAKFakeContentObject,
	#superclass : #CAKFakeObject,
	#instVars : [
		'fakeAssociation'
	],
	#category : #'Carrack-Tests-Resources'
}

{ #category : #accessing }
CAKFakeContentObject >> fakeAssociation [
	^ fakeAssociation
]

{ #category : #accessing }
CAKFakeContentObject >> fakeAssociation: anObject [
	fakeAssociation := anObject
]

{ #category : #'as yet unclassified' }
CAKFakeContentObject >> initialize [
	super initialize.
	
	fakeAssociation := OrderedCollection new.
	
	^self
]
