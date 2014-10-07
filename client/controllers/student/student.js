Student = new Meteor.Collection(student);

Deps.autorun(function(){
	Meteor.subscribe('student');
});
