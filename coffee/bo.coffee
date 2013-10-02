define (require, exports, module) ->
	
	class Bo

		constructor: ->

			# load panes from DOM
			@panes = document.querySelectorAll '[data-bo-pane]'

			# show first pane
			@show @panes[0]

		hideAll: ->

			for pane in @panes
				pane.classList.remove 'active'

		show: (paneElement) ->

			# sanity check
			if !paneElement
				console.error 'Bo.show expects an Element, but passed ', paneElement

			# hide panes
			@hideAll()

			# show this pane
			paneElement.classList.add 'active'