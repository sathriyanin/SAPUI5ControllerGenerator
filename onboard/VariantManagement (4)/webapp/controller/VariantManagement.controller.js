sap.ui.define([
	"sap/ui/core/mvc/Controller", "sap/m/TablePersoController"
], function (Controller, TablePersoController) {
	"use strict";
	var oTablepersoService;
	return Controller.extend("varaintManagement.VariantManagement.controller.VariantManagement", {
		onInit: function () {
			var sServiceURL = "/V2/Northwind/Northwind.svc/";
			var oModel = new sap.ui.model.odata.ODataModel(sServiceURL, true);
			sap.ui.getCore().setModel(oModel);

			if (sap.ushell && sap.ushell.Container && sap.ushell.Container.getService) {
				console.log("inside shell services");
				var oComponent = sap.ui.core.Component.getOwnerComponentFor(this.getView());
				this.oPersonalizationService = sap.ushell.Container.getService("Personalization");
				var oPersId = {
					container: "TablePersonalisation", //any
					item: "idEmployeesTable" //any- I have used the table name 
				};
				// define scope 
				var oScope = {
					keyCategory: this.oPersonalizationService.constants.keyCategory.FIXED_KEY,
					writeFrequency: this.oPersonalizationService.constants.writeFrequency.LOW,
					clientStorageAllowed: true
				};
				// Get a Personalizer
				var oPersonalizer = this.oPersonalizationService.getPersonalizer(oPersId, oScope, oComponent);
				this.oPersonalizationService.getContainer("TablePersonalisation", oScope, oComponent)
					.fail(function () {})
					.done(function (oContainer) {
						this.oContainer = oContainer;
						this.oVariantSetAdapter = new sap.ushell.services.Personalization.VariantSetAdapter(this.oContainer);
						// get variant set which is stored in backend
						this.oVariantSet = this.oVariantSetAdapter.getVariantSet("idEmployeesTableSet");

						if (!this.oVariantSet) { //if not in backend, then create one
							this.oVariantSet = this.oVariantSetAdapter.addVariantSet("idEmployeesTableSet");
						}
						// array to store the existing variants
						var Variants = [];
						// now get the existing variants from the backend to show as list
						for (var key in this.oVariantSet.getVariantNamesAndKeys()) {
							if (this.oVariantSet.getVariantNamesAndKeys().hasOwnProperty(key)) {
								var oVariantItemObject = {};
								oVariantItemObject.Key = this.oVariantSet.getVariantNamesAndKeys()[key];
								oVariantItemObject.Name = key;
								Variants.push(oVariantItemObject);
							}
						}
						// create JSON model and attach to the variant management UI control
						this.oVariantModel = new sap.ui.model.json.JSONModel();
						this.oVariantModel.oData.Variants = Variants;
						//	console.log("Variant:"+this.oVariantModel.getJSON());
						var oVariantMgmtControl = this.getView().byId("Variants");
						oVariantMgmtControl.setModel(this.oVariantModel);

						//console.log(oVariantMgmtControl.oVariantSave);

					}.bind(this));

				//		console.log(this.getView().byId("idEmployeesTable"));

				// create table persco controller
				this.oTablepersoService = new TablePersoController({
					table: this.getView().byId("idEmployeesTable"),
					componentName: "application-Test-url-component---VariantManagement",
					persoService: oPersonalizer
				}).activate();
				//
				//	console.log(this.getView().byId("Variants"));
			}
		},
		onSaveAs: function (oEvent) {
			// get variant parameters:
			var VariantParam = oEvent.getParameters();
			var sVariantKey = "";
			// get columns data: 
			var aColumnsData = [];
		//	console.log(this.getView().byId("idEmployeesTable").getColumns());
			this.getView().byId("idEmployeesTable").getColumns().forEach(function (oColumn, index) {
				var aColumn = {};
		//	 console.log("oColumn:"+oColumn.getHeader().getText());
				aColumn.fieldName = oColumn.getHeader().getText();
				aColumn.Id = oColumn.getId();
				aColumn.index = index;
				aColumn.Visible = oColumn.getVisible();
				aColumnsData.push(aColumn);
			});

			sVariantKey = this.oVariantSet.getVariantKeyByName(VariantParam.name);
		//	console.log(sVariantKey);
			if (sVariantKey) {
				this.oVariantSet.getVariant(VariantParam.name);
			} else {
				this.oVariant = this.oVariantSet.addVariant(VariantParam.name);
			}
				
				if (this.oVariant) {
					this.oVariant.setItemValue("ColumnsVal", JSON.stringify(aColumnsData));
					if (VariantParam.def === true) {
						this.oVariantSet.setCurrentVariantKey(this.oVariant.getVariantKey());
					}
					this.oContainer.save().done(function () {
						// Tell the user that the personalization data was saved
					});
				}
			
		},
		onSelect: function (oEvent) {
			
			var selectedKey = oEvent.getParameters().key;
		
			for (var i = 0; i < oEvent.getSource().getVariantItems().length; i++) {
			
				if (oEvent.getSource().getVariantItems()[i].getProperty("key") === selectedKey) {
						var selectedVariant = oEvent.getSource().getVariantItems()[i].getProperty("text");
						console.log("selectedKey:"+selectedVariant);
					break;
				}
			}
			this._setSelectedVariantToTable(selectedVariant);
		},

		_setSelectedVariantToTable: function (oSelectedVariant) {
			if (oSelectedVariant) {
				var sVariant = this.oVariantSet.getVariant(this.oVariantSet.getVariantKeyByName(oSelectedVariant));
				var aColumns = JSON.parse(sVariant.getItemValue("ColumnsVal"));
			//	console.log("Columns:"+sVariant.getItemValue("ColumnsVal"));
				// Hide all columns first
				this.getView().byId("idEmployeesTable").getColumns().forEach(function (oColumn) {
					
						oColumn.setVisible(false);
				
					
				});
				
				
				// re-arrange columns according to the saved variant

				aColumns.forEach(function (aColumn) {
					var aTableColumn = $.grep(this.getView().byId("idEmployeesTable").getColumns(), function (el, id) {
						return el.getHeader().getText() === aColumn.fieldName;
					});
					
					if (aTableColumn.length > 0) {
						
							console.log("Columns:"+aTableColumn[0]+"Visibility:"+aColumn.Visible+"Index:"+ aColumn.index);
							aTableColumn[0].setVisible(aColumn.Visible);
							this.getView().byId("idEmployeesTable").removeColumn(aTableColumn[0],true);
							this.getView().byId("idEmployeesTable").insertColumn(aTableColumn[0],aColumn.index);
						
				
						//
						
					//	
							
					//	this.getView().byId("idEmployeesTable").refresh();
					}
					
				}.bind(this));
				
			

			}
			// null means the standard variant is selected or the variant which is not available, then show all columns
			else {
				this.getView().byId("idEmployeesTable").getColumns().forEach(function (oColumn) {
					oColumn.setVisible(true);
				});
			}
			
		
		},
		onManage: function (oEvent) {
			var aParameters = oEvent.getParameters();
			// rename variants
			if (aParameters.renamed.length > 0) {
				aParameters.renamed.forEach(function (aRenamed) {
					var sVariant = this.oVariantSet.getVariant(aRenamed.key),
						sItemValue = sVariant.getItemValue("ColumnsVal");
					// delete the variant 
					this.oVariantSet.delVariant(aRenamed.key);
					// after delete, add a new variant
					var oNewVariant = this.oVariantSet.addVariant(aRenamed.name);
					oNewVariant.setItemValue("ColumnsVal", sItemValue);
				}.bind(this));
			}
			// default variant change
			if (aParameters.def !== "*standard*") {
				this.oVariantSet.setCurrentVariantKey(aParameters.def);
			} else {
				this.oVariantSet.setCurrentVariantKey(null);
			}
			// Delete variants
			if (aParameters.deleted.length > 0) {
				aParameters.deleted.forEach(function (aDelete) {
					this.oVariantSet.delVariant(aDelete);
				}.bind(this));
			}
			//  Save the Variant Container
			this.oContainer.save().done(function () {
				// Tell the user that the personalization data was saved
			});
		},
		onPersoButtonPressed: function (oEvent) {
			//	oTablepersoService.openDialog();
			this.oTablepersoService.openDialog({
				ok: "this.onPerscoDonePressed.bind(this)"
			});
		
		//	this.oTablepersoService._oDialog.attachConfirm(this, this.onPerscoDonePressed.bind(this));
		/*	this.getView().byId("Variants").oVariantSave.onAfterRendering = function () {
				this.setEnabled(true);
			};*/
		},
		onPerscoDonePressed: function (oEvent) {
			this.oTablepersoService.savePersonalizations();
		}
	});
});