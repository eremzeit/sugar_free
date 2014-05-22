class ElementMutator
  @do: ($elem, action_type, options) ->
    @hideElement($elem)
    
  @hideElement: ($elem) ->
    $elem.addClass('sugar-free-hide')

  @hideElementByCSS:(cssSelector)->
    str = "#{cssSelector} { display:none; }"
    @_injectCSS(str)
  
  @_injectCSS:(cssString)->
    console.log('injecting...')
    html = "<style type='text/css'>#{cssString}</style>"
    console.log(html)
    $('head').append($(html))
     
    
    
