Class {
	#name : #CAKEntity,
	#superclass : #MooseEntity,
	#instVars : [
		'outgoingAssociations',
		'containedEntities',
		'containerEntities',
		'incomingAssociations'
	],
	#category : #'Carrack-Model'
}

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
	
]

{ #category : #accessing }
CAKEntity >> outgoingAssociations [
	^ outgoingAssociations
]
