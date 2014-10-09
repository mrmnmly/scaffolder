Router.map(function(){
	this.route('addressListView', {
		path: '/address',
		template: 'addressListTemplate',
		data: function(){
			return Address.find();
		}
	});

	this.route('newAddressView', {
		path: '/address/new',
		template: 'newAddressTemplate'
	});

	this.route('editAddressView', {
		path: '/address/:_id/edit',
		template: 'editAddressTemplate',
		data: function(){
			return Address.findOne(this.params._id);
		}
	});
});
