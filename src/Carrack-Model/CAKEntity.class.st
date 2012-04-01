Class {
	#name : #CAKEntity,
	#superclass : #CAKAbstractEntity,
	#instVars : [
		'outgoingAssociations',
		'containedEntities',
		'containerEntities',
		'incomingAssociations',
		'model'
	],
	#category : #'Carrack-Model'
}

{ #category : #'as yet unclassified' }
CAKEntity class >> annotation [
	<MSEClass: #CAKEntity super: #MooseEntity>
	<package: #'Carrack-Model'>
	^self
]

{ #category : #accessing }
CAKEntity >> addContainedEntity: aCAKContainment [
	self containedEntities add: aCAKContainment
]

{ #category : #accessing }
CAKEntity >> addContainerEntity: aCAKContainment [
	self containerEntities add: aCAKContainment
]

{ #category : #accessing }
CAKEntity >> addIncomingAssociation: aCAKAssociation [
	self incomingAssociations add: aCAKAssociation
]

{ #category : #accessing }
CAKEntity >> addOutgoingAssociation: aCAKAssociation [
	self outgoingAssociations add: aCAKAssociation
]

{ #category : #accessing }
CAKEntity >> containedEntities [
	^ containedEntities
]

{ #category : #accessing }
CAKEntity >> containerEntities [
	^ containerEntities
]

{ #category : #accessing }
CAKEntity >> incomingAssociations [
	^ incomingAssociations
]

{ #category : #initialization }
CAKEntity >> initialize [ 
	super initialize.
	
	incomingAssociations := FMMultivalueLink on: self opposite: #associationTarget:.
	outgoingAssociations := FMMultivalueLink on: self opposite: #associationSource:.
	containedEntities := FMMultivalueLink on: self opposite: #container:.
	containerEntities := FMMultivalueLink on: self opposite: #content:.
	
	^self 
]

{ #category : #accessing }
CAKEntity >> model [
	^ model
]

{ #category : #accessing }
CAKEntity >> model: anObject [
	model := anObject
]

{ #category : #initialization }
CAKEntity >> mooseNameOn: aStream [
	self printOn: aStream.
	aStream nextPut: ' '.
	aStream nextPutAll: ' model: '; print: self model
	
]

{ #category : #accessing }
CAKEntity >> outgoingAssociations [
	^ outgoingAssociations
]

{ #category : #initialization }
CAKEntity >> printOn: aStream [
	aStream nextPutAll: self class name.
	
]
