fade_specs = [
  {
    site: {
      protocol: '*'
      host: 'www.bbc.com'
      path: '*'
    }
    action_list: [
      {
        element_match: {
          class:'page-title'
        }
        type: 'hide'
      }
      
    ]
    
  }
]



class SpecsExecutor
  constructor: (@fade_specs) ->
     
  execute: ->
    console.log("Attempting to run SpecsExecutor")

    for spec in @fade_specs
      console.log ("Trying spec: #{spec}")
      if @doesMatchSite(spec.site)
        console.log ("Executing spec: #{spec}")
        for action in spec.action_list
          $matchedElements = @match(action.element_match)
          @doAction($matchedElements, action.type, {})

  doesMatchSite: (site_matcher) ->
    console.log(site_matcher)
    console.log(location)
    return true
    !site_matcher.host == location.host

  match: (elementMatcher) ->
    return $('*').not('*') if _.isEmpty(elementMatcher)

    console.log("element_match:")
    console.log(elementMatcher)
    matched = $('*')
    for type,value of elementMatcher
      console.log('aeou')
      fn = this["_match_#{type}"]
      console.log(fn)
      matched = fn(matched, value)
    matched
  
  _match_id: ($matched, id) ->
    $matched.filter('#' + id)
  
  _match_class: ($matched, cls) ->
    $matched.filter('.' + cls)

  doAction: ($elem, action_type, options) ->
    @_hide_element($elem)
    
  _hide_element: ($elem) ->
    $elem.css('background-color', 'red')


console.log("STARTED!")
e = new SpecsExecutor(fade_specs)
e.execute()
