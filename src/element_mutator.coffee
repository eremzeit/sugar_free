class ElementMutator
  @do: (injunction) ->
    $elem = ElementJudge.match(injunction.matcher)
    if injunction.type == 'hide'
      @hideElement($elem)
    else if injunction.type == 'invisible'
      @hideElement($elem)
    else if injunction.type == 'obscure'
      @hideElement($elem)

  @doWithCss:(injunction)->
    if injunction.type == 'hide'
      str = "#{injunction.matcher.css} { display:none; }"
      @_injectCss(str)
    else
      return null
    
  @hideElement: ($elem) ->
    $elem.addClass('sugar-free-hide')

  
  @_injectCss:(cssString)->
    console.log('injecting...')
    html = "<style type='text/css'>#{cssString}</style>"
    console.log(html)
    $('head').append($(html))
     
  @addCSSSelectorForListening: (cssSelector) ->
    template = """{
      animation-duration: 0.001s;
      animation-name: nodeInserted;
      -webkit-animation-duration: 0.001s;
      -webkit-animation-name: nodeInserted;
    }"""
    
    @_injectCSS(cssSelector + template)
