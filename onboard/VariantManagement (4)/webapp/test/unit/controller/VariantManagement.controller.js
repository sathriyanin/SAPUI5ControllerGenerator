/*global QUnit*/

sap.ui.define([
	"varaintManagement/VariantManagement/controller/VariantManagement.controller"
], function (Controller) {
	"use strict";

	QUnit.module("VariantManagement Controller");

	QUnit.test("I should test the VariantManagement controller", function (assert) {
		var oAppController = new Controller();
		oAppController.onInit();
		assert.ok(oAppController);
	});

});