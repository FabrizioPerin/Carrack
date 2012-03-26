Class {
	#name : #CAKAssociation,
	#superclass : #CAKAbstractAssociation,
	#instVars : [
		'associationSource',
		'associationTarget'
	],
	#category : #'Carrack-Model'
}

{ #category : #accessing }
CAKAssociation >> associationSource [
	<MSEProperty: #associationSource type: #CAKentity opposite: #outgoingAssociations>
	<MSEComment: 'Carrack entity that is accessed by another carrack entity.'>

	^associationSource
]

{ #category : #accessing }
CAKAssociation >> associationSource: aCarrackEntity [

	associationSource := FMMultivalueLink 
								on: self
								update: #outgoingAssociations
								from: self associationSource  
								to: aCarrackEntity
]

{ #category : #accessing }
CAKAssociation >> associationTarget [
	<MSEProperty: #assocaitionTarget type: #CAKentity opposite: #incomingAssociations>
	<MSEComment: 'Carrack entity that access another carrack entity.'>
	
	^associationTarget
]

{ #category : #accessing }
CAKAssociation >> associationTarget: aCarrackEntity [

	associationTarget := FMMultivalueLink 
								on: self
								update: #incomingAssociations 
								from: self associationTarget  
								to: aCarrackEntity
]

{ #category : #accessing }
CAKAssociation >> from [
	^self associationSource
]

{ #category : #accessing }
CAKAssociation >> to [
	^self associationTarget
]
