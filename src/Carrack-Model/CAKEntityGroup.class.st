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
	^ type
]

{ #category : #accessing }
CAKEntityGroup >> type: aStringOrClass [
	type := aStringOrClass
]
