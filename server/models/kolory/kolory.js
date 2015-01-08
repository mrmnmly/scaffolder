Kolory = new Meteor.Collection('kolory');

Meteor.publish('kolory', function(){
	return Meteor.kolory.find({}, {fields:{kolor:1, czerwony,:1, czarny]:1}});
});

