Class {
	#name : #CAKModelBuilder,
	#superclass : #Object,
	#instVars : [
		'cakModel'
	],
	#category : #'Carrack-Model'
}

{ #category : #'as yet unclassified' }
CAKModelBuilder >> defineAssociationSelector: aSelector from: aClassName to: anotherClassName [

	self model associationSelectors add: (OrderedCollection with: aClassName with: anotherClassName with: aSelector). 


]

{ #category : #'as yet unclassified' }
CAKModelBuilder >> defineContainementSelector: aSelector from: aClassName to: anotherClassName [

	self model containmentSelectors add: (OrderedCollection with: aClassName with: anotherClassName with: aSelector). 


]

{ #category : #'as yet unclassified' }
CAKModelBuilder >> initialize [ 

	super initialize.

	cakModel := CAKModel new.
]

{ #category : #'as yet unclassified' }
CAKModelBuilder >> model [
	^cakModel
]

{ #category : #'as yet unclassified' }
CAKModelBuilder >> model: aCAKModel [
	cakModel := aCAKModel.
]

{ #category : #'as yet unclassified' }
CAKModelBuilder >> nodes: aCollection [
	| nodes |

	self assert: [ aCollection isCollection ] description: 'A collection should be provided, else use #node: instead'.

	nodes := aCollection
		collect: [ :anEntity | 
			| cakEntity |
			cakEntity := CAKEntity new.
			cakEntity model: anEntity.
			self model add: cakEntity.
			cakEntity ].

	^ nodes
]
