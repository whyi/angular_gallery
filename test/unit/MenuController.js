// Generated by CoffeeScript 1.7.1
(function() {
  describe("MenuController", function() {
    var HTTP_NOT_FOUND, HTTP_OK, MENU_JSON_API_PATH, SAMPLE_ERROR_JSON, SAMPLE_MENU_JSON, givenAjaxCallReturns, http, httpBackend, menuController, scope, thenAjaxCallIsMadeTo, thenLoadMenuJsonIsCalled, thenMenuJsonInScopeIs, thenReportErrorIsCalledWith, whenInitialize, whenLoadMenuJson;
    beforeEach(module('myApp'));
    HTTP_OK = 200;
    HTTP_NOT_FOUND = 404;
    menuController = null;
    httpBackend = null;
    scope = null;
    http = null;
    beforeEach(inject(function($controller, $rootScope, $http, $httpBackend) {
      scope = $rootScope.$new();
      httpBackend = $httpBackend;
      http = $http;
      return menuController = $controller("MenuController", {
        $scope: scope,
        $http: http
      });
    }));
    MENU_JSON_API_PATH = "api/menuJson";
    SAMPLE_MENU_JSON = {
      menuItems: [
        {
          "title": "view1"
        }, {
          "title": "view2"
        }
      ]
    };
    SAMPLE_ERROR_JSON = {
      "statusCode": "HTTP_NOT_FOUND",
      "erorrMessage": "couldn\'t load menu json"
    };
    givenAjaxCallReturns = function(status, json) {
      return httpBackend.when("GET", MENU_JSON_API_PATH).respond(status, json);
    };
    whenInitialize = function() {
      spyOn(menuController, "loadMenuJson");
      return menuController.initialize();
    };
    whenLoadMenuJson = function() {
      spyOn(http, "get").andCallThrough();
      spyOn(menuController, "reportError").andCallThrough();
      return menuController.loadMenuJson();
    };
    thenLoadMenuJsonIsCalled = function() {
      return expect(menuController.loadMenuJson).toHaveBeenCalled();
    };
    thenAjaxCallIsMadeTo = function(endpoint) {
      httpBackend.flush();
      return expect(http.get).toHaveBeenCalledWith(endpoint);
    };
    thenMenuJsonInScopeIs = function(json) {
      httpBackend.flush();
      return expect(scope.menuJson).toEqual(json);
    };
    thenReportErrorIsCalledWith = function(errorMessage) {
      httpBackend.flush();
      return expect(menuController.reportError).toHaveBeenCalledWith(errorMessage);
    };
    describe("when initialize", function() {
      beforeEach(function() {
        return whenInitialize();
      });
      return it("calls loadMenuJson()", function() {
        return thenLoadMenuJsonIsCalled();
      });
    });
    describe("given ajax call to " + MENU_JSON_API_PATH + " is successful", function() {
      beforeEach(function() {
        return givenAjaxCallReturns(HTTP_OK, SAMPLE_MENU_JSON);
      });
      return describe("when load menu json", function() {
        beforeEach(function() {
          return whenLoadMenuJson();
        });
        it("should make ajax call to " + MENU_JSON_API_PATH, function() {
          return thenAjaxCallIsMadeTo(MENU_JSON_API_PATH);
        });
        return it("should set the json to scope", function() {
          return thenMenuJsonInScopeIs(SAMPLE_MENU_JSON);
        });
      });
    });
    describe("given ajax call to " + MENU_JSON_API_PATH + " returns 404", function() {
      beforeEach(function() {
        return givenAjaxCallReturns(HTTP_NOT_FOUND, SAMPLE_ERROR_JSON);
      });
      return describe("when load menu json", function() {
        beforeEach(function() {
          return whenLoadMenuJson();
        });
        it("should make ajax call to " + MENU_JSON_API_PATH, function() {
          return thenAjaxCallIsMadeTo(MENU_JSON_API_PATH);
        });
        return it("should report error", function() {
          return thenReportErrorIsCalledWith(SAMPLE_ERROR_JSON["errorMessage"]);
        });
      });
    });
    describe("when reportError()", function() {
      beforeEach(function() {
        return menuController.reportError();
      });
      return it("should display error as \"Sorry, there was an error occurred.\"", function() {
        return expect(scope.errorMessage).toBe("Sorry, there was an error occurred.");
      });
    });
    return describe("when reportError(\"foo\")", function() {
      beforeEach(function() {
        return menuController.reportError("foo");
      });
      return it("should display error as \"foo\"", function() {
        return expect(scope.errorMessage).toBe("foo");
      });
    });
  });

}).call(this);
