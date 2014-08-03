describe "MenuController", ->
	beforeEach module('myApp')

	HTTP_OK = 200
	HTTP_NOT_FOUND = 404
	menuController = null
	httpBackend = null
	scope = null
	http = null

	beforeEach inject ($controller, $rootScope, $http, $httpBackend) ->
		scope = $rootScope.$new()
		httpBackend = $httpBackend
		http = $http
		menuController = $controller("MenuController", {$scope:scope, $http:http})

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

	SAMPLE_ERROR_JSON = {
		"statusCode": "HTTP_NOT_FOUND"
		"erorrMessage": "couldn\'t load menu json"
    }

	# expectations and mocks
	givenAjaxCallReturns = (status, json) ->
		httpBackend.when("GET", MENU_JSON_API_PATH).respond(status, json)

	# invocations
	whenInitialize = ->
		spyOn(menuController, "loadMenuJson")
		menuController.initialize()

	whenLoadMenuJson = ->
		spyOn(http, "get").andCallThrough()
		spyOn(menuController, "reportError").andCallThrough()
		menuController.loadMenuJson()

	# comparisons
	thenLoadMenuJsonIsCalled = ->
		expect(menuController.loadMenuJson).toHaveBeenCalled()

	thenAjaxCallIsMadeTo = (endpoint) ->
		httpBackend.flush()
		expect(http.get).toHaveBeenCalledWith(endpoint)

	thenMenuJsonInScopeIs = (json) ->
		httpBackend.flush()
		expect(scope.menuJson).toEqual(json)

	thenReportErrorIsCalledWith = (errorMessage) ->
		httpBackend.flush()
		expect(menuController.reportError).toHaveBeenCalledWith(errorMessage)

	describe "when initialize", ->
		beforeEach ->
			whenInitialize()

		it "calls loadMenuJson()", ->
			thenLoadMenuJsonIsCalled()

	describe "given ajax call to " + MENU_JSON_API_PATH + " is successful", ->
		beforeEach ->
			givenAjaxCallReturns(HTTP_OK, SAMPLE_MENU_JSON)

		describe "when load menu json", ->
			beforeEach ->
				whenLoadMenuJson()

			it "should make ajax call to " + MENU_JSON_API_PATH, ->
				thenAjaxCallIsMadeTo(MENU_JSON_API_PATH)

			it "should set the json to scope", ->
				thenMenuJsonInScopeIs(SAMPLE_MENU_JSON)

	describe "given ajax call to " + MENU_JSON_API_PATH + " returns 404", ->
		beforeEach ->
			givenAjaxCallReturns(HTTP_NOT_FOUND, SAMPLE_ERROR_JSON)

		describe "when load menu json", ->
			beforeEach ->
				whenLoadMenuJson()

			it "should make ajax call to " + MENU_JSON_API_PATH, ->
				thenAjaxCallIsMadeTo(MENU_JSON_API_PATH)

			it "should report error", ->
				thenReportErrorIsCalledWith(SAMPLE_ERROR_JSON["errorMessage"])
