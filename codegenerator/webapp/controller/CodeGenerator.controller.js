sap.ui.define([
	"sap/ui/core/mvc/Controller"
],
	/**
	 * @param {typeof sap.ui.core.mvc.Controller} Controller
	 */
	function (Controller) {
		"use strict";

		return Controller.extend("com.siva.app.codegenerator.controller.CodeGenerator", {
			onInit: function () {
                var oModel = new sap.ui.model.json.JSONModel();
                oModel.setData({"CodeGenerator":[{Number:"1", ID: "", Control:"", Variable: "", GetVariable:""}]});
                this.getView().byId("idCodeTable").setModel(oModel);
            },
            
            onLiveIDChange: function(oEvent){
                if((oEvent.getSource().getValue().length > 0) && (Number(oEvent.getSource().getParent().getParent().getModel().getObject(oEvent.getSource().getParent().getBindingContextPath()).Number) == oEvent.getSource().getParent().getParent().getModel().getData().CodeGenerator.length)){
                    var num = oEvent.getSource().getParent().getParent().getModel().getData().CodeGenerator.length+1;
                    var item = {Number:num, ID: "", Control:"", Variable: "", GetVariable:""};
                    oEvent.getSource().getParent().getParent().getModel().getData().CodeGenerator.push(item);
                    oEvent.getSource().getParent().getParent().getModel().refresh();
                }
            },

            onIDChange: function(oEvent){
                if((oEvent.getSource().getValue().length > 0)){
                    oEvent.getSource().getParent().getParent().getModel().getObject(oEvent.getSource().getParent().getBindingContextPath()).Variable = "get"+oEvent.getSource().getValue();
                    oEvent.getSource().getParent().getParent().getModel().getObject(oEvent.getSource().getParent().getBindingContextPath()).GetVariable = "var "+oEvent.getSource().getParent().getParent().getModel().getObject(oEvent.getSource().getParent().getBindingContextPath()).Variable+" = this.getView().byId('"+oEvent.getSource().getValue()+"').getValue()";
                    oEvent.getSource().getParent().getParent().getModel().refresh();
                }else{
                    oEvent.getSource().getParent().getParent().getModel().getObject(oEvent.getSource().getParent().getBindingContextPath()).Variable = "";
                    oEvent.getSource().getParent().getParent().getModel().getObject(oEvent.getSource().getParent().getBindingContextPath()).GetVariable = "";
                    oEvent.getSource().getParent().getParent().getModel().refresh();
                }
            },

            onGeneratePlainText:function(oEvent){                   
                // This variable stores all the data.
                var modeldata = this.getView().byId("idCodeTable").getModel().getData();
                let data = this.fnReturnHeader()+""+this.fnLCHonInit(modeldata)+""+this.fnLCHonBeforeRender()+""+this.fnLCHonAfterRender()+""+this.fnLCHonExit()+""+this.fnReturnFoot();
                
                // Convert the text to BLOB.
                const textToBLOB = new Blob([data], { type: 'text/plain' });
                const sFileName = 'ControllerCode.txt';	   // The file to save the data.
                let newLink = document.createElement("a");
                newLink.download = sFileName;
                if (window.webkitURL != null) {
                    newLink.href = window.webkitURL.createObjectURL(textToBLOB);
                }
                else {
                    newLink.href = window.URL.createObjectURL(textToBLOB);
                    newLink.style.display = "none";
                    document.body.appendChild(newLink);
                }
                newLink.click();
            },

            fnReturnHeader: function(){                
                var head= 'sap.ui.define([\r\n '+
                        ' "sap/ui/core/mvc/Controller"\r\n'+
                        '], function (Controller) {\r\n '+
                        ' "use strict";\r\n'+
                        ' return Controller.extend("sap.ui.demo.walkthrough.controller.App", {\r\n ';            
                return head;
            },

            fnReturnFoot: function(){                
                var foot= '\r   \r\n'+
                        '  });\r\n'+
                        '});\r\n';            
                return foot;
            },

            fnLCHonInit: function(onInitData){
                var finaldata = "";
                onInitData.CodeGenerator.forEach(element => {
                    if(element.GetVariable){
                        finaldata = finaldata+'\r       '+element.GetVariable+';'
                    }                    
                });
                var init= '\r     onInit: function() {\r\n'+
                        ' '+finaldata+' \r\n\n'+
                        '     },\r\n';           
                return init;
            },

            fnLCHonAfterRender: function(){
                var ar= '\r     onAfterRendering: function() {\r\n'+
                        '   \r\n'+
                        '     },\r\n';            
                return ar;
            },

            fnLCHonBeforeRender: function(){
                var beforerender= '\r    onBeforeRendering: function() {\r\n'+
                        '     /* on Before Render Hook*/\r\n'+
                        '     },\r\n';            
                return beforerender;
            },

            fnLCHonExit: function(){
                var exit= '\r     onExit: function() {\r\n'+
                        '   \r\n'+
                        '     }\r\n';            
                return exit;
            },


		});
	});
