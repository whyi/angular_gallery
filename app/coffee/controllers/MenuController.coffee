app = angular.module 'myApp'
 
class ManuController extends BaseController
  @register app, "MenuController"

  @inject '$scope'
 
  # initialize the controller
  initialize: ->
    @loadMenuJson()

  loadMenuJson: ->
    @$scope.menuJson = [
      {"title":"view1"},
      {"title":"view2"},
    ]
