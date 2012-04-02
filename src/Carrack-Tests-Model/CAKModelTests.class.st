Class {
	#name : #CAKModelTests,
	#superclass : #TestCase,
	#category : #'Carrack-Tests-Model'
}

{ #category : #'as yet unclassified' }
CAKModelTests >> testModelCreation [
	| model |
	
	model := CAKModel new.
	
	self assert: (model isMemberOf: CAKModel).
]
