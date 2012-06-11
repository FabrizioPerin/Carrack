Class {
	#name : #CAKExperimentsOnNewBuilder,
	#superclass : #Object,
	#category : #'Carrack-Tests-Model'
}

{ #category : #'as yet unclassified' }
CAKExperimentsOnNewBuilder >> exp1 [
	"self new exp1"
	
	| builder |
	Transcript open.
	
	builder := CAKModelBuilderTryAgain new.
	builder nodes: MooseModel root first allClasses.
	builder nodes: MooseModel root first allMethods.
	
	Transcript show: 'Nodes DONE.' , String cr.
	Transcript show: DateAndTime now asTimeStamp asString , String cr.
	
	builder defineContainmentFrom: #yourself to: #methods on: MooseModel root first allClasses.
	builder defineAssociationFrom: #yourself to: #outgoingInvocations on: MooseModel root first allMethods.
	
	builder create.
	
	Transcript show: 'FINISH!' , String cr.
	Transcript show: DateAndTime now asTimeStamp asString , String cr.
	
	^builder model.
]
