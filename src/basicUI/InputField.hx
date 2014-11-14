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
import basicUI.Tooltip;

/**
 * ...
 * @author David
 */
class InputField extends Sprite
{

	var label 		: TextField;
	var inputField 	: TextField;
	var tooltip		: Tooltip;
	
	var labelColor 		: Int 	= 0x000000;
	var labelWidth		: Float = 140;
	var inputTextColor 	: Int = 0xffffff;
	var inputWidth		: Float = 100;
	var inputPadding	: Float = 5;
	
	var backgroundColor 			: Int = 0x0b5394;
	var activeBackgroundColor		: Int = 0x3d85c6;
	var borderColor 				: Int = 0x3d85c6;
	var activeBorderColor			: Int = 0x6fa8dc;
	
	var fillColor	: Int;
	var lineColor	: Int;
	
	var stringValidator : StringValidator;
	
	public function new(labelText : String, validationType : String, tooltipText : String) 
	{
		super();
		
		// Create validator
		stringValidator = new StringValidator(validationType);
		
		// Load the custom font
		var font : Font = Assets.getFont("fonts/Quicksand-Regular.ttf");
		
		// Define the TextFormat
		var labelFormat : TextFormat = new TextFormat();
		labelFormat.font = font.fontName;
		labelFormat.size = 14.0;
		var inputFormat : TextFormat = new TextFormat();
		inputFormat.font = font.fontName;
		inputFormat.size = 14.0;
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
		inputField.addEventListener(MouseEvent.CLICK, handleGetFocus);
		inputField.addEventListener(FocusEvent.FOCUS_OUT, handleLoseFocus);
		label.addEventListener(MouseEvent.MOUSE_OVER, handleMouseIn);
		label.addEventListener(MouseEvent.MOUSE_OUT, handleMouseOut);
		
		// Initalize colors
		fillColor = backgroundColor;
		lineColor = borderColor;
		
		// add tooltip
		tooltip = new Tooltip(tooltipText);
		this.addChild(tooltip);
		tooltip.x = 0;
		tooltip.y = label.height;
		tooltip.visible = false;
		
		Draw();
	}
	
	private function handleMouseOut(e : MouseEvent) : Void
	{
		tooltip.visible = false;
	}
	
	private function handleMouseIn(e : MouseEvent) : Void
	{
		tooltip.visible = true;
	}
	
	private function handleLoseFocus(e : FocusEvent) : Void 
	{
		fillColor = backgroundColor;
		lineColor = borderColor;
		Draw();
	}
	
	private function handleGetFocus(e : MouseEvent) : Void 
	{
		fillColor = activeBackgroundColor;
		lineColor = activeBorderColor;
		Draw();
	}
	
	public function Draw() : Void
	{
		graphics.clear();
		graphics.lineStyle(2.0, lineColor);
		graphics.beginFill(fillColor, 1.0);
		graphics.drawRect(labelWidth + inputPadding, - inputPadding, inputWidth + 2*inputPadding + 5, inputField.textHeight + 2*inputPadding + 5);
		graphics.endFill();
	}
	
	public function Validate() : Bool
	{
		return stringValidator.checkText(inputField.text);
	}
	
	public function GetValue() : Dynamic
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
	
	public function SetValue(value:Dynamic) : Void
	{
		if (stringValidator.modus == "color")
		{
			inputField.text = "#" + StringTools.hex(value, 6);
		} else {
			inputField.text = value;
		}
	}
	
	public function GetLabel() : String
	{
		return label.text;
	}
	
	public function GetValidationMode() : String
	{
		return stringValidator.modus;
	}
}