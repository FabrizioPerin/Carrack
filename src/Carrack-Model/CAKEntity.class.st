Class {
	#name : #CAKEntity,
	#superclass : #CAKAbstractEntity,
	#instVars : [
		'outgoingAssociations',
		'containedEntities',
		'containerEntities',
		'incomingAssociations'
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

{ #category : #printing }
CAKEntity >> originalPrintOn: aStream [
	super printOn: aStream
]

{ #category : #accessing }
CAKEntity >> outgoingAssociations [
	^ outgoingAssociations
]

{ #category : #printing }
CAKEntity >> printOn: aStream [
	self originalPrintOn: aStream.
	aStream nextPutAll: ' model: '; print: self model
]
