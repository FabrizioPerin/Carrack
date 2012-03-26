Class {
	#name : #CAKContainmentTests,
	#superclass : #TestCase,
	#instVars : [
		'assciationTarget',
		'associationTarget',
		'assciationSource'
	],
	#category : #'Carrack-Tests-Model'
}

{ #category : #accessing }
CAKContainmentTests >> testContainer [
	| containment entity |

	containment := CAKContainment new.
	entity := CAKEntity new.

	self assert: containment container equals: nil.	
	
	containment container: entity.
	
	self assert: containment container equals: entity.

]

{ #category : #accessing }
CAKContainmentTests >> testContainmentCreation [
	| assoc |
	
	assoc := CAKContainment new.
	
	self assert: assoc container equals: nil.
	self assert: assoc from equals: nil.
	self assert: assoc content equals: nil.
	self assert: assoc to equals: nil.
]

{ #category : #accessing }
CAKContainmentTests >> testContent [
	| containment entity |

	containment := CAKContainment new.
	entity := CAKEntity new.

	self assert: containment content equals: nil.	
	
	containment content: entity.
	
	self assert: containment content equals: entity.

]

{ #category : #accessing }
CAKContainmentTests >> testFrom [
	| containment entity |

	containment := CAKContainment new.
	entity := CAKEntity new.

	self assert: containment from equals: nil.	
	
	containment container: entity.
	
	self assert: containment from equals: entity.

]

{ #category : #accessing }
CAKContainmentTests >> testTo [
	| containment entity |

	containment := CAKContainment new.
	entity := CAKEntity new.

	self assert: containment to equals: nil.	
	
	containment content: entity.
	
	self assert: containment to equals: entity.

]
