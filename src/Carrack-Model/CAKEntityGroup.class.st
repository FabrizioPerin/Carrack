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
	<MSEClass: #EntityGroup super: #MooseGroup>
	<package: #CAK>
	^self
]

{ #category : #accessing }
CAKEntityGroup >> allContainmentRelations [
	^self flatCollect: [:each | each contents].
]

{ #category : #accessing }
CAKEntityGroup >> allOutgoingAssociations [
	^self flatCollect: [:each | each outgoingAssociations].
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
CAKEntityGroup >> mooseDisplayStringOn: aStream [
	self description: 'Group of ', self type asString.
	super mooseDisplayStringOn: aStream
]

{ #category : #accessing }
CAKEntityGroup >> type [
	<MSEProperty: #type type: #String>
	<MSEComment: 'Type of the elements contained into this group'>
	(type isNil and: [self isEmpty not])
		ifTrue: [self type: self first class name].
	^ type
]

{ #category : #accessing }
CAKEntityGroup >> type: aStringOrClass [
	type := aStringOrClass
]
