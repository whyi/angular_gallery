app = angular.module 'myApp'
 
class MenuController extends BaseController
  @register app, "MenuController"

  @inject '$scope', '$http'
 
  MENU_JSON_API_PATH = "api/menuJson"

  # initialize the controller
  initialize: ->
    @$scope.menuJson = {}
    @loadMenuJson()

  loadMenuJson: ->
    @$http.get(MENU_JSON_API_PATH)
      .success (response) =>
        @$scope.menuJson = response
      .error (response) =>
        console.log(angular.toJson(response))
