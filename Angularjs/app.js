var app = angular.module('myApp', []);

app.controller('myCtrl', function($scope, $compile) {
    $scope.temperature = "45";
    $scope.afterRendering = function(html) {
        $compile(html)($scope);      
    };
});