$ ->
  modal_holder_selector = "#modal-holder"
  modal_selector = ".modal"

  $(document).on "click", "a[data-modal]", ->
    location = $(this).attr("href")
    $.get location, (data)->
      $(modal_holder_selector).html(data).
      find(modal_selector).modal()
    false

  $(document).on("ajax:success",
    "form[data-modal]", (event, data, status, xhr)->
      url = xhr.getResponseHeader("Location")
      if url
        window.location = url
      else
        $(".modal-backdrop").remove()
        $(modal_holder_selector).html(data).
        find(modal_selector).modal()
      false
  ).on("ajax:error", (event, data, status, xhr) ->
    document.append("<p>ERROR</p>"););

