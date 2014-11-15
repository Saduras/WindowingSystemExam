package basicUI;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.FocusEvent;
import flash.events.MouseEvent;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFieldType;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import openfl.Assets;

/**
 * ...
 * @author David
 */
class InputField extends Sprite
{
	// Input field components
	var label 		: TextField;
	var inputField 	: TextField;
	
	// Label properties
	var labelColor 		: Int 	= 0x000000;
	var labelWidth		: Float = 80;
	// Input area properties
	var inputTextColor 	: Int = 0xffffff;
	var inputWidth		: Float = 100;
	var inputPadding	: Float = 3;
	
	// Default colors for input area
	var backgroundColor 			: Int = 0x0b5394;
	var borderColor 				: Int = 0x3d85c6;
	// Highlight colors if input area has focus
	var activeBackgroundColor		: Int = 0x3d85c6;
	var activeBorderColor			: Int = 0x6fa8dc;
	
	// Background color for the current state (has focus or not)
	var fillColor	: Int;
	// Border color for the current state (has focus or not)
	var lineColor	: Int;
	
	// Validator for the input field mode
	var stringValidator : StringValidator;
	
	public function new(labelText : String, validationType : String) 
	{
		super();
		
		// Create validator
		stringValidator = new StringValidator(validationType);
		
		// Load the custom font
		var font : Font = Assets.getFont("fonts/Quicksand-Regular.ttf");
		
		// Define the TextFormat
		var labelFormat : TextFormat = new TextFormat();
		labelFormat.font = font.fontName;
		labelFormat.size = 12.0;
		var inputFormat : TextFormat = new TextFormat();
		inputFormat.font = font.fontName;
		inputFormat.size = 12.0;
		inputFormat.align = TextFormatAlign.RIGHT;
		
		// Create the label TextField
		label = new TextField();
		this.addChild(label);
		label.embedFonts = true;
		label.defaultTextFormat = labelFormat; // Set text format before adding the text
		label.text = labelText;
		label.textColor = labelColor;
		label.width = labelWidth * 1.2;
		label.height = label.textHeight * 1.5;
		label.mouseEnabled = true;
		label.selectable = false;
		
		// Create the input TextField
		inputField = new TextField();
		this.addChild(inputField);
		inputField.embedFonts = true;
		inputField.defaultTextFormat = inputFormat; // Set text format before adding the text
		inputField.type = TextFieldType.INPUT;
		inputField.text = "Enter input here!";
		inputField.textColor = inputTextColor;
		inputField.width = inputWidth * 1.05;
		inputField.height = inputField.textHeight * 1.4;
		inputField.x = labelWidth + 2*inputPadding; // Move input next to the label
		
		// Add event listener
		inputField.addEventListener(MouseEvent.CLICK, onGetFocus);
		inputField.addEventListener(FocusEvent.FOCUS_OUT, onLoseFocus);
		
		// Initalize colors
		fillColor = backgroundColor;
		lineColor = borderColor;
		
		draw();
	}
	
	//{ Event handler
	
	// Display input area as inactive if focus is lost.
	private function onLoseFocus(e : FocusEvent) : Void 
	{
		fillColor = backgroundColor;
		lineColor = borderColor;
		draw();
	}
	
	// Display input area as active if focus is gained.
	private function onGetFocus(e : MouseEvent) : Void 
	{
		fillColor = activeBackgroundColor;
		lineColor = activeBorderColor;
		draw();
	}
	//}
	
	// Draw rectangle for input area.
	public function draw() : Void
	{
		graphics.clear();
		graphics.lineStyle(2.0, lineColor);
		graphics.beginFill(fillColor, 1.0);
		graphics.drawRect(labelWidth + inputPadding, - inputPadding, inputWidth + 2*inputPadding + 5, inputField.textHeight + 2*inputPadding + 5);
		graphics.endFill();
	}
	
	// Check if current string in textfield is valid
	// for the set validation mode.
	public function validate() : Bool
	{
		return stringValidator.checkText(inputField.text);
	}
	
	// Return value of the input field with correct type
	// for the validation mode.
	public function getValue() : Dynamic
	{
		if (stringValidator.modus == "text")
		{
			return inputField.text;
		}
		else if (stringValidator.modus == "number")
		{
			return Std.parseInt(inputField.text);
		}
		else if (stringValidator.modus == "float")
		{
			return Std.parseFloat(inputField.text);
		}
		else if (stringValidator.modus == "color")
		{
			return Std.parseInt("0x" + inputField.text.substr(1));
		}
		return null;
	}
	
	// Set string in input field.
	// Convert color value to hex format for colors.
	public function setValue(value : Dynamic) : Void
	{
		if (stringValidator.modus == "color")
		{
			inputField.text = "#" + StringTools.hex(value, 6);
		} else {
			inputField.text = value;
		}
	}
	
	// Get label of the input field.
	public function getLabel() : String
	{
		return label.text;
	}
	
	// Get current validation mode.
	public function getValidationMode() : String
	{
		return stringValidator.modus;
	}
}