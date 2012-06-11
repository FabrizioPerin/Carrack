Class {
	#name : #CAKExperiments,
	#superclass : #Object,
	#category : #'Carrack-Tests-Model'
}

{ #category : #'as yet unclassified' }
CAKExperiments >> exp1 [
	"Tried on ArgoUML"
	"self new exp1"
	
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
CAKExperiments >> exp2 [
	"Tried on ArgoUML"
	| builder |
	Transcript open.
	
	builder := CAKModelBuilder new.
	builder nodes: MooseModel root first allClasses.
	builder nodes: MooseModel root first allMethods.
	builder nodes: MooseModel root first allNamespaces.
	
	Transcript show: 'Nodes DONE.' , String cr.
	Transcript show: DateAndTime now asTimeStamp asString , String cr.
	
	builder defineContainement: #methods from: #FAMIXClass to: #FAMIXMethod.
	builder defineContainement: #classes from: #FAMIXNamespace to: #FAMIXClass.
	builder defineAssociation: #outgoingInvocations from: #FAMIXMethod to: #FAMIXMethod.
	
	builder create.
	
	Transcript show: 'FINISH!' , String cr.
	Transcript show: DateAndTime now asTimeStamp asString , String cr.
	
	^builder model.
]

{ #category : #'as yet unclassified' }
CAKExperiments >> exp4 [
	"Tried different ground dependecies on ArgoUML"
	"self new exp4 install"
	| builder |
	Transcript open.
	
	builder := CAKModelBuilder new.
	builder nodes: MooseModel root first allClasses.
	builder nodes: MooseModel root first allMethods.
	builder nodes: MooseModel root first allNamespaces.
	builder nodes: MooseModel root first allAttributes.
	
	Transcript show: 'Nodes DONE.' , String cr.
	Transcript show: DateAndTime now asTimeStamp asString , String cr.
	
	builder defineContainement: #methods from: #FAMIXClass to: #FAMIXMethod.
	builder defineContainement: #classes from: #FAMIXNamespace to: #FAMIXClass.
	builder defineContainement: #attributes from: #FAMIXClass to: #FAMIXAttribute.
	builder defineAssociation: #accesses from: #FAMIXMethod to: #FAMIXAttribute.
	
	builder create.
	
	Transcript show: 'FINISH!' , String cr.
	Transcript show: DateAndTime now asTimeStamp asString , String cr.
	
	^builder model.
]

{ #category : #'as yet unclassified' }
CAKExperiments >> viewDSMExampleOnCarrack [
	"self new viewDSMExample3"
	| model view dSMMatrix cakentities |
	
	model := FakeModelProvider build cakModelOnModelWithOneLevel. 

	view := MOViewRenderer new.
	dSMMatrix := DSMMatrix
		withNodes: (model allEntitiesOfType: #CAKFakeContainerObject)
		edges: (model allEntitiesOfType: #CAKFakeContainerObject) allOutgoingAssociations 
		from: #associationSource
		to: #associationTarget.
	ColoredDSM new open: dSMMatrix on: view.
	
	view open
]

{ #category : #'as yet unclassified' }
CAKExperiments >> viewDSMExampleWithArraysOnCarrack [
	"self new viewDSMExample3"
	| model view dSMMatrix cakentities |
	
	model := FakeModelProvider build cakModelOnModelWithOneLevel. 

	view := MOViewRenderer new.
	dSMMatrix := DSMMatrix
		withNodes: (model allEntitiesOfType: #CAKFakeContainerObject)
		edges: (model allEntitiesOfType: #CAKFakeContainerObject) allOutgoingAssociations 
		from: #associationSource
		to: #associationTarget.
	ColoredDSM new open: dSMMatrix on: view.
	
	view open
]
