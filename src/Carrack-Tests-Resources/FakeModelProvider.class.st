Class {
	#name : #FakeModelProvider,
	#superclass : #Object,
	#category : #'Carrack-Tests-Resources'
}

{ #category : #'as yet unclassified' }
FakeModelProvider >> cakModelOnModel1 [
	
	| builder |
	builder := CAKModelBuilder new.

	builder nodes: self model1.
	
	builder defineContainement: #fakeContainment from: #CAKFakeContainerObject to: #CAKFakeContentObject.
	builder defineAssociation: #fakeAssociation from: #CAKFakeContentObject to: #CAKFakeContentObject.
	
	^builder create model
]

{ #category : #'as yet unclassified' }
FakeModelProvider >> model1 [
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
