module.exports = (grunt) ->

	grunt.config.init

		pkg: grunt.file.readJSON 'package.json'

		exec:

			coffee:
				command: """
					echo "compiling coffee..."
					mkdir -p js
					coffee -bco js coffee
				"""

			stylus:
				command: """
					echo "compiling stylus..."
					stylus stylus -u autoprefixer-stylus --compress --out dist
				"""

		concat:

			dist:
				src: [
					'js/util.js'
					'js/view.js'
					'js/pane.js'
					'js/bo.js'
				]
				dest: 'dist/bo.js'

		uglify:

			options:
				mangle:
					toplevel: true
				compress:
					dead_code: true
					unused: true
					join_vars: true
				comments: false

			standard:
				files:
					'dist/bo.min.js': [
						'dist/bo.js'
					]

		umd:
			all:
				src: 'dist/bo.js'
				objectToExport: 'Bo'
				amdModuleId: 'Bo'
				globalAlias: 'Bo'
				deps:
					'default': ['izzy', 'umodel']

	grunt.loadNpmTasks 'grunt-contrib-concat'
	grunt.loadNpmTasks 'grunt-contrib-uglify'
	grunt.loadNpmTasks 'grunt-umd'
	grunt.loadNpmTasks 'grunt-exec'

	grunt.registerTask 'default', ['exec', 'concat', 'umd', 'uglify']