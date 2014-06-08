// Generated by CoffeeScript 1.7.1
(function() {
  var ElementJudge, ElementMutator, InjunctionExecutor, PageJudge, e;

  if (window.sugar_free == null) {
    window.sugar_free = {};
  }

  window.sugar_free.sample_injunctions = [
    {
      page_matcher: {
        protocol: '*',
        host: 'www.youtube.com',
        path: '*'
      },
      action_list: [
        {
          type: 'hide',
          matchers: [
            {
              css: '.share-panel-embed'
            }, {
              css: '.share-panel-email'
            }, {
              css: '#watch-like'
            }, {
              css: '#watch-dislike'
            }, {
              css: '#watch-discussion'
            }, {
              css: '#share-services-container'
            }, {
              css: '#footer-links'
            }
          ]
        }
      ]
    }, {
      page_matcher: {
        protocol: '*',
        host: 'www.bbc.com',
        path: '*'
      },
      action_list: [
        {
          type: 'hide',
          matchers: [
            {
              css: '#whateverman'
            }
          ]
        }
      ]
    }, {
      page_matcher: {
        protocol: '*',
        host: 'www.facebook.com',
        path: '*'
      },
      action_list: [
        {
          type: 'hide',
          matchers: [
            {
              css: '#pagelet_rhc_footer'
            }, {
              css: '#groupsNav'
            }, {
              css: '#appsNav'
            }, {
              css: '#pagesNav'
            }, {
              css: '#listsNav'
            }, {
              css: '#interestsNav'
            }, {
              css: '#pagelet_trending_tags_and_topics'
            }, {
              css: '#pagelet_sidebar'
            }
          ]
        }
      ]
    }
  ];

  ElementJudge = (function() {
    function ElementJudge() {}

    ElementJudge.match = function(elementMatcher) {
      var fn, matched, type, value;
      if (_.isEmpty(elementMatcher)) {
        return $('*').not('*');
      }
      matched = $('*');
      for (type in elementMatcher) {
        value = elementMatcher[type];
        fn = this["_match_" + type];
        matched = fn(matched, value);
      }
      return matched;
    };

    ElementJudge._match_css = function($matched, str) {
      return $matched.filter(str);
    };

    ElementJudge._match_id = function($matched, id) {
      return $matched.filter('#' + id);
    };

    ElementJudge._match_class = function($matched, cls) {
      return $matched.filter('.' + cls);
    };

    return ElementJudge;

  })();

  ElementMutator = (function() {
    function ElementMutator() {}

    ElementMutator["do"] = function(injunction) {
      var $elem;
      $elem = ElementJudge.match(injunction.matcher);
      if (injunction.type === 'hide') {
        return this.hideElement($elem);
      } else if (injunction.type === 'invisible') {
        return this.hideElement($elem);
      } else if (injunction.type === 'obscure') {
        return this.hideElement($elem);
      }
    };

    ElementMutator.doWithCss = function(injunction) {
      var str;
      if (injunction.type === 'hide') {
        str = "" + injunction.matcher.css + " { display:none; }";
        return this._injectCss(str);
      } else {
        return null;
      }
    };

    ElementMutator.hideElement = function($elem) {
      return $elem.addClass('sugar-free-hide');
    };

    ElementMutator._injectCss = function(cssString) {
      var html;
      console.log('injecting...');
      html = "<style type='text/css'>" + cssString + "</style>";
      console.log(html);
      return $('head').append($(html));
    };

    ElementMutator.addCSSSelectorForListening = function(cssSelector) {
      var template;
      template = "{\n  animation-duration: 0.001s;\n  animation-name: nodeInserted;\n  -webkit-animation-duration: 0.001s;\n  -webkit-animation-name: nodeInserted;\n}";
      return this._injectCSS(cssSelector + template);
    };

    return ElementMutator;

  })();

  console.log('LOADING PAGE JUDGE');

  PageJudge = (function() {
    function PageJudge() {}

    PageJudge.isPageMatch = function(pageMatcher) {
      return $.trim(pageMatcher.host) === $.trim(location.host);
    };

    return PageJudge;

  })();

  console.log('LOADING SUGAR FREE');

  InjunctionExecutor = (function() {
    function InjunctionExecutor(injunctions) {
      this.injunctions = this._flattenInjunctions(injunctions);
    }

    InjunctionExecutor.prototype.start = function() {
      console.log('START!');
      return this.execute();
    };

    InjunctionExecutor.prototype.execute = function() {
      var injunction, _i, _len, _ref, _results;
      console.log('executing');
      _ref = this.injunctions;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        injunction = _ref[_i];
        console.log('injunction');
        if (injunction.served) {
          continue;
        } else if (this.isMatcherCssBased(injunction) && this.isHideMethodCssBased(injunction)) {
          console.log("should be executing this.");
          console.log(injunction);
          ElementMutator.doWithCss(injunction);
          _results.push(injunction.served = true);
        } else {
          _results.push(ElementMutator["do"](injunction));
        }
      }
      return _results;
    };

    InjunctionExecutor.prototype.canMatchElement = function(injunction) {
      return ElementJudge.match(injunction.matcher);
    };

    InjunctionExecutor.prototype.isMatcherCssBased = function(injunction) {
      return true;
    };

    InjunctionExecutor.prototype.isHideMethodCssBased = function(injunction) {
      return true;
    };

    InjunctionExecutor.prototype._flattenInjunctions = function(injunctions) {
      var action, injunction, list, matcher, _i, _j, _k, _len, _len1, _len2, _ref, _ref1;
      list = [];
      for (_i = 0, _len = injunctions.length; _i < _len; _i++) {
        injunction = injunctions[_i];
        if (!PageJudge.isPageMatch(injunction.page_matcher)) {
          continue;
        }
        _ref = injunction.action_list;
        for (_j = 0, _len1 = _ref.length; _j < _len1; _j++) {
          action = _ref[_j];
          _ref1 = action.matchers;
          for (_k = 0, _len2 = _ref1.length; _k < _len2; _k++) {
            matcher = _ref1[_k];
            list.push({
              type: action.type,
              matcher: matcher
            });
          }
        }
      }
      return list;
    };

    InjunctionExecutor.prototype._initializeInsertionListening = function() {
      var callback;
      callback = (function(_this) {
        return function() {
          if (event.animationName === "nodeInserted") {
            console.warn("Another node has been inserted! ", event, event.target);
            return _this.animationCallback($(event.target));
          }
        };
      })(this);
      document.addEventListener("animationstart", callback, false);
      document.addEventListener("MSAnimationStart", callback, false);
      return document.addEventListener("webkitAnimationStart", callback, false);
    };

    return InjunctionExecutor;

  })();

  e = new InjunctionExecutor(window.sugar_free.sample_injunctions);

  e.start();

}).call(this);
