package basicUI ;

import flash.events.Event;
import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.events.MouseEvent;

/**
 * Simple rectangle button with three different states: default, mouse_over, pressed
 * Background, border and text color for each of the states can set seperatly.
 * @author David Speck
 */
class Button extends Sprite
{
	// Color set for the DEFAULT state
	public var backgroundColor : Int = 0xaaaaaa;
	public var borderColor : Int = 0x666666;
	public var textColor : Int = 0x000000;
	
	// Color set for the MOUSE_OVER state
	public var mouseOverBackgroundColor : Int = 0xaaaaee;
	public var mouseOverBorderColor : Int = 0x666666;
	public var mouseOverTextColor : Int = 0x000000;
	
	// Color set for the PRESSED state
	public var mouseDownBackgroundColor : Int = 0x666666;
	public var mouseDownBorderColor : Int = 0xaaaaaa;
	public var mouseDownTextColor : Int = 0xbbbbbb;
	
	// Button text label
	public var label : TextField;
	
	// Width of the button
	public var buttonWidth : Float;
	// Height of the button
	public var buttonHeight : Float;
	// Thickness of the button border
	public var borderSize : Int = 1;
	
	// Current state of the button
	var buttonState : ButtonState = ButtonState.DEFAULT;

	public function new(text : String, width : Float, height : Float, ?borderSize : Int) 
	{
		super();
		
		// Assign width & heigth
		this.buttonWidth = width;
		this.buttonHeight = height;
		
		// Assign border size
		if(borderSize != null)
			this.borderSize = borderSize;
		
		// Create label
		label = new TextField();
		label.selectable = false;
		label.mouseEnabled = false;
		label.text = text;
		label.width = buttonWidth * 1.05;
		label.height = buttonHeight * 1.05;
		
		this.addChild(label);
		
		// Connect events
		this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
		this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		this.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
	}
	
	// Change current state of the button
	// and re-draw this button to display this new state.
	public function goToState(state : ButtonState) : Void
	{
		buttonState = state;
		this.draw();
	}
	
	// Choose colors by button state
	// and draw rectangles for border and background.
	// Also update label text color
	public function draw() : Void 
	{
		// Choose color
		var background, border, text : Int;
		switch(buttonState) {
			case ButtonState.DEFAULT:
				background = backgroundColor;
				border = borderColor;
				text = textColor;
			case ButtonState.MOUSE_OVER:
				background = mouseOverBackgroundColor;
				border = mouseOverBorderColor;
				text = mouseOverTextColor;
			case ButtonState.PRESSED:
				background = mouseDownBackgroundColor;
				border = mouseDownBorderColor;
				text = mouseDownTextColor;
		}
		
		// Clear old display
		graphics.clear();
		// Draw lowest rectangle to show border
		graphics.beginFill(border);
		graphics.drawRect( -borderSize, -borderSize, buttonWidth + 2 * borderSize, buttonHeight + 2 * borderSize);
		graphics.endFill();
		// Draw background rectangle
		graphics.beginFill(background);
		graphics.drawRect(0, 0, buttonWidth, buttonHeight);
		graphics.endFill();
		// Update text color
		label.textColor = text;
	}
	
	//{ Event handler
	private function onMouseOver(e : Event) : Void
	{
		goToState(ButtonState.MOUSE_OVER);
	}
	
	private function onMouseOut(e : Event) : Void
	{
		goToState(ButtonState.DEFAULT);
	}
	
	private function onMouseDown(e : Event) : Void
	{
		goToState(ButtonState.PRESSED);
	}
	
	private function onMouseUp(e : Event) : Void
	{
		goToState(ButtonState.MOUSE_OVER);
	}
	//}
}

enum ButtonState {
	DEFAULT;
	MOUSE_OVER;
	PRESSED;
}