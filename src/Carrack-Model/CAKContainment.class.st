Class {
	#name : #CAKContainment,
	#superclass : #CAKAbstractAssociation,
	#instVars : [
		'container',
		'content'
	],
	#category : #'Carrack-Model'
}

{ #category : #'as yet unclassified' }
CAKContainment class >> annotation [
	<MSEClass: #CAKContainment super: #CAKAbstractAssociation>
	<package: #'Carrack-Model'>
	^self
]

{ #category : #'as yet unclassified' }
CAKContainment >> container [
	<MSEProperty: #container type: #CAKEntity opposite: #contents>
	<MSEComment: 'Carrack entity contains another carrack entity.'>
	
	^container
]

{ #category : #'as yet unclassified' }
CAKContainment >> container: aCarrackEntity [
	
	container := FMMultivalueLink
					on: self
					update: #contents
					from: self container
					to: aCarrackEntity
]

{ #category : #'as yet unclassified' }
CAKContainment >> content [
	<MSEProperty: #content type: #CAKEntity opposite: #containers>
	<MSEComment: 'Carrack entity that is contained in another carrack entity.'>
	
	^content
]

{ #category : #accessing }
CAKContainment >> content: aCarrackEntity [

	content := FMMultivalueLink 
					on: self
					update: #containers
					from: self content  
					to: aCarrackEntity
]

{ #category : #'as yet unclassified' }
CAKContainment >> from [
	^self container
]

{ #category : #'as yet unclassified' }
CAKContainment >> to [
	^self content
]
