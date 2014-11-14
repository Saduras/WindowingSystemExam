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
	var label				: TextField;
	var labelWidth			: Float;
	var backgroundWidth		: Float;
	var backgroundHeight	: Float;
	var fillColor			: Int = 0xEEEEEE;
	
	public function new(labelWidth : Float, backgroundWidth : Float, backgroundHeight : Float)
	{
		super();
		
		this.labelWidth = labelWidth;
		this.backgroundWidth = backgroundWidth;
		this.backgroundHeight = backgroundHeight;
		
		// Load the custom font
		var font : Font = Assets.getFont("fonts/Quicksand-Regular.ttf");
		
		// Define the TextFormat
		var labelFormat : TextFormat = new TextFormat();
		labelFormat.font = font.fontName;
		labelFormat.size = 14.0;
		labelFormat.align = TextFormatAlign.CENTER;
		
		label = new TextField();
		this.addChild(label);
		label.embedFonts = true;
		label.defaultTextFormat = labelFormat; // Set text format before adding the text
		label.text = "output label";
		label.width = labelWidth;
		label.height = label.textHeight * 1.4;
		label.mouseEnabled = false;
		label.selectable = false;
		
		label.y = (backgroundHeight - label.textHeight) / 2;
		
		Draw();
	}
	
	public function Draw() : Void
	{
		graphics.clear();
		graphics.beginFill(fillColor, 1.0);
		graphics.drawRect(0, 0, backgroundWidth, backgroundHeight );
		graphics.endFill();
	}
	
	public function SetText(text : String, warning : Bool) : Void
	{
		label.text = text;
		if (warning) {
			label.textColor = 0xFF0000;
		} else {
			label.textColor = 0x333333;
		}
		
	}
}