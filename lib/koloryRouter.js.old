Router.map(function(){
	this.route('koloryListView', {
		path: '/kolory',
		template: 'koloryListTemplate',
		data: function(){
			return Kolory.find();
		}
	});

	this.route('newKoloryView', {
		path: '/kolory/new',
		template: 'newKoloryTemplate'
	});

	this.route('editKoloryView', {
		path: '/kolory/:_id/edit',
		template: 'editKoloryTemplate',
		data: function(){
			return Kolory.findOne(this.params._id);
		}
	});
});
