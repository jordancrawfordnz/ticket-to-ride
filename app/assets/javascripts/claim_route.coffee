document.addEventListener "turbolinks:load", ->
  $(".img-check").click ->
    $(this).toggleClass("checked")

  routePreviewBoards = $('.route-preview.board')
  if routePreviewBoards.length > 0
    routeSVGId = routePreviewBoards.data('routesvgid')

    route = $('#svg_' + routeSVGId)
    route.attr('filter', 'url(#glow)')
    route.attr('fill', 'orange')
    route.attr('opacity', 0.7)
