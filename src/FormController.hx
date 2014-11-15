package ;

import basicUI.InputField;
import basicUI.OutputField;

/**
 * Simple forme controler to test validation.
 * Validate all input fields on submit.
 * @author David Speck
 */
class FormController
{
	// Assigned list of input fields.
	var inputFields : List<InputField>;
	// Print validation result in output field
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
	
	// Validate input fields and return true on success or false else.
	// Additional print feedback to output field
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