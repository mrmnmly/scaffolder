# scaffolder
Basic, Bash-based scaffold generator for Meteor.js

This project was made for fun and learning bash a bit purpose - as a side-effect I've got own little tool for faster meteor.js app development :)

##Output

Scaffolder create basic files for desirable collection models:

- /client/controllers/collectionName/collectionName.js
- /client/templates/collectionName/collectionName.html
- /lib/collectionNameRouter.js
- /server/models/collectionName.js

##Supported field types

It can generate model for collection made from field types:

- string
- date
- number
- email
- textarea
- checkbox (not ready yet)
- password (not ready yet)
- radio (not ready yet)
- checkbox_collection (checkbox list that automatically takes all values from other collection objects - not ready yet)
- radio_collection (radio list that automatically takes all values from other collection objects - not ready yet

##Usage

      scfld collectionName field1:type field2:type ... fieldX:type
      
  Enjoy!
