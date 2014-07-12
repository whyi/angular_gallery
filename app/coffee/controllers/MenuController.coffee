app = angular.module 'myApp'
 
class ManuController extends BaseController
  @register app, "MenuController"

  @inject '$scope'
 
  # initialize the controller
  initialize: ->
    @$scope.menuJson = [
      {"title":"view1"},
      {"title":"view2"},
    ]

    @$scope.msg =
      title: "Hello"
 