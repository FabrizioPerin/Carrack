Class {
	#name : #ConfigurationOfCarrack,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#category : #ConfigurationOfCarrack
}

{ #category : #private }
ConfigurationOfCarrack class >> ensureMetacello [
	Smalltalk at: #MetacelloProject ifAbsent: [
		Gofer new
				url: 'http://seaside.gemstone.com/ss/metacello';
				package: 'ConfigurationOfMetacello';
				load.
		(Smalltalk at: #ConfigurationOfMetacello) loadLatestVersion ]
]

{ #category : #'metacello tool support' }
ConfigurationOfCarrack class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfCarrack class >> loadDefault [

	(self project version: 'default') load.

]

{ #category : #accessing }
ConfigurationOfCarrack class >> project [

	^self new project
]

{ #category : #baselines }
ConfigurationOfCarrack >> default: spec [ 
	<version: 'default'>
	
	spec
		for: #common
		do: [ 
			spec blessing: #default.
			spec repository: 'http://www.squeaksource.com/Carrack'.
		"spec project: 'MooseJEE for Babel' with: [
				spec
					className: 'ConfigurationOfMooseJEE';
					file: 'ConfigurationOfMooseJEE';
					version: 'default';
					repository: 'http://www.squeaksource.com/MooseJEE'.]."
		spec
			"Model"
			package: 'Carrack-Model';
			
			"Tests"
			package: 'Carrack-Tests-Model' with: [
				spec requires: 'Carrack-Model'].
			
		spec group: 'Tests' with: #( 
			'Carrack-Tests-Model') ]
]

{ #category : #accessing }
ConfigurationOfCarrack >> project [

	^ project ifNil: [ | constructor |
		"Bootstrap Metacello if it is not already loaded"
		self class ensureMetacello.
		"Construct Metacello project"
		constructor := (Smalltalk at: #MetacelloVersionConstructor) on: self.
		project := constructor project.
		project]
]
