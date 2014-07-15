app = angular.module 'myApp'
 
class ManuController extends BaseController
  @register app, "MenuController"

  @inject '$scope', '$http'
 
  MENU_JSON_API_PATH = "api/menuJson"

  # initialize the controller
  initialize: ->
    @loadMenuJson()

  loadMenuJson: ->
    @$http.get(MENU_JSON_API_PATH)
      .success(response) =>
        @$scope.menuJson = response
