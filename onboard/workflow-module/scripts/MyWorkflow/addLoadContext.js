


// read contextual information
var taskDefinitionId = $.info.taskDefinitionId;

// read user task information
var lastUserTask1 = $.usertasks.usertask1.last;
var userTaskSubject = lastUserTask1.subject;
var userTaskProcessor = lastUserTask1.processor;
var userTaskCompletedAt = lastUserTask1.completedAt;

var userTaskStatusMessage = " User task '" + userTaskSubject + "' has been completed by " + userTaskProcessor + " at " + userTaskCompletedAt;


// write 'product' node to workflow context
$.context.userTaskStatusMessage = userTaskStatusMessage;
$.context.userformdata= $.usertasks.usertask1.last;
$.context.userformdec= $.usertasks.usertask1.last.decision;

