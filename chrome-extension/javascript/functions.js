var getLocaleFromNavigator;

getLocaleFromNavigator = function() {
  var language;
  language = window.navigator.language;
  if (language.indexOf('en') === 0) {
    return 'en';
  } else if (language.indexOf('cs ') === 0) {
    return 'cs';
  } else {
    return 'en';
  }
};
