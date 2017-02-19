document.addEventListener "turbolinks:load", ->
  $(".new-game select").each (index, element) ->
    element.value = element.options[index].value

  TAKEN_OPACITY = 0.5
  TAKEN_HOVER_OPACITY = 0.8
  NOT_TAKEN_OPACITY = 0
  NOT_TAKEN_HOVER_OPACITY = 0.5

  setupRoute = (routeDetails) ->
    route = $('#svg_' + routeDetails.svgId)
    route.attr('filter', 'url(#glow)')

    if routeDetails.isFilled
      route.attr('fill', routeDetails.displayColour)
      route.attr('opacity', TAKEN_OPACITY)
    else
      route.attr('opacity', NOT_TAKEN_OPACITY)

    if routeDetails.canClick
      route.hover(
        ->
          fill = if routeDetails.isFilled then routeDetails.displayColour else 'white'
          opacity = if routeDetails.isFilled then TAKEN_HOVER_OPACITY else NOT_TAKEN_HOVER_OPACITY
          route.attr('fill', fill)
          route.attr('opacity', opacity)
          route.css('cursor', 'pointer')
        ->
          opacity = if routeDetails.isFilled then TAKEN_OPACITY else NOT_TAKEN_OPACITY
          route.attr('opacity', opacity)
          route.css('cursor', 'default')
      )

      route.click ->
        window.location.href += "/claim_route/new?utf8=✓&route_id=" + routeDetails.routeId

  if $('.interactive.board').length > 0
    $.get window.location.href + '/board.json', (board) ->
      board.forEach setupRoute
