#return empty if query is blank

angular.module('molecularnatsicology.filters').filter 'emptyIfBlank', ['$filter', ($filter) ->
  (object, query) ->
    if not query then {} else object
]