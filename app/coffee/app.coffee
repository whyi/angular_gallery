app = angular
  .module( 'myApp', ['ngRoute', 'ui.bootstrap'])
  .config( ['$routeProvider', ($routeProvider)->
      $routeProvider.when('/view1', {templateUrl: 'partials/partial1.html'})
      $routeProvider.when('/view2', {templateUrl: 'partials/partial2.html'})
      $routeProvider.otherwise({redirectTo: '/view1'})
    ])

root = exports ? this
unless root.app
  root.app = app

angular.bootstrap(document,['myApp'])