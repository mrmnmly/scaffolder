Address = new Meteor.Collection('address');

Meteor.publish('address', function(){
	return Meteor.address.find({}, {fields:{street:1, house_no:1, postal:1, city:1, country:1}});
});

