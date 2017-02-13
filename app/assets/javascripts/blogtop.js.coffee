ready = ->
    $(window).scroll ->
        element = $('#blog-top-btn')
        visible = element.is(':visible')
        height = $(window).scrollTop()
        if height > 200
            element.fadeIn() if !visible
        else
            element.fadeOut()
    $(document).on 'click', '#move-blog-top', ->
        $('html, body').animate({ scrollTop: 0 }, 'fast')
        
$(document).ready(ready)
$(document).on('page:load', ready)
     