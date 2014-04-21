#load submodules

angular.module 'molecularnatsicology.controllers', []

#molecularnatsicology Module

molecularnatsicology = angular.module 'molecularnatsicology', [
  'ngDragDrop'
  'ngRoute'
  'infinite-scroll'
  'molecularnatsicology.controllers'
]

