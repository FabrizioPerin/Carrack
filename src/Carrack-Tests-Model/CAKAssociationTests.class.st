Class {
	#name : #CAKAssociationTests,
	#superclass : #TestCase,
	#instVars : [
		'assciationTarget',
		'associationTarget',
		'assciationSource'
	],
	#category : #'Carrack-Tests-Model'
}

{ #category : #accessing }
CAKAssociationTests >> testAssociationCreation [
	| assoc |
	
	assoc := CAKAssociation new.
	
	self assert: assoc associationTarget equals: nil.
	self assert: assoc to equals: nil.
	self assert: assoc associationSource equals: nil.
	self assert: assoc from equals: nil.
]

{ #category : #accessing }
CAKAssociationTests >> testAssociationSource [
	| assoc entity |

	assoc := CAKAssociation new.
	entity := CAKEntity new.

	self assert: assoc associationSource equals: nil.	
	
	assoc associationSource: entity.
	
	self assert: assoc associationSource equals: entity.

]

{ #category : #accessing }
CAKAssociationTests >> testAssociationTarget [
	| assoc entity |

	assoc := CAKAssociation new.
	entity := CAKEntity new.

	self assert: assoc associationTarget equals: nil.	
	
	assoc associationTarget: entity.
	
	self assert: assoc associationTarget equals: entity.

]

{ #category : #accessing }
CAKAssociationTests >> testFrom [
	| assoc entity |

	assoc := CAKAssociation new.
	entity := CAKEntity new.

	self assert: assoc from equals: nil.	
	
	assoc associationSource: entity.
	
	self assert: assoc from equals: entity.

]

{ #category : #accessing }
CAKAssociationTests >> testIndirectAssociationSource [
	| assoc entity |

	assoc := CAKAssociation new.
	entity := CAKEntity new.

	self assert: assoc associationSource equals: nil.	
	
	entity addOutgoingAssociation: assoc.
	
	self assert: assoc associationSource equals: entity.

]

{ #category : #accessing }
CAKAssociationTests >> testIndirectAssociationTarget [
	| assoc entity |

	assoc := CAKAssociation new.
	entity := CAKEntity new.

	self assert: assoc associationTarget equals: nil.	
	
	entity addIncomingAssociation: assoc.
	
	self assert: assoc associationTarget equals: entity.

]

{ #category : #accessing }
CAKAssociationTests >> testModel [
	| model assocs assocsderived assocsNil outgoingAssocFromTop1 outgoingAssocFromContainer1 level1Assoc |

	model := FakeModelProvider build cakModelOnModelWithTwoLevels.
	
	"self assert: model allAssociations size equals: 9.
	
	self assert: (model allAssociations reject: [:each | each model isMemberOf: OrderedCollection]) size equals: 4.
	self assert: (model allAssociations select: [:each | each model isMemberOf: OrderedCollection]) size equals: 5.
	"
	outgoingAssocFromTop1 := (model allEntities select: [:each | each model name = #topContainer1]) first outgoingAssociations.
	
	self assert: outgoingAssocFromTop1 size equals: 1.
	self assert: (outgoingAssocFromTop1 first model isMemberOf: OrderedCollection).
	self assert: outgoingAssocFromTop1 first model size equals: 1.
	self assert: outgoingAssocFromTop1 first model first associationSource model name equals: #Container1.
	self assert: outgoingAssocFromTop1 first model first associationTarget model name equals: #Container3.
	
	level1Assoc := outgoingAssocFromTop1 first model first model.
	
	self assert: (level1Assoc isMemberOf: OrderedCollection). 
	self assert: level1Assoc size equals: 1.
	self assert: (level1Assoc first isMemberOf: CAKAssociation). 
	self assert: (level1Assoc first model isMemberOf: CAKFakeContentObject).
	self assert: level1Assoc first model name equals: #Content1.
]

{ #category : #accessing }
CAKAssociationTests >> testTo [
	| assoc entity |

	assoc := CAKAssociation new.
	entity := CAKEntity new.

	self assert: assoc to equals: nil.	
	
	assoc associationTarget: entity.
	
	self assert: assoc to equals: entity.

]
