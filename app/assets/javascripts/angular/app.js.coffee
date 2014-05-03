#load submodules

angular.module 'molecularnatsicology.controllers', []
angular.module 'molecularnatsicology.filters', []

#molecularnatsicology Module

molecularnatsicology = angular.module 'molecularnatsicology', [
  'ngDragDrop'
  'ngRoute'
  'infinite-scroll'
  'angular-intro'
  'molecularnatsicology.controllers'
  'molecularnatsicology.filters'
]

