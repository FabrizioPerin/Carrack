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

{ #category : #loading }
ConfigurationOfCarrack class >> loadDevelopment [

	(self project version: 'development') load.

]

{ #category : #accessing }
ConfigurationOfCarrack class >> project [

	^self new project
]

{ #category : #baselines }
ConfigurationOfCarrack >> baseline10: spec [ 
	<version: '1.0-baseline'>
	
	spec
		for: #common
		do: [ 
			spec blessing: #default. 
			spec repository: 'http://www.squeaksource.com/Carrack'.
			
		spec
			"Model"
			package: 'Carrack-Model';
			
			"builder"
			package: 'Carrack-Builder';
			
			"Tests"
			package: 'Carrack-Tests-Resources';
			package: 'Carrack-Tests-Model' with: [
				spec requires: #('Carrack-Model' 'Carrack-Tests-Resources')];
			package: 'Carrack-Tests-Builder' with: [
				spec requires: #('Carrack-Builder' 'Carrack-Tests-Resources')].
			
		spec group: 'Tests' with: #( 
			'Carrack-Tests-Model') ]
]

{ #category : #baselines }
ConfigurationOfCarrack >> baseline20: spec [ 
	<version: '2.0-baseline'>
	
	spec
		for: #common
		do: [ 
			spec blessing: #default. 
			spec repository: 'http://www.smalltalkhub.com/mc/FabrizioPerin/Carrack/main'.
			
		spec
			"Model"
			package: 'Carrack-Model';
			
			"builder"
			package: 'Carrack-Builder';
			
			"Tests"
			package: 'Carrack-Tests-Resources';
			package: 'Carrack-Tests-Model' with: [
				spec requires: #('Carrack-Model' 'Carrack-Tests-Resources')];
			package: 'Carrack-Tests-Builder' with: [
				spec requires: #('Carrack-Builder' 'Carrack-Tests-Resources')].
			
		spec group: 'Tests' with: #( 
			'Carrack-Tests-Model') ]
]

{ #category : #baselines }
ConfigurationOfCarrack >> default: spec [ 
	<version: 'default'>
	
	spec
		for: #common
		do: [ 
			spec blessing: #default. 
			spec repository: 'http://www.smalltalkhub.com/mc/FabrizioPerin/Carrack/main'.
			"spec repository: (FileDirectory default pathName , FileDirectory pathNameDelimiter asString , 'package-cache')."
		"spec project: 'MooseJEE for Babel' with: [
				spec
					className: 'ConfigurationOfMooseJEE';
					file: 'ConfigurationOfMooseJEE';
					version: 'default';
					repository: 'http://www.squeaksource.com/MooseJEE'.]."
		spec
			"Model"
			package: 'Carrack-Model';
			
			"builder"
			package: 'Carrack-Builder';
			
			"Tests"
			package: 'Carrack-Tests-Resources';
			package: 'Carrack-Tests-Model' with: [
				spec requires: #('Carrack-Model' 'Carrack-Tests-Resources')];
			package: 'Carrack-Tests-Builder' with: [
				spec requires: #('Carrack-Builder' 'Carrack-Tests-Resources')].
			
		spec group: 'Tests' with: #( 
			'Carrack-Tests-Model') ]
]

{ #category : #baselines }
ConfigurationOfCarrack >> development: spec [
	<symbolicVersion: #development>

	spec for: #'pharo1.4.x' version: '1.0-baseline'.
	spec for: #'pharo2.x' version: '2.0-baseline'.
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
