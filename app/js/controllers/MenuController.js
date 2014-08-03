// Generated by CoffeeScript 1.7.1
(function() {
  var MenuController, app,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  app = angular.module('myApp');

  MenuController = (function(_super) {
    var DEFAULT_ERROR_MESSAGE, MENU_JSON_API_PATH;

    __extends(MenuController, _super);

    function MenuController() {
      return MenuController.__super__.constructor.apply(this, arguments);
    }

    MenuController.register(app, "MenuController");

    MenuController.inject('$scope', '$http');

    MENU_JSON_API_PATH = "api/menuJson";

    DEFAULT_ERROR_MESSAGE = "Sorry, there was an error occurred.";

    MenuController.prototype.initialize = function() {
      this.$scope.menuJson = {};
      return this.loadMenuJson();
    };

    MenuController.prototype.reportError = function(errorMessage) {
      if (errorMessage == null) {
        errorMessage = DEFAULT_ERROR_MESSAGE;
      }
      return this.$scope.errorMessage = errorMessage;
    };

    MenuController.prototype.loadMenuJson = function() {
      return this.$http.get(MENU_JSON_API_PATH).success((function(_this) {
        return function(response) {
          return _this.$scope.menuJson = response;
        };
      })(this)).error((function(_this) {
        return function(response) {
          return _this.reportError(response["errorMessage"]);
        };
      })(this));
    };

    return MenuController;

  })(BaseController);

}).call(this);
