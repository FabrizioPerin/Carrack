Class {
	#name : #CAKEntityGroupTests,
	#superclass : #TestCase,
	#category : #'Carrack-Tests-Model'
}

{ #category : #'as yet unclassified' }
CAKEntityGroupTests >> testGroupCreation [
	| group |

	group := CAKEntityGroup new.
	
	self assert: (group isMemberOf: CAKEntityGroup).
	self assert: group size equals: 0.
	self assert: group type equals: nil.
	self assert: group isRoot equals: nil.
	self assert: group isLeaf equals: nil.
	
	 
]

{ #category : #'as yet unclassified' }
CAKEntityGroupTests >> testIsLeaf [
	| group |

	group := CAKEntityGroup new.

	self assert: group isLeaf equals: nil.
	
	group isLeaf: true.
	
	self assert: group isLeaf. 
]

{ #category : #'as yet unclassified' }
CAKEntityGroupTests >> testIsRoot [
	| group |

	group := CAKEntityGroup new.

	self assert: group isRoot equals: nil.
	
	group isRoot: true.
	
	self assert: group isRoot. 
]

{ #category : #'as yet unclassified' }
CAKEntityGroupTests >> testType [
	| group |

	group := CAKEntityGroup new.

	self assert: group type equals: nil.
	
	group type: Collection.
	
	self assert: group type equals: Collection. 
	self deny: group type isString.
	
	group type: 'Collection'.
	
	self assert: group type equals: 'Collection'. 
	self deny: (group type isMemberOf: Collection).
]
