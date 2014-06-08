console.log('LOADING SUGAR FREE')

class InjunctionExecutor
  constructor: (injunctions) ->
    @injunctions = @_flattenInjunctions(injunctions)
     
  start: ->
    console.log('START!')
    #@_initializeInsertionListening()
    @execute()


  execute: ->
    console.log('executing')
    for injunction in @injunctions
      console.log('injunction')
      if injunction.served
        continue
      else if @isMatcherCssBased(injunction) && @isHideMethodCssBased(injunction)
        console.log("should be executing this.")
        console.log(injunction)
        ElementMutator.doWithCss(injunction)
        injunction.served = true
      else
        ElementMutator.do(injunction)

  canMatchElement: (injunction) ->
    ElementJudge.match(injunction.matcher)

  isMatcherCssBased: (injunction) ->
    true
  
  isHideMethodCssBased: (injunction) ->
    true
  
  _flattenInjunctions: (injunctions)->
    list = []

    for injunction in injunctions
      if not PageJudge.isPageMatch(injunction.page_matcher)
        continue

      for action in injunction.action_list
        for matcher in action.matchers
          list.push(
            {
              type: action.type
              matcher: matcher
            }
          )
    list

  _initializeInsertionListening: ->
    callback = =>
      if event.animationName == "nodeInserted"
        console.warn("Another node has been inserted! ", event, event.target)
        @animationCallback($(event.target))

    document.addEventListener("animationstart", callback, false); # standard + firefox
    document.addEventListener("MSAnimationStart", callback, false); # IE
    document.addEventListener("webkitAnimationStart", callback, false); # Chrome + Safari


e = new InjunctionExecutor(window.sugar_free.sample_injunctions)
e.start()
