var app = angular.module('myApp', []);

app.controller('myCtrl', function($scope, $timeout, $compile) {
	$scope.temperature = "40";
	$scope.afterRendering = function(html) {
		$timeout(function() {
			$compile(html)($scope);
			console.log('yeaah');
		}, 2000);
	};
});

app.constant('items', [
	{
		type: "text",
		title: "T Sensor",
		description: 'temperature: <p ng-bind="temperature"></p>',
		position: {
			left: 300,
			top: 50
		},
		link: {
			url: "#",
			label: "View more >"
		}
	}]
);

app.constant('options', {
	debug: true,
	allowHtml: true,
	shareBox: false
});

app.directive('interactiveimage', ['$timeout', '$compile', 'items', 'options', function($timeout, $compile, items, options) {
	return {
		restrict: 'A',
		compile: function(element) {
			angular.element(element).interactiveImage(items, options);
		}
	};
}]);
