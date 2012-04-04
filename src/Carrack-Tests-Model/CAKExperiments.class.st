Class {
	#name : #CAKExperiments,
	#superclass : #Object,
	#category : #'Carrack-Tests-Model'
}

{ #category : #'as yet unclassified' }
CAKExperiments >> exp1 [
	| builder |
	Transcript open.
	
	builder := CAKModelBuilder new.
	builder nodes: MooseModel root first allClasses.
	builder nodes: MooseModel root first allMethods.
	
	Transcript show: 'Nodes DONE.' , String cr.
	Transcript show: DateAndTime now asTimeStamp asString , String cr.
	
	builder defineContainementSelector: #methods from: #FAMIXClass to: #FAMIXMethod.
	builder defineAssociationSelector: #outgoingInvocations from: #FAMIXMethod to: #FAMIXMethod.
	
	builder create.
	
	Transcript show: 'FINISH!' , String cr.
	Transcript show: DateAndTime now asTimeStamp asString , String cr.
	
	^builder model.
]
