package basicUI;

import flash.display.Sprite;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import openfl.Assets;

/**
 * ...
 * @author David
 */
class OutputField extends Sprite
{
	// Output text label.
	var label				: TextField;
	// Output area properties.
	var labelWidth			: Float;
	var backgroundWidth		: Float;
	var backgroundHeight	: Float;
	var fillColor			: Int = 0xEEEEEE;
	
	public function new(labelWidth : Float, backgroundWidth : Float, backgroundHeight : Float)
	{
		super();
		
		// Assign width & height.
		this.labelWidth = labelWidth;
		this.backgroundWidth = backgroundWidth;
		this.backgroundHeight = backgroundHeight;
		
		// Load the custom font
		var font : Font = Assets.getFont("fonts/Quicksand-Regular.ttf");
		
		// Define the TextFormat
		var labelFormat : TextFormat = new TextFormat();
		labelFormat.font = font.fontName;
		labelFormat.size = 12.0;
		labelFormat.align = TextFormatAlign.CENTER;
		
		// Create text label
		label = new TextField();
		this.addChild(label);
		
		// Add text format
		label.embedFonts = true;
		label.defaultTextFormat = labelFormat; // Set text format before adding the text
		
		// Set default text
		label.text = "output label";
		
		// Set size
		label.width = labelWidth;
		label.height = label.textHeight * 1.4;
		
		// Set the label not selectable
		label.mouseEnabled = false;
		label.selectable = false;
		
		// Center the text in y direction
		label.y = (backgroundHeight - label.textHeight) / 2;
		
		draw();
	}
	
	// Draw a rectangle for the output area.
	public function draw() : Void
	{
		graphics.clear();
		graphics.beginFill(fillColor, 1.0);
		graphics.drawRect(0, 0, backgroundWidth, backgroundHeight );
		graphics.endFill();
	}
	
	// Set the output text.
	public function setText(text : String, warning : Bool) : Void
	{
		label.text = text;
		if (warning) {
			label.textColor = 0xFF0000;
		} else {
			label.textColor = 0x333333;
		}
		
	}
}