if !window.sugar_free?
  window.sugar_free = {}

window.sugar_free.sample_injunctions = [
  {
    page_matcher: { protocol: '*', host: 'www.youtube.com', path: '*' }
    action_list: [
      {
        type:'hide'
        matchers: [
          { css: '.share-panel-embed' }
          { css: '.share-panel-email' }
          { css: '#watch-like' }
          { css: '#watch-dislike' }
          { css: '#watch-discussion' }
          { css: '#share-services-container' }
          { css: '#footer-links' }
        ]
      }
    ]
    
  }
  {
    page_matcher: { protocol: '*', host: 'www.bbc.com', path: '*' }
    action_list: [
      {
        type:'hide'
        matchers: [
          { css: '#whateverman' }
        ]
      }
    ]
    
  }
  
  {
    page_matcher: { protocol: '*', host: 'www.facebook.com', path: '*' }
    action_list: [
      {
        type:'hide'
        matchers: [
          { css: '#pagelet_rhc_footer' }
          { css: '#groupsNav' }
          { css: '#appsNav' }
          { css: '#pagesNav' }
          { css: '#listsNav' }
          { css: '#interestsNav' }
          { css: '#pagelet_trending_tags_and_topics' }
          { css: '#pagelet_sidebar' }
        ]
      }
    ]
    
  }
]

