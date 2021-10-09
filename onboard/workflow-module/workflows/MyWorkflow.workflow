{
	"contents": {
		"00de0bb3-d0a2-4c48-b3b9-3a9dbf85256c": {
			"classDefinition": "com.sap.bpm.wfs.Model",
			"id": "approvalmanager.myworkflow",
			"subject": "MyWorkflow",
			"name": "MyWorkflow",
			"documentation": "description",
			"lastIds": "62d7f4ed-4063-4c44-af8b-39050bd44926",
			"events": {
				"11a9b5ee-17c0-4159-9bbf-454dcfdcd5c3": {
					"name": "StartEvent1"
				},
				"2798f4e7-bc42-4fad-a248-159095a2f40a": {
					"name": "EndEvent1"
				},
				"2ac01bb1-af0b-44d2-8584-000b0e248b3e": {
					"name": "EndEvent2"
				},
				"8ae34b73-8f01-4203-98fa-09a6a398b7ce": {
					"name": "EndEvent3"
				}
			},
			"activities": {
				"6fb3f11f-7b02-43a0-b91a-877028787e06": {
					"name": "Assign and Approve"
				},
				"c39a47a5-b1ab-460c-8767-6108ca95d65b": {
					"name": "Send Mail"
				},
				"f6fff9c8-4bbd-409e-bafe-c31ed7bb5a95": {
					"name": "GetOdata"
				},
				"469c5f9f-6e34-442a-9a45-9dd1831f2f66": {
					"name": "ExclusiveGateway2"
				},
				"eb9746fb-1fe5-4786-a37f-c127ed8aa2f1": {
					"name": "ScriptTask2"
				},
				"8e853a20-fc5e-4495-a499-6fbad9baa211": {
					"name": "GetApprovalRequired"
				}
			},
			"sequenceFlows": {
				"c6b99f32-5fe6-4ab6-b60a-80fba1b9ae0f": {
					"name": "SequenceFlow1"
				},
				"2652bfc4-5cfb-47ba-99f9-3cd5ebbb79be": {
					"name": "SequenceFlow2"
				},
				"f908e16e-5551-4767-a695-837fc49889f9": {
					"name": "SequenceFlow5"
				},
				"9de3f280-e7b9-45a2-af0a-dcae7e2c86e3": {
					"name": "Reject"
				},
				"b9e02869-ad51-4948-84b9-66f419ae4753": {
					"name": "SequenceFlow9"
				},
				"cf4cc172-969c-4215-b268-a582ae81b4ff": {
					"name": "Approve"
				},
				"fba7acf6-9e9d-41ee-a8fa-51c49443e4d1": {
					"name": "SequenceFlow12"
				},
				"5415c077-16bb-4dc7-95f3-66a96115afaa": {
					"name": "Cancel"
				},
				"bbd57777-f714-44c0-8a21-9cc1ea2c3988": {
					"name": "SequenceFlow14"
				}
			},
			"diagrams": {
				"42fa7a2d-c526-4a02-b3ba-49b5168ba644": {}
			}
		},
		"11a9b5ee-17c0-4159-9bbf-454dcfdcd5c3": {
			"classDefinition": "com.sap.bpm.wfs.StartEvent",
			"id": "startevent1",
			"name": "StartEvent1"
		},
		"2798f4e7-bc42-4fad-a248-159095a2f40a": {
			"classDefinition": "com.sap.bpm.wfs.EndEvent",
			"id": "endevent1",
			"name": "EndEvent1"
		},
		"2ac01bb1-af0b-44d2-8584-000b0e248b3e": {
			"classDefinition": "com.sap.bpm.wfs.EndEvent",
			"id": "endevent2",
			"name": "EndEvent2"
		},
		"8ae34b73-8f01-4203-98fa-09a6a398b7ce": {
			"classDefinition": "com.sap.bpm.wfs.EndEvent",
			"id": "endevent3",
			"name": "EndEvent3"
		},
		"6fb3f11f-7b02-43a0-b91a-877028787e06": {
			"classDefinition": "com.sap.bpm.wfs.UserTask",
			"subject": "Assign and Approve for ${context.empData.firstName} ${context.empData.lastName}",
			"description": "The manager assigns and approves equipment and relocation of the newly onboarded employee",
			"priority": "HIGH",
			"isHiddenInLogForParticipant": false,
			"supportsForward": false,
			"userInterface": "sapui5://comsapbpmworkflow.comsapbpmwusformplayer/com.sap.bpm.wus.form.player",
			"recipientUsers": "${info.startedBy}",
			"formReference": "/forms/MyWorkflow/approvalform.form",
			"userInterfaceParams": [{
				"key": "formId",
				"value": "approvalform"
			}, {
				"key": "formRevision",
				"value": "1.0"
			}],
			"id": "usertask1",
			"name": "Assign and Approve"
		},
		"c39a47a5-b1ab-460c-8767-6108ca95d65b": {
			"classDefinition": "com.sap.bpm.wfs.MailTask",
			"id": "mailtask1",
			"name": "Send Mail",
			"mailDefinitionRef": "c8a75992-56fa-4927-90ed-0bb974756028"
		},
		"f6fff9c8-4bbd-409e-bafe-c31ed7bb5a95": {
			"classDefinition": "com.sap.bpm.wfs.ServiceTask",
			"destination": "Northwind",
			"path": "/V3/Northwind/Northwind.svc/Products(1)?$format=json",
			"httpMethod": "GET",
			"responseVariable": "${context.response}",
			"id": "servicetask1",
			"name": "GetOdata",
			"documentation": "sample odata service"
		},
		"469c5f9f-6e34-442a-9a45-9dd1831f2f66": {
			"classDefinition": "com.sap.bpm.wfs.ExclusiveGateway",
			"id": "exclusivegateway2",
			"name": "ExclusiveGateway2",
			"default": "9de3f280-e7b9-45a2-af0a-dcae7e2c86e3"
		},
		"eb9746fb-1fe5-4786-a37f-c127ed8aa2f1": {
			"classDefinition": "com.sap.bpm.wfs.ScriptTask",
			"reference": "/scripts/MyWorkflow/addLoadContext.js",
			"id": "scripttask2",
			"name": "ScriptTask2"
		},
		"8e853a20-fc5e-4495-a499-6fbad9baa211": {
			"classDefinition": "com.sap.bpm.wfs.ServiceTask",
			"destination": "BUSINESS_RULES",
			"path": "/rest/v2/workingset-rule-services",
			"httpMethod": "POST",
			"xsrfPath": "",
			"requestVariable": "${context}",
			"responseVariable": "${context.result}",
			"headers": [],
			"id": "servicetask2",
			"name": "GetApprovalRequired"
		},
		"c6b99f32-5fe6-4ab6-b60a-80fba1b9ae0f": {
			"classDefinition": "com.sap.bpm.wfs.SequenceFlow",
			"id": "sequenceflow1",
			"name": "SequenceFlow1",
			"sourceRef": "11a9b5ee-17c0-4159-9bbf-454dcfdcd5c3",
			"targetRef": "8e853a20-fc5e-4495-a499-6fbad9baa211"
		},
		"2652bfc4-5cfb-47ba-99f9-3cd5ebbb79be": {
			"classDefinition": "com.sap.bpm.wfs.SequenceFlow",
			"id": "sequenceflow2",
			"name": "SequenceFlow2",
			"sourceRef": "6fb3f11f-7b02-43a0-b91a-877028787e06",
			"targetRef": "eb9746fb-1fe5-4786-a37f-c127ed8aa2f1"
		},
		"f908e16e-5551-4767-a695-837fc49889f9": {
			"classDefinition": "com.sap.bpm.wfs.SequenceFlow",
			"id": "sequenceflow5",
			"name": "SequenceFlow5",
			"sourceRef": "c39a47a5-b1ab-460c-8767-6108ca95d65b",
			"targetRef": "2798f4e7-bc42-4fad-a248-159095a2f40a"
		},
		"9de3f280-e7b9-45a2-af0a-dcae7e2c86e3": {
			"classDefinition": "com.sap.bpm.wfs.SequenceFlow",
			"id": "sequenceflow8",
			"name": "Reject",
			"sourceRef": "469c5f9f-6e34-442a-9a45-9dd1831f2f66",
			"targetRef": "c39a47a5-b1ab-460c-8767-6108ca95d65b"
		},
		"b9e02869-ad51-4948-84b9-66f419ae4753": {
			"classDefinition": "com.sap.bpm.wfs.SequenceFlow",
			"id": "sequenceflow9",
			"name": "SequenceFlow9",
			"sourceRef": "f6fff9c8-4bbd-409e-bafe-c31ed7bb5a95",
			"targetRef": "2ac01bb1-af0b-44d2-8584-000b0e248b3e"
		},
		"cf4cc172-969c-4215-b268-a582ae81b4ff": {
			"classDefinition": "com.sap.bpm.wfs.SequenceFlow",
			"condition": "${usertasks.usertask1.last.decision == \"approve\"}",
			"id": "sequenceflow10",
			"name": "Approve",
			"sourceRef": "469c5f9f-6e34-442a-9a45-9dd1831f2f66",
			"targetRef": "f6fff9c8-4bbd-409e-bafe-c31ed7bb5a95"
		},
		"fba7acf6-9e9d-41ee-a8fa-51c49443e4d1": {
			"classDefinition": "com.sap.bpm.wfs.SequenceFlow",
			"id": "sequenceflow12",
			"name": "SequenceFlow12",
			"sourceRef": "eb9746fb-1fe5-4786-a37f-c127ed8aa2f1",
			"targetRef": "469c5f9f-6e34-442a-9a45-9dd1831f2f66"
		},
		"5415c077-16bb-4dc7-95f3-66a96115afaa": {
			"classDefinition": "com.sap.bpm.wfs.SequenceFlow",
			"condition": "${usertasks.usertask1.last.decision == \"cancel\"}",
			"id": "sequenceflow13",
			"name": "Cancel",
			"sourceRef": "469c5f9f-6e34-442a-9a45-9dd1831f2f66",
			"targetRef": "8ae34b73-8f01-4203-98fa-09a6a398b7ce"
		},
		"bbd57777-f714-44c0-8a21-9cc1ea2c3988": {
			"classDefinition": "com.sap.bpm.wfs.SequenceFlow",
			"id": "sequenceflow14",
			"name": "SequenceFlow14",
			"sourceRef": "8e853a20-fc5e-4495-a499-6fbad9baa211",
			"targetRef": "6fb3f11f-7b02-43a0-b91a-877028787e06"
		},
		"42fa7a2d-c526-4a02-b3ba-49b5168ba644": {
			"classDefinition": "com.sap.bpm.wfs.ui.Diagram",
			"symbols": {
				"df898b52-91e1-4778-baad-2ad9a261d30e": {},
				"53e54950-7757-4161-82c9-afa7e86cff2c": {},
				"6bb141da-d485-4317-93b8-e17711df4c32": {},
				"e4e21575-c84d-4747-83a8-ae7bc4a99c4f": {},
				"b2f8aaae-9c1f-4b93-b5f4-7eeb4e6a4136": {},
				"95114d33-b354-47a8-8e0b-3168759b6aac": {},
				"7d249fb6-1a1a-49c8-9d81-83b3bf27b1b4": {},
				"63c30f86-8ce4-4afd-ae53-2a38099321c6": {},
				"894ca4cb-f78b-4ef1-866a-08a1c26824af": {},
				"f3363998-4216-4149-95d7-ce846e6ade9e": {},
				"9a859d87-ae89-4141-bce1-0704eccce026": {},
				"7b6ff56b-56f5-49d5-a231-ffb723ac818e": {},
				"51b47993-659d-4254-9935-a3fb34b4b08b": {},
				"d1ee4296-0f73-4a2e-bddf-2be05cb04e2e": {},
				"8626c525-1f7d-454c-96ef-616b6f790ebb": {},
				"b2996515-731b-4042-925d-fba328141cd9": {},
				"132805a4-c4cd-4b70-b887-61cc98250091": {},
				"57d599ff-bc79-4740-8e5d-941a8249a939": {},
				"38a943a6-3e6f-437f-b187-eee347c33ec8": {}
			}
		},
		"df898b52-91e1-4778-baad-2ad9a261d30e": {
			"classDefinition": "com.sap.bpm.wfs.ui.StartEventSymbol",
			"x": 12,
			"y": 81,
			"width": 32,
			"height": 32,
			"object": "11a9b5ee-17c0-4159-9bbf-454dcfdcd5c3"
		},
		"53e54950-7757-4161-82c9-afa7e86cff2c": {
			"classDefinition": "com.sap.bpm.wfs.ui.EndEventSymbol",
			"x": 537.9999976158142,
			"y": 117.5,
			"width": 35,
			"height": 35,
			"object": "2798f4e7-bc42-4fad-a248-159095a2f40a"
		},
		"6bb141da-d485-4317-93b8-e17711df4c32": {
			"classDefinition": "com.sap.bpm.wfs.ui.SequenceFlowSymbol",
			"points": "28,97 28,201.5 86.25,201.5 86.25,319.5",
			"sourceSymbol": "df898b52-91e1-4778-baad-2ad9a261d30e",
			"targetSymbol": "57d599ff-bc79-4740-8e5d-941a8249a939",
			"object": "c6b99f32-5fe6-4ab6-b60a-80fba1b9ae0f"
		},
		"e4e21575-c84d-4747-83a8-ae7bc4a99c4f": {
			"classDefinition": "com.sap.bpm.wfs.ui.UserTaskSymbol",
			"x": 228,
			"y": 204,
			"width": 100,
			"height": 60,
			"object": "6fb3f11f-7b02-43a0-b91a-877028787e06"
		},
		"b2f8aaae-9c1f-4b93-b5f4-7eeb4e6a4136": {
			"classDefinition": "com.sap.bpm.wfs.ui.SequenceFlowSymbol",
			"points": "278,234 278,107.75 150.25,107.75 150.25,-18",
			"sourceSymbol": "e4e21575-c84d-4747-83a8-ae7bc4a99c4f",
			"targetSymbol": "d1ee4296-0f73-4a2e-bddf-2be05cb04e2e",
			"object": "2652bfc4-5cfb-47ba-99f9-3cd5ebbb79be"
		},
		"95114d33-b354-47a8-8e0b-3168759b6aac": {
			"classDefinition": "com.sap.bpm.wfs.ui.MailTaskSymbol",
			"x": 355.9999988079071,
			"y": 122,
			"width": 100,
			"height": 60,
			"object": "c39a47a5-b1ab-460c-8767-6108ca95d65b"
		},
		"7d249fb6-1a1a-49c8-9d81-83b3bf27b1b4": {
			"classDefinition": "com.sap.bpm.wfs.ui.SequenceFlowSymbol",
			"points": "455.9999988079071,152 497.25,152 497.25,135 537.9999976158142,135",
			"sourceSymbol": "95114d33-b354-47a8-8e0b-3168759b6aac",
			"targetSymbol": "53e54950-7757-4161-82c9-afa7e86cff2c",
			"object": "f908e16e-5551-4767-a695-837fc49889f9"
		},
		"63c30f86-8ce4-4afd-ae53-2a38099321c6": {
			"classDefinition": "com.sap.bpm.wfs.ui.ServiceTaskSymbol",
			"x": 355.9999988079071,
			"y": 12,
			"width": 100,
			"height": 60,
			"object": "f6fff9c8-4bbd-409e-bafe-c31ed7bb5a95"
		},
		"894ca4cb-f78b-4ef1-866a-08a1c26824af": {
			"classDefinition": "com.sap.bpm.wfs.ui.ExclusiveGatewaySymbol",
			"x": 244,
			"y": 76,
			"object": "469c5f9f-6e34-442a-9a45-9dd1831f2f66"
		},
		"f3363998-4216-4149-95d7-ce846e6ade9e": {
			"classDefinition": "com.sap.bpm.wfs.ui.SequenceFlowSymbol",
			"points": "265,97 265,160 321,160 321,152 355.9999988079071,152",
			"sourceSymbol": "894ca4cb-f78b-4ef1-866a-08a1c26824af",
			"targetSymbol": "95114d33-b354-47a8-8e0b-3168759b6aac",
			"object": "9de3f280-e7b9-45a2-af0a-dcae7e2c86e3"
		},
		"9a859d87-ae89-4141-bce1-0704eccce026": {
			"classDefinition": "com.sap.bpm.wfs.ui.EndEventSymbol",
			"x": 532.9999988079071,
			"y": -5.5,
			"width": 35,
			"height": 35,
			"object": "2ac01bb1-af0b-44d2-8584-000b0e248b3e"
		},
		"7b6ff56b-56f5-49d5-a231-ffb723ac818e": {
			"classDefinition": "com.sap.bpm.wfs.ui.SequenceFlowSymbol",
			"points": "405.9999988079071,42 494.75,42 494.75,12 550.4999988079071,12",
			"sourceSymbol": "63c30f86-8ce4-4afd-ae53-2a38099321c6",
			"targetSymbol": "9a859d87-ae89-4141-bce1-0704eccce026",
			"object": "b9e02869-ad51-4948-84b9-66f419ae4753"
		},
		"51b47993-659d-4254-9935-a3fb34b4b08b": {
			"classDefinition": "com.sap.bpm.wfs.ui.SequenceFlowSymbol",
			"points": "265,76.5 265,42 356.4999988079071,42",
			"sourceSymbol": "894ca4cb-f78b-4ef1-866a-08a1c26824af",
			"targetSymbol": "63c30f86-8ce4-4afd-ae53-2a38099321c6",
			"object": "cf4cc172-969c-4215-b268-a582ae81b4ff"
		},
		"d1ee4296-0f73-4a2e-bddf-2be05cb04e2e": {
			"classDefinition": "com.sap.bpm.wfs.ui.ScriptTaskSymbol",
			"x": 100.25,
			"y": -48,
			"width": 100,
			"height": 60,
			"object": "eb9746fb-1fe5-4786-a37f-c127ed8aa2f1"
		},
		"8626c525-1f7d-454c-96ef-616b6f790ebb": {
			"classDefinition": "com.sap.bpm.wfs.ui.SequenceFlowSymbol",
			"points": "150.25,-18 150.25,44.25 218,44.25 218,103 253,103",
			"sourceSymbol": "d1ee4296-0f73-4a2e-bddf-2be05cb04e2e",
			"targetSymbol": "894ca4cb-f78b-4ef1-866a-08a1c26824af",
			"object": "fba7acf6-9e9d-41ee-a8fa-51c49443e4d1"
		},
		"b2996515-731b-4042-925d-fba328141cd9": {
			"classDefinition": "com.sap.bpm.wfs.ui.EndEventSymbol",
			"x": 336,
			"y": 79.5,
			"width": 35,
			"height": 35,
			"object": "8ae34b73-8f01-4203-98fa-09a6a398b7ce"
		},
		"132805a4-c4cd-4b70-b887-61cc98250091": {
			"classDefinition": "com.sap.bpm.wfs.ui.SequenceFlowSymbol",
			"points": "265,97 353.5,97",
			"sourceSymbol": "894ca4cb-f78b-4ef1-866a-08a1c26824af",
			"targetSymbol": "b2996515-731b-4042-925d-fba328141cd9",
			"object": "5415c077-16bb-4dc7-95f3-66a96115afaa"
		},
		"57d599ff-bc79-4740-8e5d-941a8249a939": {
			"classDefinition": "com.sap.bpm.wfs.ui.ServiceTaskSymbol",
			"x": 36.25,
			"y": 289.5,
			"width": 100,
			"height": 60,
			"object": "8e853a20-fc5e-4495-a499-6fbad9baa211"
		},
		"38a943a6-3e6f-437f-b187-eee347c33ec8": {
			"classDefinition": "com.sap.bpm.wfs.ui.SequenceFlowSymbol",
			"points": "86.25,319.5 182.375,319.5 182.375,234 278,234",
			"sourceSymbol": "57d599ff-bc79-4740-8e5d-941a8249a939",
			"targetSymbol": "e4e21575-c84d-4747-83a8-ae7bc4a99c4f",
			"object": "bbd57777-f714-44c0-8a21-9cc1ea2c3988"
		},
		"62d7f4ed-4063-4c44-af8b-39050bd44926": {
			"classDefinition": "com.sap.bpm.wfs.LastIDs",
			"maildefinition": 1,
			"hubapireference": 1,
			"sequenceflow": 14,
			"startevent": 1,
			"endevent": 3,
			"usertask": 1,
			"servicetask": 2,
			"scripttask": 2,
			"mailtask": 1,
			"exclusivegateway": 2
		},
		"c8a75992-56fa-4927-90ed-0bb974756028": {
			"classDefinition": "com.sap.bpm.wfs.MailDefinition",
			"name": "maildefinition1",
			"to": "${context.empData.email}",
			"subject": "Welcome ${context.empData.firstName} ${context.empData.lastName}",
			"reference": "/webcontent/MyWorkflow/senMail.html",
			"id": "maildefinition1"
		}
	}
}