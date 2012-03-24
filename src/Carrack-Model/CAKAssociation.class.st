Class {
	#name : #CAKAssociation,
	#superclass : #CAKAbstractAssociation,
	#instVars : [
		'assciationTarget',
		'associationTarget',
		'assciationSource'
	],
	#category : #'Carrack-Model'
}

{ #category : #accessing }
CAKAssociation >> associationSource [
	^assciationSource
]

{ #category : #accessing }
CAKAssociation >> associationSource: aCarrackEntity [

	assciationSource := FMMultivalueLink 
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

	assciationTarget := FMMultivalueLink 
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
