Class {
	#name : #CAKAbstractAssociation,
	#superclass : #MooseEntity,
	#category : #'Carrack-Model'
}

{ #category : #'as yet unclassified' }
CAKAbstractAssociation class >> annotation [
	<MSEClass: #CAKAbstractAssociation super: #MooseEntity>
	<package: #'Carrack-Model'>
	^self
]

{ #category : #accessing }
CAKAbstractAssociation >> from [
	<MSEProperty: #from type: #CAKEntity> <derived>
	<MSEComment: 'Generic accessor to the entity originating the association. Refined by subclasses'>
	
	^ self subclassResponsibility
]

{ #category : #'initialize-release' }
CAKAbstractAssociation >> initialize [
	super initialize
]

{ #category : #accessing }
CAKAbstractAssociation >> to [
	<MSEProperty: #to type: #CAKEntity> <derived>
	<MSEComment: 'Generic accessor to the entity target of the association. Refined by subclasses'>
	
	^ self subclassResponsibility
]
