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
CAKAssociationTests >> testTo [
	| assoc entity |

	assoc := CAKAssociation new.
	entity := CAKEntity new.

	self assert: assoc to equals: nil.	
	
	assoc associationTarget: entity.
	
	self assert: assoc to equals: entity.

]
