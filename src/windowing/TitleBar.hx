package windowing;

import openfl.display.SimpleButton;
import openfl.display.Sprite;
import openfl.text.TextField;
import basicUI.Button;

/**
 * ...
 * @author David Speck
 */
class TitleBar extends Sprite
{
	public var titleBarWidth : Float;
	public var titlebarHeight : Float;
	
	public var label : TextField;
	public var closeButton : Button;
	public var minimizeButton : Button;
	
	public static var activeColor : Int = 0x9999ee;
	public static var inactiveColor : Int = 0x333366;
	
	public var isActive : Bool = false;

	public function new(titleText : String, width : Float, height: Float) 
	{
		super();
		
		// Assign width & height
		titleBarWidth = width;
		titlebarHeight = height;
		
		// Add label for title text
		label = new TextField();
		label.text = titleText;
		label.selectable = false;
		label.mouseEnabled = false;
		label.textColor = 0xffffff;
		label.height = titlebarHeight;
		this.addChild(label);
		
		// Add close button
		var buttonSize : Float = titlebarHeight - 2;
		closeButton = new Button("x", buttonSize, buttonSize);
		this.addChild(closeButton);
		
		// Add minimize button
		minimizeButton = new Button("_", buttonSize, buttonSize);
		this.addChild(minimizeButton);
	}
	
	// Draw rectangual background for the titlebar and buttons.
	public function draw() : Void
	{
		graphics.clear();
		if (isActive) {
			graphics.beginFill(activeColor, 1);
		} else {
			graphics.beginFill(inactiveColor, 1);
		}
		graphics.drawRect(0, 0, titleBarWidth, titlebarHeight);
		graphics.endFill();
		
		// Draw buttons of this title bar
		closeButton.draw();
		minimizeButton.draw();
		
		// Place the button on the right end of the title bar
		closeButton.y = 1;
		closeButton.x = titleBarWidth - closeButton.buttonWidth; 
		// Place minimize next left to close button
		minimizeButton.y = 1;
		minimizeButton.x = closeButton.x - minimizeButton.buttonWidth - 2; 
	}
}