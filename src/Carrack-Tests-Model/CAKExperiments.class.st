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
	
	builder defineContainement: #methods from: #FAMIXClass to: #FAMIXMethod.
	builder defineAssociation: #outgoingInvocations from: #FAMIXMethod to: #FAMIXMethod.
	
	builder create.
	
	Transcript show: 'FINISH!' , String cr.
	Transcript show: DateAndTime now asTimeStamp asString , String cr.
	
	^builder model.
]

{ #category : #'as yet unclassified' }
CAKExperiments >> viewDSMExampleOnCarrack [
	"self new viewDSMExample3"
	| model view dSMMatrix cakentities |
	
	model := FakeModelProvider new cakModelOnModel1. 

	view := MOViewRenderer new.
	dSMMatrix := DSMMatrix
		withNodes: (model allEntitiesOfType: #CAKFakeContainerObject)
		edges: (model allEntitiesOfType: #CAKFakeContainerObject) allOutgoingAssociations 
		from: #associationSource
		to: #associationTarget.
	ColoredDSM new open: dSMMatrix on: view.
	
	view open
]
