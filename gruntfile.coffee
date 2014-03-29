# Generated on 2014-03-28 using generator-webapp 0.4.8
'use strict'

module.exports = (grunt) ->

	require('load-grunt-tasks') grunt
	require('time-grunt') grunt

	grunt.initConfig

		# Project settings
		config:
			app: 'app'
			dist: 'dist'

		# Watches files for changes and runs tasks based on the changed files
		watch:
			bower:
				files: ['bower.json']
				tasks: ['bowerInstall']
			coffee:
				files: ['<%= config.app %>/scripts/{,*/}*.{coffee,litcoffee,coffee.md}']
				tasks: ['coffee:dist']
			gruntfile:
				files: ['gruntfile.coffee']
			compass:
				files: ['<%= config.app %>/styles/{,*/}*.{scss,sass}']
				tasks: ['compass:server', 'autoprefixer']
			stylus:
				files: ['<%= config.app %>/styles/{,*/}*.styl']
				tasks: ['stylus', 'autoprefixer']
			styles:
				files: ['<%= config.app %>/styles/{,*/}*.css']
				tasks: ['newer:copy:styles', 'autoprefixer']
			livereload:
				options:
					livereload: '<%= connect.options.livereload %>'
				files: [
					'<%= config.app %>/{,*/}*.html'
					'.tmp/styles/{,*/}*.css'
					'.tmp/scripts/{,*/}*.js'
					'<%= config.app %>/images/{,*/}*'
				]


		# The actual grunt server settings
		connect:
			options:
				port: 9000
				livereload: 35729
				hostname: 'localhost'
			livereload:
				options:
					open: true
					base: [
						'.tmp'
						'<%= config.app %>'
					]
			dist:
				options:
					open: true
					base: '<%= config.dist %>'
					livereload: false

		# Empties folders to start fresh
		clean:
			dist:
				files: [
					dot: true
					src: [
						'.tmp'
						'<%= config.dist %>/*'
						'!<%= config.dist %>/.git*'
					]
				]
			server: '.tmp'

		# Compiles CoffeeScript to JavaScript
		coffee:
			dist:
				files: [
					expand: true
					cwd: '<%= config.app %>/scripts'
					src: '{,*/}*.{coffee,litcoffee,coffee.md}'
					dest: '.tmp/scripts'
					ext: '.js'
				]

		# Compiles Sass to CSS and generates necessary files if requested
		compass:
			options:
				sassDir: '<%= config.app %>/styles',
				cssDir: '.tmp/styles',
				generatedImagesDir: '.tmp/images/generated',
				imagesDir: '<%= config.app %>/images',
				javascriptsDir: '<%= config.app %>/scripts',
				fontsDir: '<%= config.app %>/styles/fonts',
				importPath: '<%= config.app %>/bower_components',
				httpImagesPath: '/images',
				httpGeneratedImagesPath: '/images/generated',
				httpFontsPath: '/styles/fonts',
				relativeAssets: false,
				assetCacheBuster: false
			dist:
				options:
					generatedImagesDir: '<%= config.dist %>/images/generated'
			server:
				options:
					debugInfo: true

		# Compiles Stylus to CSS
		stylus:
			dist:
				files: [
					expand: true
					cwd: '<%= config.app %>/styles/'
					src: '{,*/}*.styl'
					dest: '.tmp/styles/'
					ext: '.css'
				]

		# Add vendor prefixed styles
		autoprefixer:
			options:
				browsers: ['last 1 version']
			dist:
				files: [
					expand: true
					cwd: '.tmp/styles/'
					src: '{,*/}*.css'
					dest: '.tmp/styles/'
				]

		# Automatically inject Bower components into the HTML file
		bowerInstall:
			app:
				src: ['<%= config.app %>/index.html']
				ignorePath: '<%= config.app %>/'
				exclude: ['<%= config.app %>/bower_components/bootstrap-sass/vendor/assets/javascripts/bootstrap.js']
			sass:
				src: ['<%= config.app %>/styles/{,*/}*.{scss,sass}']
				ignorePath: '<%= config.app %>/bower_components/'

		# Renames files for browser caching purposes
		rev:
			dist:
				files:
					src: [
						'<%= config.dist %>/scripts/{,*/}*.js'
						'<%= config.dist %>/styles/{,*/}*.css'
						'<%= config.dist %>/images/{,*/}*.*'
						'<%= config.dist %>/styles/fonts/{,*/}*.*'
						'<%= config.dist %>/*.{ico,png}'
					]

		# Reads HTML for usemin blocks to enable smart builds that automatically
		# concat, minify and revision files. Creates configurations in memory so
		# additional tasks can operate on them
		useminPrepare:
			options:
				dest: '<%= config.dist %>'
			html: '<%= config.app %>/index.html'

		# Performs rewrites based on rev and the useminPrepare configuration
		usemin:
			options:
				assetsDirs: ['<%= config.dist %>', '<%= config.dist %>/images']
			html: ['<%= config.dist %>/{,*/}*.html']
			css: ['<%= config.dist %>/styles/{,*/}*.css']

		# The following *-min tasks produce minified files in the dist folder
		imagemin:
			dist:
				files: [
					expand: true
					cwd: '<%= config.app %>/images'
					src: '{,*/}*.{gif,jpeg,jpg,png}'
					dest: '<%= config.dist %>/images'
				]

		svgmin:
			dist:
				files: [
					expand: true
					cwd: '<%= config.app %>/images'
					src: '{,*/}*.svg'
					dest: '<%= config.dist %>/images'
				]

		htmlmin:
			dist:
				options:
					collapseBooleanAttributes: true
					collapseWhitespace: true
					removeAttributeQuotes: true
					removeCommentsFromCDATA: true
					removeEmptyAttributes: true
					removeOptionalTags: true
					removeRedundantAttributes: true
					useShortDoctype: true
				files: [
					expand: true
					cwd: '<%= config.dist %>'
					src: '{,*/}*.html'
					dest: '<%= config.dist %>'
				]

		# Copies remaining files to places other tasks can use
		copy:
			dist:
				files: [
					expand: true
					dot: true
					cwd: '<%= config.app %>'
					dest: '<%= config.dist %>'
					src: [
						'*.{ico,png,txt}'
						'.htaccess'
						'images/{,*/}*.webp'
						'{,*/}*.html'
						'styles/fonts/{,*/}*.*'
						'*.json'
					]
				]
			styles:
				expand: true
				dot: true
				cwd: '<%= config.app %>/styles'
				dest: '.tmp/styles/'
				src: '{,*/}*.css'

		# Run some tasks in parallel to speed up build process
		concurrent:
			server: [
				'stylus'
				'coffee:dist'
				'copy:styles'
			]
			dist: [
				'coffee'
				'stylus'
				'copy:styles'
				'imagemin'
				'svgmin'
			]


	grunt.registerTask 'serve', (target) ->
		if target is 'dist'
			return grunt.task.run ['build', 'connect:dist:keepalive']
		grunt.task.run [
			'clean:server'
			'concurrent:server'
			'autoprefixer'
			'connect:livereload'
			'watch'
		]

	grunt.registerTask 'build', [
		'clean:dist'
		'useminPrepare'
		'concurrent:dist'
		'autoprefixer'
		'concat'
		'cssmin'
		'uglify'
		'copy:dist'
		#'rev'
		'usemin'
		'htmlmin'
	]

	grunt.registerTask 'default', [
		'build'
	]
