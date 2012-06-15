Class {
	#name : #FakeModelProvider,
	#superclass : #Object,
	#category : #'Carrack-Tests-Resources'
}

{ #category : #'as yet unclassified' }
FakeModelProvider class >> build [
	^self new.
]

{ #category : #'as yet unclassified' }
FakeModelProvider >> cakModelOnModelWithOneLevel [
	
	| builder |
	builder := CAKModelBuilder new.

	builder nodes: self modelWithOneLevel.
	
	builder defineContainement: #fakeContainment from: #CAKFakeContainerObject to: #CAKFakeContentObject.
	
	builder defineAssociation: #fakeAssociation from: #CAKFakeContentObject to: #CAKFakeContentObject.
	
	^builder create model
]

{ #category : #'as yet unclassified' }
FakeModelProvider >> cakModelOnModelWithTwoLevels [
	| builder model |
	
	builder := CAKModelBuilder new.
	model := self modelWithTwoLevels.

	builder nodes: model.
	
	builder defineContainmentFrom: #yourself to:  #fakeContainment on: ( model select: [:each | each isMemberOf: CAKFakeContainerObject]).
	builder defineAssociationFrom: #yourself to:  #fakeAssociation on: ( model select: [:each | each isMemberOf: CAKFakeContentObject]).
	
	
	^builder create model
]

{ #category : #'as yet unclassified' }
FakeModelProvider >> experimentingCakModelOnModel1 [
	
	| builder |
	builder := CAKModelBuilder new.

	builder nodes: #(1 2 3 4 5 6 7 8 9 10).
	
	builder defineAssociation: [:value | self halt ] from: #SmallInteger to: [:value | self halt ].
	
	^builder create model
]

{ #category : #'as yet unclassified' }
FakeModelProvider >> modelWithOneLevel [
	| c1 c2 c3 c4 c5 c6 c7 c8 model |

	c1 := CAKFakeContainerObject new name: #Container1.
	c2 := CAKFakeContainerObject new name: #Container2.
	c3 := CAKFakeContainerObject new name: #Container3.
	c4 := CAKFakeContainerObject new name: #Container4.
	
	c5 := CAKFakeContentObject new name: #Content1.
	c6 := CAKFakeContentObject new name: #Content2.
	c7 := CAKFakeContentObject new name: #Content3.
	c8 := CAKFakeContentObject new name: #Content4.
	
	c1 fakeContainment add: c5.
	c2 fakeContainment add: c6.
	c3 fakeContainment add: c7.
	c4 fakeContainment add: c8.
	
	c5 fakeAssociation add: c6.
	c5 fakeAssociation add: c7.
	
	c6 fakeAssociation add: c7.
	c8 fakeAssociation add: c8.
	
	model := OrderedCollection new.
	
	model add: c1.
	model add: c2.
	model add: c3.
	model add: c4.
	model add: c5.
	model add: c6.
	model add: c7.
	model add: c8.
	
	^ model
]

{ #category : #'as yet unclassified' }
FakeModelProvider >> modelWithTwoLevels [
	| model c1 c2 |

	model := FakeModelProvider build modelWithOneLevel.
	
	c1 := CAKFakeContainerObject new name: #topContainer1.
	c2 := CAKFakeContainerObject new name: #topContainer2.
	
	c1 fakeContainment add: (model select: [:each | each name = #Container1]) first.
	c2 fakeContainment add: (model select: [:each | each name = #Container3]) first.
	
	model add: c1.
	model add: c2.	

	^model
]
