Address = new Meteor.Collection('address');

Template.addressListTemplate.helpers({
	addressList: function(){
		return Address.find();
	}
});

Template.newAddressTemplate.events({
	'submit #newAddressForm': function(e){
		e.preventDefault();
		var form = $(e.currentTarget),
			street = form.find('#street').val(),
			house_no = form.find('#house_no').val(),
			postal = form.find('#postal').val(),
			city = form.find('#city').val(),
			country = form.find('#country').val();


		var address = Address.insert({street: street, house_no: house_no, postal: postal, city: city, country: country});

		if(address){
			Router.go('addressListView');
			throwAlert('Successfully added new category', 'success');
		}else{
			throwAlert('Something went wrong', 'error');
		}
	}
});

Template.editAddressTemplate.events({
	'submit #editAddressForm': function(e){
		e.preventDefault();
		var form = $(e.currentTarget),
			street = form.find('#street').val(),
			house_no = form.find('#house_no').val(),
			postal = form.find('#postal').val(),
			city = form.find('#city').val(),
			country = form.find('#country').val();


		var address = Address.insert({street: street, house_no: house_no, postal: postal, city: city, country: country}, function(error){
			if(error){
				throwAlert('Something went wrong', 'error');
			}else{
				Router.go('addressListView');
				throwAlert('Successfully added new category', 'success');
			}
		});
	}
});

Template.addressListTemplate.events({
	'click .removeButton': function(e){
		e.preventDefault();

		Address.remove(this._id, function(error){
			if(error){
				throwAlert('Something went wrong', 'error');
			}else{
				throwAlert('Address removed', 'success');
			}
		});
	},
});

Deps.autorun(function(){
	Meteor.subscribe('address');
});
