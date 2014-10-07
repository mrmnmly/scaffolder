# scfld is an open-source, bash-based scaffolding system for Meteor.js
# made with <3 by @ofcapl
# e-mail: kontakt@lukaszkups.pl
# web: http://lukaszkups.pl

# INFO:
# first parameter ($1) is collection name
# the rest of the parameters are single document fields with syntax: field_name:field_type
# field types:
# text, date, number, email, textarea, checkbox, radio, checkbox_collection, radio_collection
# checkbox & radio field declaration syntax should match to below one:
# field_name:field_type[option1, option2, ... , optionX]

# checkbox_collection will make checkbox list where each checkbox has value as id of the specific collection object
# radio_collection will make radio list where each radio has value as id of the specific collection object
# checkbox & radio collection field declaration syntax should match to below one:
# field_name:field_type[collection_name]


collection_name=${1^};
collection_object=${1,};

echo $collection_name;
echo "==============";
echo "collection" $collection_name "created";
echo "==============";

# create model folder & file
mkdir -p "server/model/"$collection_object;
if [ -f "server/model/"$collection_object"/"$collection_object".js" ]; then
	mv "server/model/"$collection_object"/"$collection_object".js" "server/model/"$collection_object"/"$collection_object".js.old";
fi
touch "server/model/"$collection_object"/"$collection_object".js";

# create template folder & files
mkdir -p "client/templates/"$collection_object;
if [ -f "client/templates/"$collection_object"/"$collection_object".html" ]; then
	mv "client/templates/"$collection_object"/"$collection_object".html" "client/templates/"$collection_object"/"$collection_object".html.old";
fi
touch "client/templates/"$collection_object"/"$collection_object".html";

# create controller folder & file
mkdir -p "client/js/"$collection_object;
if [ -f "client/js/"$collection_object"/"$collection_object".js" ]; then
	mv "client/js/"$collection_object"/"$collection_object".js" "client/js/"$collection_object"/"$collection_object".js.old";
fi
touch "client/js/"$collection_object"/"$collection_object".js";

model_file="server/model/"$collection_object"/"$collection_object".js";
template_file="client/templates/"$collection_object"/"$collection_object".html";
controller_file="client/js/"#collection_object"/"$collection_object".js";

#newDocumentForm
new_document_template=$'<template name=\"new'$collection_name'Template'\"'>\n\t<form id='\"'new'$collection_name'Form'\"'>\n';

# iterate through document fields/variables
for i in ${@:2}
do
	#field name
	field_name=${i%:*};
	#field type
	field_type=${i#*:};
	echo $field_type;
	if [ $field_type="text" ]; then
		new_document_template+='\t\t''<div class='\"'controls'\"'>\n\t\t\t<label for='\"$field_name\"'>'$field_name'</label>\n\t\t\t<input id='\"$field_name\"' type='\"'text'\"' name='\"$field_name\"'>\n\t\t</div>';
	elif [ $field_type="date" ]; then
		new_document_template+='\t\t<div class='\"'controls'\"'>\n\t\t\t<label for='\"$field_name\"'>'$field_name'</label>\n\t\t\t<input id='\"$field_name\"' type='\"'date'\"' name='\"$field_name\"'>\n\t\t</div>';
	elif [ $field_type="number" ]; then
		new_document_template+='\t\t<div class='\"'controls'\"'>\n\t\t\t<label for='\"$field_name\"'>'$field_name'</label>\n\t\t\t<input id='\"$field_name\"' type='\"'number'\"' name='\"$field_name\"'>\n\t\t</div>';
	elif [ $field_type="email" ]; then
		new_document_template+='\t\t<div class='\"'controls'\"'>\n\t\t\t<label for='\"$field_name\"'>'$field_name'</label>\n\t\t\t<input id='\"$field_name\"' type='\"'email'\"' name='\"$field_name\"'>\n\t\t</div>';
	elif [ $field_type="textarea" ]; then
		new_document_template+='\t\t<div class='\"'controls'\"'>\n\t\t\t<label for='\"$field_name\"'>'$field_name'</label>\n\t\t\t<textarea id='\"$field_name\"' name='\"$field_name\"'></textarea>\n\t\t</div>';

	# elif [$field_type=checkbox]; then
	# 	checkbox_list=${i}
	fi
done
new_document_template+=$'\t\t<input type='\"'submit'\"' value='\"'submit'\"' class='\"'button'\"'>\n\t</form>\n</template>\n\n';

#editDocumentForm will be almost the same (form id will be different) as newDocumentForm
edit_document_template=${new_document_template/'new'$collection_name'Template'/'edit'$collection_name'Template'};
edit_document_template=${edit_document_template/'new'$collection_name'Form'/'edit'$collection_name'Form'};

#documentList
document_list_template=$'<template name='\"$collection_object'ListTemplate'\"'>\n\t<table>\n\t\t<thead>\n\t\t\t<tr>\n\t\t\t\t<th>id</th><th>action</th>\n\t\t\t</tr>\n\t\t</thead>\n\t\t<tbody>\n\t\t\t{{#each '$collection_object'List}}\n\t\t\t\t<tr>\n\t\t\t\t\t<td>this._id</td><td><a href='\"'{{pathFor '\''edit'$collection_name\''}}'\"' class='\"'button'\"'>Edit</a><a href='\"'#'\"' class="removeButton button">Remove</a></td>\n\t\t\t\t</tr>\n\t\t\t{{/each}}\n\t\t</tbody>\n\t</table>\n</template>\n\n';

new_document_template+=$edit_document_template
new_document_template+=$document_list_template
echo -e $new_document_template >> "$template_file"