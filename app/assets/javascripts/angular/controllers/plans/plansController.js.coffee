#Plans controller

angular.module('molecularnatsicology.controllers').controller 'PlanDetailCtrl', ['$scope', '$http', ($scope, $http) ->
  $scope.semesters = ['backpack','fall1','fall2','fall3','fall4','spring1','spring2','spring3','spring4','summer1','summer2','summer3','summer4']
  $scope.garbage = []
  $scope.plan = {}

  $scope.findSemester = (data, name) ->
    for semester in data
      return semester[name] if semester[name]
    []
  
  $scope.updatePlan = ->
    for semester in $scope.semesters
      $scope.plan[semester] = $scope[semester]

  $scope.savePlan = ->
    $http.put("#{window.location.pathname}/save", $scope.plan).success ->
      $scope.updateRules()
  
  $scope.updateRules = ->
    $http.get("#{window.location.pathname}/check.json").success (data) ->
      $scope.rules = data

  $scope.update = ->
    $scope.updatePlan()
    $scope.savePlan()

  $http.get("#{window.location.pathname}.json").success (data) ->
    for semester in $scope.semesters
      $scope[semester] = $scope.findSemester data, semester
      $scope.$watchCollection semester, ->
        $scope.update()
    $scope.updateRules()
]