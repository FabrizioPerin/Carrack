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
	
	Transcript show: 'Starting.' , String cr.
	Transcript show: DateAndTime now asTimeStamp asString , String cr.
	
	builder := CAKModelBuilderTryAgain new.
	builder nodes: MooseModel root first allClasses.
	builder nodes: MooseModel root first allMethods.
	
	Transcript show: 'Nodes DONE.' , String cr.
	Transcript show: DateAndTime now asTimeStamp asString , String cr.
	
	builder defineContainmentFrom: #yourself to: #methods on: MooseModel root first allClasses.
	builder defineAssociationFrom: #sender to: #candidates on: MooseModel root first allInvocations.
	
	builder create.
	
	Transcript show: 'FINISH!' , String cr.
	Transcript show: DateAndTime now asTimeStamp asString , String cr.
	
	^builder model.
]

{ #category : #'as yet unclassified' }
CAKExperimentsOnNewBuilder >> exp2 [
	"self new exp2"
	
	| builder |
	Transcript open.
	
	Transcript show: 'Starting.' , String cr.
	Transcript show: DateAndTime now asTimeStamp asString , String cr.
	
	builder := CAKModelBuilderTryAgain new.
	builder nodes: #(1 2 3 4 5 6 7 8 9 10 11 12).

	builder create.
	
	^builder model

]

{ #category : #'as yet unclassified' }
CAKExperimentsOnNewBuilder >> exp3 [
	"self new exp3"
	
	| builder |
	Transcript open.
	
	Transcript show: 'Starting.' , String cr.
	Transcript show: DateAndTime now asTimeStamp asString , String cr.
	
	builder := CAKModelBuilderTryAgain new.
	builder nodes: #(1 2 3 4 5 6 7 8 9 10 11 12).
	
	builder defineContainmentFrom: #first to: #second on: {#(1 2) . #(1 3) . #(4 5) . #(4 6) . #(7 8) . #(8 9) . #(8 11) . #(9 10) . #(9 12)}. 
	
	builder create.
	
	^builder model
	"builder nodes: MooseModel root first allMethods.
	
	Transcript show: 'Nodes DONE.' , String cr.
	Transcript show: DateAndTime now asTimeStamp asString , String cr.
	
	builder defineContainmentFrom: #yourself to: #methods on: MooseModel root first allClasses.
	builder defineAssociationFrom: #sender to: #candidates on: MooseModel root first allInvocations.
	
	builder create.
	
	Transcript show: 'FINISH!' , String cr.
	Transcript show: DateAndTime now asTimeStamp asString , String cr.
	
	^builder model."
]

{ #category : #'as yet unclassified' }
CAKExperimentsOnNewBuilder >> exp4 [
	"self new exp4"
	
	| builder |
	Transcript open.
	
	Transcript show: 'Starting.' , String cr.
	Transcript show: DateAndTime now asTimeStamp asString , String cr.
	
	builder := CAKModelBuilderTryAgain new.
	builder nodes: #(1 2 3 4 5 6 7 8 9 10 11 12).
	
	builder defineContainmentFrom: #first to: #second on: {#(1 2) . #(1 3) . #(4 5) . #(4 6) . #(7 8) . #(8 9) . #(8 11) . #(9 10) . #(9 12)}.
	builder defineAssociationFrom: #first to: #second on: {#(6 8)}. 
	
	builder create.
	
	^builder model
	"builder nodes: MooseModel root first allMethods.
	
	Transcript show: 'Nodes DONE.' , String cr.
	Transcript show: DateAndTime now asTimeStamp asString , String cr.
	
	builder defineContainmentFrom: #yourself to: #methods on: MooseModel root first allClasses.
	builder defineAssociationFrom: #sender to: #candidates on: MooseModel root first allInvocations.
	
	builder create.
	
	Transcript show: 'FINISH!' , String cr.
	Transcript show: DateAndTime now asTimeStamp asString , String cr.
	
	^builder model."
]

{ #category : #'as yet unclassified' }
CAKExperimentsOnNewBuilder >> exp5 [
	"self new exp5"
	
	| builder |
	Transcript open.
	
	Transcript show: 'Starting.' , String cr.
	Transcript show: DateAndTime now asTimeStamp asString , String cr.
	
	builder := CAKModelBuilderTryAgain new.
	builder nodes: #(1 2 3 4 5 6 7 8 9 10 11 12).
	
	builder defineContainmentFrom: #first to: #second on: {#(1 2) . #(1 3) . #(4 5) . #(4 6) . #(7 8) . #(8 9) . #(8 11) . #(9 10) . #(9 12)}.
	builder defineAssociationFrom: #first to: #second on: {#(5 9)}. 
	
	builder create.
	
	^builder model
	"builder nodes: MooseModel root first allMethods.
	
	Transcript show: 'Nodes DONE.' , String cr.
	Transcript show: DateAndTime now asTimeStamp asString , String cr.
	
	builder defineContainmentFrom: #yourself to: #methods on: MooseModel root first allClasses.
	builder defineAssociationFrom: #sender to: #candidates on: MooseModel root first allInvocations.
	
	builder create.
	
	Transcript show: 'FINISH!' , String cr.
	Transcript show: DateAndTime now asTimeStamp asString , String cr.
	
	^builder model."
]

{ #category : #'as yet unclassified' }
CAKExperimentsOnNewBuilder >> exp6 [
	"self new exp6"
	
	| builder |
	Transcript open.
	
	Transcript show: 'Starting.' , String cr.
	Transcript show: DateAndTime now asTimeStamp asString , String cr.
	
	builder := CAKModelBuilderTryAgain new.
	builder nodes: #(1 2 3 4 5 6 7 8 9 10 11 12 13).
	
	builder defineContainmentFrom: #first to: #second on: {#(1 2) . #(1 3) . #(4 5) . #(4 6) . #(7 8) . #(8 9) . #(8 11) . #(9 10) . #(9 12) . #(13 4)}.
	builder defineAssociationFrom: #first to: #second on: {#(5 9)}. 
	
	builder create.
	
	^builder model
	"builder nodes: MooseModel root first allMethods.
	
	Transcript show: 'Nodes DONE.' , String cr.
	Transcript show: DateAndTime now asTimeStamp asString , String cr.
	
	builder defineContainmentFrom: #yourself to: #methods on: MooseModel root first allClasses.
	builder defineAssociationFrom: #sender to: #candidates on: MooseModel root first allInvocations.
	
	builder create.
	
	Transcript show: 'FINISH!' , String cr.
	Transcript show: DateAndTime now asTimeStamp asString , String cr.
	
	^builder model."
]

{ #category : #'as yet unclassified' }
CAKExperimentsOnNewBuilder >> exp7 [
	"self new exp7"
	
	| builder |
	Transcript open.
	
	Transcript show: 'Starting.' , String cr.
	Transcript show: DateAndTime now asTimeStamp asString , String cr.
	
	builder := CAKModelBuilderTryAgain new.
	builder nodes: #(1 2 3 4 5).
	
	builder defineContainmentFrom: #first to: #second on: {#(1 2) . #(4 3) . #(5 3)}.
	builder defineAssociationFrom: #first to: #second on: {#(2 3)}. 
	
	builder create.
	
	^builder model
	"builder nodes: MooseModel root first allMethods.
	
	Transcript show: 'Nodes DONE.' , String cr.
	Transcript show: DateAndTime now asTimeStamp asString , String cr.
	
	builder defineContainmentFrom: #yourself to: #methods on: MooseModel root first allClasses.
	builder defineAssociationFrom: #sender to: #candidates on: MooseModel root first allInvocations.
	
	builder create.
	
	Transcript show: 'FINISH!' , String cr.
	Transcript show: DateAndTime now asTimeStamp asString , String cr.
	
	^builder model."
]
