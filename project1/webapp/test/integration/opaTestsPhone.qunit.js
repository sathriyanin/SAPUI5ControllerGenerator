/* global QUnit */

QUnit.config.autostart = false;

sap.ui.getCore().attachInit(function() {
	"use strict";

	sap.ui.require([
		"project1/test/integration/PhoneJourneys"
	], function() {
		QUnit.start();
	});
});