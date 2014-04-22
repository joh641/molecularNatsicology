#Courses controller

angular.module('molecularnatsicology.controllers').controller 'CourseListCtrl', ['$scope', '$http', '$filter', ($scope, $http, $filter) ->  
  $http.get("/courses/search?course=all").success (data) ->
    $scope.courses = data
    $scope.totalDisplayed = 20
 
  $scope.addMoreCourses = ->
    $scope.totalDisplayed += 30

  $scope.filterCourses = ->
    $filter('filter') $scope.courses, $scope.query

  $scope.$watchCollection 'garbage', ->
    $scope.garbage = []

  $scope.$watch 'query', ->
    $scope.totalDisplayed = 20
]