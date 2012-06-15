Class {
	#name : #CAKCSExperiments,
	#superclass : #Object,
	#category : #'Carrack-Tests-Model'
}

{ #category : #'as yet unclassified' }
CAKCSExperiments >> exp1 [
	" self new exp1 inspect "
	" self new exp1 install "
	
	| builder |
			
	Transcript open.
	Transcript show: 'Starting.' , String cr.
	Transcript show: DateAndTime now asTimeStamp asString , String cr.
	
	builder := CAKModelBuilder new.
	builder nodes: MooseModel root first allModelClasses.
	builder nodes: MooseModel root first allModelMethods.
	builder nodes: MooseModel root first allCSComponents.
	
	Transcript show: 'Nodes DONE.' , String cr.
	Transcript show: DateAndTime now asTimeStamp asString , String cr.
	
	builder defineContainmentsFrom: #yourself to: #methods on: MooseModel root first allModelClasses.
	builder defineContainmentsFrom: #containerComponent to: #containedElement on: MooseModel root first allComponentContainment.
	"builder defineAssociationsFrom: #source to: #target on: MooseModel root first allComponentAssociations."
	builder defineAssociationsFrom: #sender to: #candidates on: MooseModel root first allInvocations.
	builder create.
	
	Transcript show: 'FINISH!' , String cr.
	Transcript show: DateAndTime now asTimeStamp asString , String cr.
	
	^builder model.
]

{ #category : #'as yet unclassified' }
CAKCSExperiments >> exp2 [
	" self new exp2 inspect "
	" self new exp2 install "
	
	| builder |
			
	Transcript open.
	Transcript show: 'Starting.' , String cr.
	Transcript show: DateAndTime now asTimeStamp asString , String cr.
	
	builder := CAKModelBuilder new.
	builder nodes: MooseModel root first allModelMethods.
	builder nodes: MooseModel root first allCSComponents.
	
	Transcript show: 'Nodes DONE.' , String cr.
	Transcript show: DateAndTime now asTimeStamp asString , String cr.

	builder defineContainmentsFrom: #containerComponent to: [:each | each containedElement methods ] on: MooseModel root first allComponentContainment.
	builder defineAssociationsFrom: #sender to: #candidates on: MooseModel root first allInvocations.
	builder create.
	
	Transcript show: 'FINISH!' , String cr.
	Transcript show: DateAndTime now asTimeStamp asString , String cr.
	
	^builder model.
]

{ #category : #'as yet unclassified' }
CAKCSExperiments >> exp3 [
	" self new exp3 inspect "
	" self new exp3 install "
	
	| builder |
			
	Transcript open.
	Transcript show: 'Starting.' , String cr.
	Transcript show: DateAndTime now asTimeStamp asString , String cr.
	
	builder := CAKModelBuilder new.
	builder nodes: MooseModel root first allModelMethods.
	builder nodes: MooseModel root first allCSComponents.
	
	Transcript show: 'Nodes DONE.' , String cr.
	Transcript show: DateAndTime now asTimeStamp asString , String cr.

	builder defineContainmentsFrom: #containerComponent to: [:each | each containedElement methods ] on: MooseModel root first allComponentContainment.
	builder defineAssociationsFrom: #sender to: #candidates on: (MooseModel root first allModelMethods collect: #outgoingInvocations).
	builder create.
	
	Transcript show: 'FINISH!' , String cr.
	Transcript show: DateAndTime now asTimeStamp asString , String cr.
	
	^builder model.
]
