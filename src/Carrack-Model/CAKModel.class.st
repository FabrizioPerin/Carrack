Class {
	#name : #CAKModel,
	#superclass : #MooseAbstractGroup,
	#category : #'Carrack-Model'
}

{ #category : #'as yet unclassified' }
CAKModel class >> annotation [
	<MSEClass: #CAKModel super: #MooseAbstractGroup>
	<package: #'Carrack-Model'>
	^self
]

{ #category : #accessing }
CAKModel >> allAssociations [
	^self allWithType: CAKAssociation.
]

{ #category : #accessing }
CAKModel >> allEntities [
	^self allWithType: CAKEntity.
]

{ #category : #accessing }
CAKModel >> allGroups [
	^self allWithType: CAKEntityGroup.
]

{ #category : #accessing }
CAKModel >> initialize [
	super initialize.
	
	^self
]
