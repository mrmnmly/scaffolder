Student = new Meteor.Collection('student');

Meteor.publish('student', function(){
	return Meteor.student.find({}, {fields:{age:1, first_name:1, last_name:1, birth:1, cv:1, note:1}});
});

