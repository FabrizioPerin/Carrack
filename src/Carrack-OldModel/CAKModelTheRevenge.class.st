Class {
	#name : #CAKModelTheRevenge,
	#superclass : #Object,
	#instVars : [
		'nodes',
		'containmentRelations',
		'associations'
	],
	#category : #'Carrack-OldModel'
}

{ #category : #'as yet unclassified' }
CAKModelTheRevenge >> allRelations [
	^ (OrderedCollection withAll: self allAssociations) addAll: self allContainmentRelations
]

{ #category : #'as yet unclassified' }
CAKModelTheRevenge >> associations [
	^associations
]

{ #category : #'as yet unclassified' }
CAKModelTheRevenge >> containmentRelations [
	^ containmentRelations
]

{ #category : #'as yet unclassified' }
CAKModelTheRevenge >> initialize [
	nodes := OrderedCollection new.
	containmentRelations := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
CAKModelTheRevenge >> nodes [
	^ nodes
]
