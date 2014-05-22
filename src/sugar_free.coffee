ElementMutator
console.log('LOADING SUGAR FREE')

class InjunctionExecutor
  constructor: (@injunctions) ->
     
  execute: ->
    for injunction in @injunctions
      if not PageJudge.isPageMatch(injunction.page_matcher)
        console.log("Page is not a match: #{injunction.page_matcher}")
        continue

      for action in injunction.action_list
        for matcher in action.matchers
          #$matchedElements = ElementJudge.match(matcher)
          #ElementMutator.do($matchedElements, action.type, {})
          if matcher.css?
            ElementMutator.hideElementByCSS(matcher.css)


  addInsertionListener: (cssQuery)->
    
animationCallback = ->
  if event.animationName == "nodeInserted"
    # This is the debug for knowing our listener worked!
    # event.target is the new node!
    console.warn("Another node has been inserted! ", event, event.target)

#document.addEventListener("animationstart", animationCallback, false); # standard + firefox
#document.addEventListener("MSAnimationStart", animationCallback, false); # IE
#document.addEventListener("webkitAnimationStart", animationCallback, false); # Chrome + Safari

e = new InjunctionExecutor(window.sugar_free.sample_injunctions)
e.execute()
