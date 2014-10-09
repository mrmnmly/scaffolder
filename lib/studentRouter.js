Router.map(function(){
	this.route('studentListView', {
		path: '/student',
		template: 'studentListTemplate',
		data: function(){
			return Student.find();
		}
	});

	this.route('newStudentView', {
		path: '/student/new',
		template: 'newStudentTemplate'
	});

	this.route('editStudentView', {
		path: '/student/:_id/edit',
		template: 'editStudentTemplate',
		data: function(){
			return Student.findOne(this.params._id);
		}
	});
});
