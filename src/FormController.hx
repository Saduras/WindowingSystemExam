package ;

import basicUI.InputField;
import basicUI.OutputField;

/**
 * ...
 * @author David Speck
 */
class FormController
{
	var inputFields : List<InputField>;
	var outputField : OutputField;
	
	public function new() 
	{ 
		inputFields = new List<InputField>();
	}
	
	public function addInputField(field : InputField) : Void
	{
		inputFields.add(field);
	}
	
	public function setOutputField(output : OutputField) : Void
	{
		outputField = output;
	}
	
	public function submit() : Bool
	{
		for (input in inputFields) {
			if (!input.validate()) {
				outputField.setText(input.getLabel() + " is not a valid " + input.getValidationMode(), true);
				return false;
			}
		}
		
		outputField.setText("Submit successfull!", false);
		return true;
	}
}