var app = angular.module('myApp', []);
    app.controller('myCtrl', function($scope, $compile) {
      $scope.temperature = "40";
	  
	  $scope.loaded = function() {
		   var html = $('#my-interactive-image');
		   $compile(html)($scope);      
      };
    });
