/*global QUnit*/

sap.ui.define([
	"comsiva.app./codegenerator/controller/CodeGenerator.controller"
], function (Controller) {
	"use strict";

	QUnit.module("CodeGenerator Controller");

	QUnit.test("I should test the CodeGenerator controller", function (assert) {
		var oAppController = new Controller();
		oAppController.onInit();
		assert.ok(oAppController);
	});

});
