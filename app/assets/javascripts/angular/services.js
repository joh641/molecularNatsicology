'use strict';

/* Services */

var molecularnatsicologyServices = angular.module('molecularnatsicologyServices', ['ngResource']);

molecularnatsicologyServices.factory('Course', ['$resource',
  function($resource){
    return $resource('/courses/search?course=:courseId', {}, {
      query: {method:'GET', params:{courseId:'all'}, isArray:true}
    });
  }]);

molecularnatsicologyServices.factory('Plan', ['$resource',
  function($resource){
    return $resource('/plans/:planId.json', {}, {

    });
  }]);