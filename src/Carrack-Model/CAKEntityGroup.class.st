Class {
	#name : #CAKEntityGroup,
	#superclass : #MooseGroup,
	#instVars : [
		'type',
		'isLeaf',
		'isRoot'
	],
	#category : #'Carrack-Model'
}

{ #category : #meta }
CAKEntityGroup class >> annotation [
	<MSEClass: #CAKEntityGroup super: #MooseGroup>
	<package: #'Carrack-Model'>
	^self
]

{ #category : #accessing }
CAKEntityGroup >> isLeaf [
	^ isLeaf
]

{ #category : #accessing }
CAKEntityGroup >> isLeaf: aBoolean [
	isLeaf := aBoolean
]

{ #category : #accessing }
CAKEntityGroup >> isRoot [
	^ isRoot
]

{ #category : #accessing }
CAKEntityGroup >> isRoot: aBoolean [
	isRoot := aBoolean
]

{ #category : #accessing }
CAKEntityGroup >> type [
	<MSEProperty: #type type: #String>
	<MSEComment: 'Type of the elements contained into this group'>
	^ type
]

{ #category : #accessing }
CAKEntityGroup >> type: aStringOrClass [
	type := aStringOrClass
]
