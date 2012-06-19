Class {
	#name : #CAKAssociation,
	#superclass : #CAKAbstractAssociation,
	#instVars : [
		'associationSource',
		'associationTarget'
	],
	#category : #'Carrack-Model'
}

{ #category : #'as yet unclassified' }
CAKAssociation class >> annotation [
	<MSEClass: #Association super: #CAKAbstractAssociation>
	<package: #CAK>
	^self
]

{ #category : #accessing }
CAKAssociation >> associationSource [
	<MSEProperty: #associationSource type: #CAKEntity opposite: #outgoingAssociations>
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
	<MSEProperty: #associationTarget type: #CAKEntity opposite: #incomingAssociations>
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
CAKAssociation >> drillDownUntilLowestLevel [

	( self model isCollection and: self model isArray not )
		ifTrue: [^ self model collect: [:each | each drillDownUntilLowestLevel ] ]
		ifFalse: [^ self model]
]

{ #category : #accessing }
CAKAssociation >> from [
	^self associationSource
]

{ #category : #accessing }
CAKAssociation >> hasBeenInfered [
	^self model isCollection and: [self model size > 0 and: [self model first isMemberOf: CAKAssociation]]
]

{ #category : #accessing }
CAKAssociation >> to [
	^self associationTarget
]
