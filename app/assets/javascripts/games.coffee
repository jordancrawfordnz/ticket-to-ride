document.addEventListener "turbolinks:load", ->
  $(".new-game select").each (index, element) ->
    element.value = element.options[index].value
