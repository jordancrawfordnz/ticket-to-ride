# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

TAKEN_OPACITY = 0.5
TAKEN_HOVER_OPACITY = 0.8
NOT_TAKEN_OPACITY = 0
NOT_TAKEN_HOVER_OPACITY = 0.5

document.addEventListener "turbolinks:load", ->
  setupRoute = (routeDetails) ->
    route = $(routeDetails.svgId)
    route.attr('filter', 'url(#glow)')

    if routeDetails.isFilled
      route.attr('fill', routeDetails.displayColour)
      route.attr('opacity', TAKEN_OPACITY)
    else
      route.attr('opacity', NOT_TAKEN_OPACITY)

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

  setupRoute({
    displayColour: 'green',
    isFilled: true,
    svgId: '#svg_118',
    routeId: 20
  })

  setupRoute({
    svgId: '#svg_136',
    routeId: 30
  })
