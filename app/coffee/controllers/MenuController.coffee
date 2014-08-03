app = angular.module 'myApp'
 
class MenuController extends BaseController
  @register app, "MenuController"

  @inject '$scope', '$http'
 
  MENU_JSON_API_PATH = "api/menuJson"
  DEFAULT_ERROR_MESSAGE = "Sorry, there was an error occurred."

  # initialize the controller
  initialize: ->
    @$scope.menuJson = {}
    @loadMenuJson()

  reportError:(errorMessage=DEFAULT_ERROR_MESSAGE) ->
    @$scope.errorMessage = errorMessage

  loadMenuJson: ->
    @$http.get(MENU_JSON_API_PATH)
      .success (response) =>
        @$scope.menuJson = response
      .error (response) =>
        @reportError(response["errorMessage"])
