'use strict'

do (window, $, _, moment) ->

	$ ->

		$main = $ '.main'
		$nav = $ '.nav'
		$content = $ '.content'
		#$members = $ '.members'
		$matches = $ '.matches'
		#$about = $ '.about'
		data = null
		active = null
		content = null
		init = null

		$.getJSON 'data.json', (response) ->
			data = response
			response.matchesByLeague = {}
			response.matchesByLeague.official = _.filter response.matches, (match) ->	match.league.toLowerCase() is 'official'
			response.matchesByLeague.pcw = _.filter response.matches, (match) -> match.league.toLowerCase() is 'pcw'
			content =
				members: _.template $('#template-members').html(), data
				matches: _.template $('#template-matches').html(), data
				about: _.template $('#template-about').html(), data

			init =
				members: ->
				matches: ->
					# format dates
					#$content.find('time').each ->
						#$(this).text(moment($(this).text(), 'DD.MM.YYYY HH:mm Z').fromNow())
					$content.find('.result').on 'click', ->
						$(this).next().slideToggle()
				about: ->


		$nav.find('a').on 'click', ->
			$this = $ this
			href = $this.attr('href').slice 1
			isActive = active isnt href
			$nav.find('a').removeClass 'active'
			if isActive
				$this.addClass 'active'
				active = href
			else
				$this.removeClass 'active'
				active = null

			$content.slideUp ->
				if isActive
					$content.html(content[href]).slideDown()
					init[href]()

		$(document).on 'click', '.matches-prev, .matches-next', ->
			list = $(this).parent().children('ul')[0]
			$scrollLeft = $(this).parent().children '.matches-prev'
			$scrollRight = $(this).parent().children '.matches-next'
			direction = if $(this).hasClass('matches-next') then 'right' else 'left'
			if !$(this).hasClass 'disabled'
				offset = if direction is 'right' then '+=300px' else '-=300px'
				if direction is 'right'
					$scrollLeft.removeClass 'disabled'
				else
					$scrollRight.removeClass 'disabled'
				$(list).animate {scrollLeft: offset}, 500, ->
					if list.scrollLeft + list.offsetWidth >= list.scrollWidth
						$scrollRight.addClass 'disabled'
					if list.scrollLeft <= 0
						$scrollLeft.addClass 'disabled'
			else

