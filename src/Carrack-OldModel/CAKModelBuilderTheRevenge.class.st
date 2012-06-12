Class {
	#name : #CAKModelBuilderTheRevenge,
	#superclass : #Object,
	#instVars : [
		'model'
	],
	#category : #'Carrack-OldModel'
}

{ #category : #'as yet unclassified' }
CAKModelBuilderTheRevenge >> defineContainemnt: aContainmentRelationsCollection from: aBlockOrSymble to: anotherBlockOrSymble [

	| cakContainment containment value targetEntity assocModel |
	aContainmentRelationsCollection do: [:each |
		| container content |
		container := self lookUpElement: each computedAs: aBlockOrSymble.
		content := self lookUpElement: each computedAs: anotherBlockOrSymble.
		
		containment := CAKContainment new.
		containment container: value.
		containment content: targetEntity.
		containment model: assocModel.
		self model add: containment
		
		self model add: cakContainment
		 ].
]

{ #category : #'as yet unclassified' }
CAKModelBuilderTheRevenge >> initialize [
	model := CAKModelTheRevenge new.
]

{ #category : #'as yet unclassified' }
CAKModelBuilderTheRevenge >> model [
	^ model
]

{ #category : #'as yet unclassified' }
CAKModelBuilderTheRevenge >> nodes: aCollectionOfEntiies [
	
	aCollectionOfEntiies do: [:each|
		| cakEntity |
		cakEntity:=CAKEntity new.
		cakEntity model: each.
		model nodes add: cakEntity.]
]
