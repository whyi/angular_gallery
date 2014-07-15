beforeEach module('myApp')

describe "MenuController", ->

	HTTP_OK = 200
	menuController = null
	httpBackend = null
	scope = null

	beforeEach inject ($controller, $rootScope, $http, $httpBackend) ->
		scope = $rootScope.$new()
		httpBackend = $httpBackend
		menuController = $controller("MenuController", {$scope:scope})

	MENU_JSON_API_PATH = "api/menuJson"
	SAMPLE_MENU_JSON = {
    	menuItems: [
	        {
	            "title": "view1"
	        },
	        {
	            "title": "view2"
	        }
	    ]
	}

	# expectations and mocks
	givenAjaxCallReturns = (json) ->
		httpBackend.expectGET(MENU_JSON_API_PATH).respond(HTTP_OK, json)

	# invocations
	whenInitialize = ->
		spyOn(menuController, "loadMenuJson")
		menuController.initialize()

	whenLoadMenuJson = ->
		httpBackend.expectGET(MENU_JSON_API_PATH);
		menuController.loadMenuJson()

	# comparisons
	thenLoadMenuJsonIsCalled = ->
		expect(menuController.loadMenuJson).toHaveBeenCalled()

	thenAjaxCallIsMadeTo = (endpoint) ->
		httpBackend.flush()
		expect(true).toBe(false)

	thenMenuJsonInScopeIs = (json) ->
		httpBackend.flush()
		expect(scope.menuJson).toBe(json)

	describe "when initialize", ->
		beforeEach ->
			whenInitialize()

		it "calls loadMenuJson()", ->
			thenLoadMenuJsonIsCalled()

	describe "when load menu json", ->
		beforeEach ->
			whenLoadMenuJson()

		it "should make ajax call to" + MENU_JSON_API_PATH, ->
			thenAjaxCallIsMadeTo(MENU_JSON_API_PATH)

	describe "given ajax call to " + MENU_JSON_API_PATH + " is successful", ->
		beforeEach ->
			givenAjaxCallReturns(SAMPLE_MENU_JSON)

		describe "when load menu json", ->
			beforeEach ->
				whenLoadMenuJson()

			it "should set the json to scope", ->
				thenMenuJsonInScopeIs(SAMPLE_MENU_JSON)
