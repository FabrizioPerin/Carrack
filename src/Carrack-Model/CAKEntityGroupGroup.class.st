Class {
	#name : #CAKEntityGroupGroup,
	#superclass : #MooseGroup,
	#category : #'Carrack-Model'
}

{ #category : #meta }
CAKEntityGroupGroup class >> annotation [
	<MSEClass: #CAKEntityGroupGroup super: #MooseGroup>
	<package: #'Carrack-Model'>
	^self
]

{ #category : #'as yet unclassified' }
CAKEntityGroupGroup >> types [
	<navigation: 'types'>
	^ self entities collect: [:each | each type]
]
