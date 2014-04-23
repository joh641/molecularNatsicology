#return empty if query is blank

angular.module('molecularnatsicology.filters').filter 'satisfied', ['$filter', ($filter) ->
  (input) ->
    if input then '\u2713' else '\u2718'
]

angular.module('molecularnatsicology.filters').filter 'color', ['$filter', ($filter) ->
  (input) ->
    if input then "green" else "red"
]