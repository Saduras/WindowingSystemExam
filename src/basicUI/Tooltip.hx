package basicUI;

import flash.display.Sprite;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import openfl.Assets;

/**
 * ...
 * @author David
 */
class Tooltip extends Sprite
{
	var label : TextField;
	var backgroundWidth : Float;
	var backgroundHeight : Float;
	
	var labelWidth 	: Float = 200.0;
	var padding		: Float = 5.0;
	var lineColor 	: Int = 0x3d85c6;
	var fillColor 	: Int = 0x0b5394;
	
	public function new(text : String) 
	{
		super();
		
		// Load the custom font
		var font : Font = Assets.getFont("fonts/Amble-Regular.ttf");
		
		// Define the TextFormat
		var labelFormat : TextFormat = new TextFormat();
		labelFormat.font = font.fontName;
		labelFormat.size = 14.0;
		labelFormat.color = 0xFFFFFF;
		
		label = new TextField();
		this.addChild(label);
		label.embedFonts = true;
		label.defaultTextFormat = labelFormat;
		label.text = text;
		label.width = labelWidth;
		label.autoSize = TextFieldAutoSize.LEFT;
		label.multiline = true;
		//label.height = label.textHeight * 1.4;
		label.wordWrap = true;
		label.selectable = false;
		label.x = padding;
		label.y = padding;
		
		Draw();
	}
	
	public function Draw()
	{
		graphics.clear();
		graphics.lineStyle(2.0, lineColor);
		graphics.beginFill(fillColor, 1.0);
		graphics.drawRect(0,0, label.width + 2*padding, label.height + 2* padding);
		graphics.endFill();
	}
	
}