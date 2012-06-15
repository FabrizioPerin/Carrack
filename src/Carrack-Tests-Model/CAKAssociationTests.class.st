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
	| model assocs assocsderived assocsNil |

	model := FakeModelProvider build cakModelOnModelWithTwoLevels.
	
	self assert: model allAssociations size equals: 9.
	
	assocs := model allAssociations reject: [:each | each model isMemberOf: CAKAssociation].
	assocsderived := model allAssociations select: [:each | each model isMemberOf: CAKAssociation].
	assocsNil := model allAssociations select: [:each | each model isNil ].
	
	(model allEntities select: [:each | each model name = #topContainer1]) first outgoingAssociations reject: [:each | each model isMemberOf: CAKAssociation ].
	
	(model allEntities select: [:each | each model name = #Content1]) first outgoingAssociations reject: [:each | each model isMemberOf: CAKAssociation ].
	
	self assert: false.
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
