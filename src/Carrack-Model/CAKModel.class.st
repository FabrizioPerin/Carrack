Class {
	#name : #CAKModel,
	#superclass : #MooseAbstractGroup,
	#instVars : [
		'containmentSelectors',
		'associationSelectors'
	],
	#category : #'Carrack-Model'
}

{ #category : #'as yet unclassified' }
CAKModel class >> annotation [
	<MSEClass: #CAKModel super: #MooseAbstractGroup>
	<package: #'Carrack-Model'>
	^self
]

{ #category : #accessing }
CAKModel >> associationSelectors [
	^ associationSelectors
]

{ #category : #accessing }
CAKModel >> associationSelectors: anObject [
	associationSelectors := anObject
]

{ #category : #accessing }
CAKModel >> containmentSelectors [
	^ containmentSelectors
]

{ #category : #accessing }
CAKModel >> containmentSelectors: anObject [
	containmentSelectors := anObject
]

{ #category : #accessing }
CAKModel >> initialize [
	super initialize.
	
	associationSelectors := OrderedCollection new. 
	containmentSelectors := OrderedCollection new.

	^self
]
