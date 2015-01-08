# scfld is an open-source, bash-based scaffolding system for Meteor.js
# made with <3 by @ofcapl
# e-mail: kontakt@lukaszkups.pl
# web: http://lukaszkups.pl

# INFO:
# first parameter ($1) is collection name
# the rest of the parameters are single document fields with syntax: field_name:field_type

# field types:
# text, date, number, email, textarea
# and in ver. 1+:
# checkbox, radio, checkbox_collection, radio_collection

# checkbox & radio field declaration syntax should match to below one:
# field_name:field_type[option1, option2, ... , optionX]

# checkbox_collection will make checkbox list where each checkbox has value as id of the specific collection object
# radio_collection will make radio list where each radio has value as id of the specific collection object
# checkbox & radio collection field declaration syntax should match to below one:
# field_name:field_type[collection_name]

collection_name=${1^};
collection_object=${1,};

echo "==============";
echo "collection" $collection_name "created";
echo "==============";

# create model folder & file
mkdir -p "server/models/"$collection_object;
if [ -f "server/models/"$collection_object"/"$collection_object".js" ]; then
	mv "server/models/"$collection_object"/"$collection_object".js" "server/models/"$collection_object"/"$collection_object".js.old";
fi
touch "server/models/"$collection_object"/"$collection_object".js";

# create template folder & files
mkdir -p "client/templates/"$collection_object;
if [ -f "client/templates/"$collection_object"/"$collection_object".html" ]; then
	mv "client/templates/"$collection_object"/"$collection_object".html" "client/templates/"$collection_object"/"$collection_object".html.old";
fi
touch "client/templates/"$collection_object"/"$collection_object".html";

# create controller folder & file
mkdir -p "client/controllers/"$collection_object;
if [ -f "client/controllers/"$collection_object"/"$collection_object".js" ]; then
	mv "client/controllers/"$collection_object"/"$collection_object".js" "client/controllers/"$collection_object"/"$collection_object".js.old";
fi
touch "client/controllers/"$collection_object"/"$collection_object".js";

# create iron-router file
mkdir -p "lib/";
if [ -f "lib/"$collection_object"Router.js" ]; then
	mv "lib/"$collection_object"Router.js" "lib/"$collection_object"Router.js.old";
fi
touch "lib/"$collection_object"Router.js";


model_file="server/models/"$collection_object"/"$collection_object".js";
template_file="client/templates/"$collection_object"/"$collection_object".html";
controller_file="client/controllers/"$collection_object"/"$collection_object".js";
router_file="lib/"$collection_object"Router.js";


# ===================================================
# TEMPLATES
# ===================================================


#newDocumentForm
new_document_template=$'<template name=\"new'$collection_name'Template'\"'>\n\t<form id='\"'new'$collection_name'Form'\"'>\n';
edit_document_template=$'<template name=\"edit'$collection_name'Template'\"'>\n\t<form id='\"'edit'$collection_name'Form'\"'>\n';

# iterate through document fields/variables
for i in ${@:2}
do
	#field name
	field_name=${i%:*};
	#field type
	field_type=${i#*:};
	#cut unnecessary (for this particular variable) array
	field_type=${field_type%[*};
	echo $field_type;
	

	if [ $field_type == "text" ]; then
		new_document_template+='\t\t''<div class='\"'controls'\"'>\n\t\t\t<label for='\"$field_name\"'>'$field_name'</label>\n\t\t\t<input id='\"$field_name\"' type='\"'text'\"' name='\"$field_name\"'>\n\t\t</div>\n';
		edit_document_template+='\t\t''<div class='\"'controls'\"'>\n\t\t\t<label for='\"$field_name\"'>'$field_name'</label>\n\t\t\t<input id='\"$field_name\"' type='\"'text'\"' name='\"$field_name\"' value='\"'{{ this.'$field_name' }}'\"'>\n\t\t</div>\n';
	elif [ $field_type == "date" ]; then
		new_document_template+='\t\t<div class='\"'controls'\"'>\n\t\t\t<label for='\"$field_name\"'>'$field_name'</label>\n\t\t\t<input id='\"$field_name\"' type='\"'date'\"' name='\"$field_name\"'>\n\t\t</div>\n';
		edit_document_template+='\t\t<div class='\"'controls'\"'>\n\t\t\t<label for='\"$field_name\"'>'$field_name'</label>\n\t\t\t<input id='\"$field_name\"' type='\"'date'\"' name='\"$field_name\"' value='\"'{{ this.'$field_name' }}'\"'>\n\t\t</div>\n';
	elif [ $field_type == "number" ]; then
		new_document_template+='\t\t<div class='\"'controls'\"'>\n\t\t\t<label for='\"$field_name\"'>'$field_name'</label>\n\t\t\t<input id='\"$field_name\"' type='\"'number'\"' name='\"$field_name\"'>\n\t\t</div>\n';
		edit_document_template+='\t\t<div class='\"'controls'\"'>\n\t\t\t<label for='\"$field_name\"'>'$field_name'</label>\n\t\t\t<input id='\"$field_name\"' type='\"'number'\"' name='\"$field_name\"' value='\"'{{ this.'$field_name' }}'\"'>\n\t\t</div>\n';
	elif [ $field_type == "email" ]; then
		new_document_template+='\t\t<div class='\"'controls'\"'>\n\t\t\t<label for='\"$field_name\"'>'$field_name'</label>\n\t\t\t<input id='\"$field_name\"' type='\"'email'\"' name='\"$field_name\"'>\n\t\t</div>\n';
		edit_document_template+='\t\t<div class='\"'controls'\"'>\n\t\t\t<label for='\"$field_name\"'>'$field_name'</label>\n\t\t\t<input id='\"$field_name\"' type='\"'email'\"' name='\"$field_name\"' value='\"'{{ this.'$field_name' }}'\"'>\n\t\t</div>\n';
	elif [ $field_type == "textarea" ]; then
		new_document_template+='\t\t<div class='\"'controls'\"'>\n\t\t\t<label for='\"$field_name\"'>'$field_name'</label>\n\t\t\t<textarea id='\"$field_name\"' name='\"$field_name\"'></textarea>\n\t\t</div>\n';
		edit_document_template+='\t\t<div class='\"'controls'\"'>\n\t\t\t<label for='\"$field_name\"'>'$field_name'</label>\n\t\t\t<textarea id='\"$field_name\"' name='\"$field_name\"' value='\"'{{ this.'$field_name' }}'\"'></textarea>\n\t\t</div>\n';
	# for ver. 1+
	elif [ $field_type == "checkbox" ]; then
		params_array=${field_type#*[};
		params_array="${params_array:0:-1}";
		IFS=', ' read -a params_array <<< "$params_array";
		echo $params_array

	# elif [ $field_type == "checkbox_collection"]; then
		# template_helpers+="Template.new"$collection_name"Template.helpers({\n\t";

	# elif [ $field_type == "radio"]; then
	# elif [ $field_type == "checkbox_collection"]; then
	# elif [ $field_type == "radio_collection"]; then
	fi
done
new_document_template+=$'''\t\t<input type='\"'submit'\"' value='\"'submit'\"' class='\"'button'\"'>\n\t</form>\n</template>\n\n';

#editDocumentForm will be almost the same (form id will be different) as newDocumentForm
edit_document_template+=$'''\t\t<input type='\"'submit'\"' value='\"'submit'\"' class='\"'button'\"'>\n\t</form>\n</template>\n\n';

#documentList
document_list_template=$'<template name='\"$collection_object'ListTemplate'\"'>\n\t<a href='\"'{{pathFor '\''new'$collection_name'View'\''}}'\"'>New '$collection_name'</a>\n\t<table>\n\t\t<thead>\n\t\t\t<tr>\n\t\t\t\t<th>id</th><th>action</th>\n\t\t\t</tr>\n\t\t</thead>\n\t\t<tbody>\n\t\t\t{{#each '$collection_object'List}}\n\t\t\t\t<tr>\n\t\t\t\t\t<td>this._id</td><td><a href='\"'{{pathFor '\''edit'$collection_name'View'\''}}'\"' class='\"'button'\"'>Edit</a><a href='\"'#'\"' class="removeButton button">Remove</a></td>\n\t\t\t\t</tr>\n\t\t\t{{/each}}\n\t\t</tbody>\n\t</table>\n</template>\n\n';


# merge whole template code into single object (new_document_template)
new_document_template+=$edit_document_template;
new_document_template+=$document_list_template;

# append whole template code into template file
echo -e $new_document_template >> "$template_file";



# ===================================================
# MODEL
# ===================================================

model_string=$''$collection_name' = new Meteor.Collection('\'$collection_object\'');\n\nMeteor.publish('\'$collection_object\'', function(){\n\treturn Meteor.'$collection_object'.find({}, {fields:{';
for i in ${@:2}
do
	field_name=${i%:*};
	model_string+=$field_name':1, ';
done

# remove last character - unnecessary comma
model_string="${model_string:0:-2}";

model_string+='}});\n});\n';

# append whole model code to file
echo -e $model_string >> "$model_file";


# ===================================================
# CONTROLLERS
# ===================================================

controller_string=$''$collection_name' = new Meteor.Collection('\'$collection_object\'');\n\n';

controller_string+='Template.'$collection_object'ListTemplate.helpers({\n\t'$collection_object'List: function(){\n\t\treturn '$collection_name\.'find();\n\t}\n});\n\n';

# check if some additional methods are needed
for i in ${@:2}
do
	field_name=${i%:*};
	field_type=${i#*:};
	# if [ field_type == "checkbox" ]; then

	# fi
done

# ===========	new form event 	===========
controller_new_string+='Template.new'$collection_name'Template.events({\n\t'\''submit #new'$collection_name'Form'\'': function(e){\n\t\te.preventDefault();\n\t\tvar form = $(e.currentTarget)'\,;

variables_list=$'';

# js code for getting newCollectionForm variables
for i in ${@:2}
do
	field_name=${i%:*};
	field_type=${i#*:};

	# for ver. 1+
	# if [ field_type == "checkbox" ]; then	
	# fi
	controller_new_string+='\n\t\t\t'$field_name' = form.find('\''#'$field_name\'').val(),';
	variables_list+=$''$field_name': '$field_name', ';
done
# remove last comma and replace it with semicolon
controller_new_string="${controller_new_string:0:-1}";
controller_new_string+=';\n\n\n'

# insert into Collection js script
controller_new_string+='\t\tvar '$collection_object' = '$collection_name'.insert({';
# remove unnecessary comma 
variables_list="${variables_list:0:-2}";
controller_new_string+=$variables_list'});\n\n'
controller_new_string+=$'''\t\tif('$collection_object'){\n\t\t\tRouter.go('\'$collection_object'ListView'\'');\n';
# throwAlert is my custom function for notifications - its code is commented at the bottom of this file
controller_new_string+=$'''\t\t\tthrowAlert('\''Successfully added new category'\'', '\''success'\'');\n';
controller_new_string+=$'''\t\t}else{\n';
controller_new_string+=$'''\t\t\tthrowAlert('\''Something went wrong'\'', '\''error'\'');\n\t\t}\n\t}\n});\n\n';

controller_string+=$controller_new_string;



# ===========	update form event (I repeat almost whole newForm code in case someone would like to modify it here)	===========

controller_edit_string='Template.edit'$collection_name'Template.events({\n\t'\''submit #edit'$collection_name'Form'\'': function(e){\n\t\te.preventDefault();\n\t\tvar form = $(e.currentTarget)'\,;

variables_list=$'';

# js code for getting editCollectionForm variables
for i in ${@:2}
do
	field_name=${i%:*};
	field_type=${i#*:};

	# for ver. 1+
	# if [ field_type == "checkbox" ]; then	
	# fi
	controller_edit_string+='\n\t\t\t'$field_name' = form.find('\''#'$field_name\'').val(),';
	variables_list+=$''$field_name': '$field_name', ';
done
# remove last comma and replace it with semicolon
controller_edit_string="${controller_edit_string:0:-1}";
controller_edit_string+=';\n\n\n'

# insert into Collection js script
controller_edit_string+='\t\tvar '$collection_object' = '$collection_name'.insert({';
# remove unnecessary comma 
variables_list="${variables_list:0:-2}";
controller_edit_string+=$variables_list'}, function(error){\n'
controller_edit_string+=$'''\t\t\tif(error){\n';
# throwAlert is my custom function for notifications - its code is commented at the bottom of this file
controller_edit_string+=$'''\t\t\t\tthrowAlert('\''Something went wrong'\'', '\''error'\'');\n';
controller_edit_string+=$'''\t\t\t}else{\n';
controller_edit_string+=$'''\t\t\t\tRouter.go('\'$collection_object'ListView'\'');\n\t\t\t\tthrowAlert('\''Successfully added new category'\'', '\''success'\'');\n\t\t\t}\n\t\t});\n\t}\n});\n\n';

controller_string+=$controller_edit_string;

# removing document click event
controller_string+='Template.'$collection_object'ListTemplate.events({\n\t'\''click .removeButton'\'': function(e){\n\t\te.preventDefault();\n\n\t\t'$collection_name'.remove(this._id, function(error){\n\t\t\tif(error){\n\t\t\t\tthrowAlert('\''Something went wrong'\'', '\''error'\'');\n\t\t\t}else{\n\t\t\t\tthrowAlert('\'$collection_name' removed'\'', '\''success'\'');\n\t\t\t}\n\t\t});\n\t},\n});\n\n';


controller_string+='Deps.autorun(function(){\n\tMeteor.subscribe('\'$collection_object\'');\n});';

# append whole controller code to file
echo -e $controller_string >> "$controller_file";



# ===================================================
# ROUTER
# ===================================================

# beginning of the router declaration and setting collection list view route
router_string='Router.map(function(){\n\tthis.route('\'$collection_object'ListView'\'', {\n\t\tpath: '\''/'$collection_object\'',\n\t\ttemplate: '\'$collection_object'ListTemplate'\'',\n\t\tdata: function(){\n\t\t\treturn '$collection_name\.'find();\n\t\t}\n\t});\n\n';

# new collection document route declaration
router_string+='\tthis.route('\''new'$collection_name'View'\'', {\n\t\tpath: '\''/'$collection_object'/new'\'',\n\t\ttemplate: '\''new'$collection_name'Template'\''\n\t});\n\n';

# edit collection document route declaration and router file ending
router_string+='\tthis.route('\''edit'$collection_name'View'\'', {\n\t\tpath: '\''/'$collection_object'/:_id/edit'\'',\n\t\ttemplate: '\''edit'$collection_name'Template'\'',\n\t\tdata: function(){\n\t\t\treturn '$collection_name'.findOne(this.params._id);\n\t\t}\n\t});\n});';

echo -e $router_string >> "$router_file";




# alerts template tag (insert it somewhere in on of Your main layouts)
# {{> alertsTemplate}} 

# alerts template HTML
# <template name="alertsTemplate">
#     <div class="mainContainer">
#         <div class="line" id="alerts">
#             {{#each alerts}}
#                 {{> alert}}
#             {{/each}}
#         </div>
#     </div>
# </template>

# <template name="alert">
#     <div class="{{type}} alert">
#         {{message}}
#         <span class="closeButton">&times;</span>
#     </div>
# </template>

# alert helper functions
# Template.alertsTemplate.helpers({
#     alerts: function(){
#         return Alerts.find();
#     }
# });
# cleanAlerts = function(){
#     Alerts.remove({seen: true});
# };
# Template.alertsTemplate.events({
#     'click .closeButton': function(e){
#         e.preventDefault();
#         $(e.currentTarget).closest('.alert').fadeOut(300, function(){
#             $(e.currentTarget).closest('.alert').remove();
#         });
#         Alerts.update(this._id, {$set: {seen:true}});
#     },
#     'click #alerts .alert': function(e){
#         e.preventDefault();
#         $(e.currentTarget).fadeOut(300, function(){
#             $(e.currentTarget).remove();
#         });
#         Alerts.update(this._id, {$set: {seen:true}});
#     }
# });
# throwAlert = function(message, type){
# 	Alerts.insert({message: message, seen: false, type: type});
# }
# Template.alert.rendered = function(){
#     var alert = this.data;
#     Meteor.defer(function(){
#         Alerts.update(alert._id, {$set: {seen:true}});
#     });
# };