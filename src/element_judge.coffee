class ElementJudge
  @match: (elementMatcher) ->
    return $('*').not('*') if _.isEmpty(elementMatcher)

    matched = $('*')
    for type,value of elementMatcher
      fn = this["_match_#{type}"]
      matched = fn(matched, value)
    matched
  
  @_match_css: ($matched, str) ->
    #we assume that the css matcher can be directly dropped into a jquery query
    $matched.filter(str)
  
  @_match_id: ($matched, id) ->
    $matched.filter('#' + id)
  
  @_match_class: ($matched, cls) ->
    $matched.filter('.' + cls)

