
getLocaleFromNavigator = ->
    language = window.navigator.language
    if language.indexOf('en') is 0
        'en'
    else if language.indexOf('cs ') is 0
        'cs'
    else
        'en'
