console.log('LOADING PAGE JUDGE')
class PageJudge
  @isPageMatch: (pageMatcher) ->
    $.trim(pageMatcher.host) == $.trim(location.host)

