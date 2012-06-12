Class {
	#name : #CAKAbstractAssociation,
	#superclass : #CAKAbstractEntity,
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

{ #category : #accessing }
CAKAbstractAssociation >> mooseDisplayStringOn: aStream [
	self from mooseDisplayStringOn: aStream.
	aStream nextPutAll: ' -> '.
	self to mooseDisplayStringOn: aStream	
]

{ #category : #accessing }
CAKAbstractAssociation >> to [
	<MSEProperty: #to type: #CAKEntity> <derived>
	<MSEComment: 'Generic accessor to the entity target of the association. Refined by subclasses'>
	
	^ self subclassResponsibility
]
