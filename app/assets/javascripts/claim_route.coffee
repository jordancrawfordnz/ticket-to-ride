document.addEventListener "turbolinks:load", ->
  $(".img-check").click ->
    $(this).toggleClass("checked")
