'use strict';

/* molecularNatsicology Module */

var molecularnatsicologyApp = angular.module('molecularnatsicologyApp', [
  'ngRoute',
  // 'molecularnatsicologyAnimations',
  'molecularnatsicologyControllers',
  // 'molecularnatsicologyFilters',
  'molecularnatsicologyServices',
  'ngDragDrop',
  'infinite-scroll'
]);

// molecularnatsicologyApp.config(['$routeProvider',
//   function($routeProvider) {
//     $routeProvider.
//       when('/courses', {
//         templateUrl: 'assets/course-list.html.haml',
//         controller: 'CourseListCtrl'
//       }).
//       when('/courses/:courseId', {
//         templateUrl: 'assets/course-detail.html.haml',
//         controller: 'CourseDetailCtrl'
//       }).
//       when('/', {
//         templateUrl: 'assets/plan-list.html.haml',
//         controller: 'PlanListCtrl'
//       }).
//       when('/:planId', {
//         templateUrl: 'assets/plan-detail.html.haml',
//         controller: 'PlanDetailCtrl'
//       });
//   }]);