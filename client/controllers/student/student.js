Student = new Meteor.Collection('student');

Template.studentListTemplate.helpers({
	studentList: function(){
		return Student.find();
	}
});

Template.newStudentTemplate.events({
	'submit #newStudentForm': function(e){
		e.preventDefault();
		var form = $(e.currentTarget),
			age = form.find('#age').val(),
			first_name = form.find('#first_name').val(),
			last_name = form.find('#last_name').val(),
			birth = form.find('#birth').val(),
			cv = form.find('#cv').val(),
			note = form.find('#note').val();


		var student = Student.insert({age: age, first_name: first_name, last_name: last_name, birth: birth, cv: cv, note: note});

		if(student){
			Router.go('studentListView');
			throwAlert('Successfully added new category', 'success');
		}else{
			throwAlert('Something went wrong', 'error');
		}
	}
});

Template.editStudentTemplate.events({
	'submit #editStudentForm': function(e){
		e.preventDefault();
		var form = $(e.currentTarget),
			age = form.find('#age').val(),
			first_name = form.find('#first_name').val(),
			last_name = form.find('#last_name').val(),
			birth = form.find('#birth').val(),
			cv = form.find('#cv').val(),
			note = form.find('#note').val();


		var student = Student.insert({age: age, first_name: first_name, last_name: last_name, birth: birth, cv: cv, note: note}, function(error){
			if(error){
				throwAlert('Something went wrong', 'error');
			}else{
				Router.go('studentListView');
				throwAlert('Successfully added new category', 'success');
			}
		});
	}
});

Template.studentListTemplate.events({
	'click .removeButton': function(e){
		e.preventDefault();

		Student.remove(this._id, function(error){
			if(error){
				throwAlert('Something went wrong', 'error');
			}else{
				throwAlert('Student removed', 'success');
			}
		});
	},
});

Deps.autorun(function(){
	Meteor.subscribe('student');
});
