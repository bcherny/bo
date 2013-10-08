module.exports = (grunt) ->

	grunt.config.init

		pkg: grunt.file.readJSON 'package.json'

		exec:

			coffee:
				command: """
					echo "compiling coffee..."
					mkdir -p js
					coffee --join dist/<%= pkg.name %>-<%= pkg.version %>.js --compile coffee/*.coffee.md
				"""

			stylus:
				command: """
					echo "compiling stylus..."
					stylus stylus stylus --compress --out dist
				"""

		concat:

			dist:
				src: [
					'node_modules/sparkplug.js/sparkplug.js'
					'node_modules/izzy/izzy.js'
					'dist/<%= pkg.name %>-<%= pkg.version %>.js'
				]
				dest: 'dist/<%= pkg.name %>-<%= pkg.version %>.js'

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
					'dist/<%= pkg.name %>-<%= pkg.version %>.min.js': [
						'dist/<%= pkg.name %>-<%= pkg.version %>.js'
					]

		# requirejs:
		# 	compile:
		# 		options:
		# 			baseUrl: 'js'
		# 			mainConfigFile: 'require.config.js',
		# 			include: 'bo.js'
		# 			out: 'dist/bo.js'
		# 			paths:
		# 				izzy: '../node_modules/izzy/izzy'
		# 			keepBuildDir: true
		# 			optimize: 'uglify'
		# 			uglify2:
		# 				mangle:
		# 					toplevel: true
		# 				compress:
		# 					dead_code: true
		# 					unused: true
		# 					join_vars: true
		# 				comments: false
		# 			findNestedDependencies: true
		# 			wrap: true



	grunt.loadNpmTasks 'grunt-contrib-concat'
	grunt.loadNpmTasks 'grunt-contrib-uglify'
	grunt.loadNpmTasks 'grunt-exec'

	grunt.registerTask 'default', ['exec', 'concat', 'uglify']