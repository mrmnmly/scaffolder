Kolory = new Meteor.Collection('kolory');

Template.koloryListTemplate.helpers({
	koloryList: function(){
		return Kolory.find();
	}
});

Template.newKoloryTemplate.events({
	'submit #newKoloryForm': function(e){
		e.preventDefault();
		var form = $(e.currentTarget),
			kolor = form.find('#kolor').val(),
			czerwony, = form.find('#czerwony,').val(),
			czarny] = form.find('#czarny]').val();


		var kolory = Kolory.insert({kolor: kolor, czerwony,: czerwony,, czarny]: czarny]});

		if(kolory){
			Router.go('koloryListView');
			throwAlert('Successfully added new category', 'success');
		}else{
			throwAlert('Something went wrong', 'error');
		}
	}
});

Template.editKoloryTemplate.events({
	'submit #editKoloryForm': function(e){
		e.preventDefault();
		var form = $(e.currentTarget),
			kolor = form.find('#kolor').val(),
			czerwony, = form.find('#czerwony,').val(),
			czarny] = form.find('#czarny]').val();


		var kolory = Kolory.insert({kolor: kolor, czerwony,: czerwony,, czarny]: czarny]}, function(error){
			if(error){
				throwAlert('Something went wrong', 'error');
			}else{
				Router.go('koloryListView');
				throwAlert('Successfully added new category', 'success');
			}
		});
	}
});

Template.koloryListTemplate.events({
	'click .removeButton': function(e){
		e.preventDefault();

		Kolory.remove(this._id, function(error){
			if(error){
				throwAlert('Something went wrong', 'error');
			}else{
				throwAlert('Kolory removed', 'success');
			}
		});
	},
});

Deps.autorun(function(){
	Meteor.subscribe('kolory');
});
