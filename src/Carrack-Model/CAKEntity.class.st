Class {
	#name : #CAKEntity,
	#superclass : #CAKAbstractEntity,
	#instVars : [
		'entityName',
		'outgoingAssociations',
		'containedEntities',
		'containerEntities',
		'incomingAssociations'
	],
	#category : #'Carrack-Model'
}

{ #category : #'as yet unclassified' }
CAKEntity class >> annotation [
	<MSEClass: #Entity super: #CAKAbstractEntity>
	<package: #CAK>
	^self
]

{ #category : #accessing }
CAKEntity >> addContainedEntity: aCAKContainment [
	self contents add: aCAKContainment
]

{ #category : #accessing }
CAKEntity >> addContainerEntity: aCAKContainment [
	self containers add: aCAKContainment
]

{ #category : #accessing }
CAKEntity >> addIncomingAssociation: aCAKAssociation [
	self incomingAssociations add: aCAKAssociation
]

{ #category : #accessing }
CAKEntity >> addOutgoingAssociation: aCAKAssociation [
	self outgoingAssociations add: aCAKAssociation
]

{ #category : #accessing }
CAKEntity >> belongsTo [
	self containerEntities isEmpty
		ifTrue: [^nil]
		ifFalse: [^self containerEntities ]
]

{ #category : #accessing }
CAKEntity >> containedEntities [
	| res |

	res := OrderedCollection new.

	self contents
		do: [ :each | 
			each to isNil
				ifFalse: [ res add: each to ] ].

	^ res
]

{ #category : #accessing }
CAKEntity >> containerEntities [
	| res |

	res := OrderedCollection new.

	self containers
		do: [ :each | 
			each from isNil
				ifFalse: [ res add: each from ] ].

	^ res

]

{ #category : #accessing }
CAKEntity >> containers [
	<MSEProperty: #containers type: #CAKContainment opposite: #content> <multivalued>  <derived>
	<MSEComment: 'Containment relationship'>
	^ containerEntities
]

{ #category : #accessing }
CAKEntity >> contents [
	<MSEProperty: #contents type: #CAKContainment opposite: #container> <multivalued>  <derived>
	<MSEComment: 'Containment relationship'>
	^ containedEntities
]

{ #category : #accessing }
CAKEntity >> entityName [
	^entityName
]

{ #category : #accessing }
CAKEntity >> entityName: aStringOrSymbol [
	^entityName := aStringOrSymbol
]

{ #category : #accessing }
CAKEntity >> incomingAssociationEntities [
	| res |

	res := OrderedCollection new.

	self incomingAssociations
		do: [ :each | 
			each from isNil
				ifFalse: [ res add: each from ] ].

	^ res	
]

{ #category : #accessing }
CAKEntity >> incomingAssociations [
	<MSEProperty: #incomingAssociations type: #CAKAssociation opposite: #associationTarget>
	<MSEComment: 'Association relationship'>
	^ incomingAssociations
]

{ #category : #initialization }
CAKEntity >> initialize [ 
	super initialize.
	
	incomingAssociations := FMMultivalueLink on: self opposite: #associationTarget:.
	outgoingAssociations := FMMultivalueLink on: self opposite: #associationSource:.
	containedEntities := FMMultivalueLink on: self opposite: #container:.
	containerEntities := FMMultivalueLink on: self opposite: #content:.
	
	^self 
]

{ #category : #accessing }
CAKEntity >> internalOutgoingAssociationEntities [
	^self internalOutgoingAssociations collect: [:each | each associationTarget ]
]

{ #category : #accessing }
CAKEntity >> internalOutgoingAssociations [
	^self outgoingAssociations select: [:each | each associationTarget containerEntities includes: self ].
]

{ #category : #printing }
CAKEntity >> originalPrintOn: aStream [
	super printOn: aStream
]

{ #category : #accessing }
CAKEntity >> outgoingAssociationEntities [
	| res |

	res := OrderedCollection new.

	self outgoingAssociations
		do: [ :each | 
			each to isNil
				ifFalse: [ res add: each to ] ].

	^ res	
]

{ #category : #accessing }
CAKEntity >> outgoingAssociations [
	<MSEProperty: #outgoingAssociations type: #CAKAssociation opposite: #associationSource>
	<MSEComment: 'Association relationship'>
	^ outgoingAssociations
]

{ #category : #printing }
CAKEntity >> printOn: aStream [
	self originalPrintOn: aStream.
	aStream nextPutAll: ' name: ', self entityName asString.
	aStream nextPutAll: ' model: '; print: self model
]
