package windowing;

import openfl.display.Sprite;
import windowing.events.WindowEvent;
import windowing.layout.ContainerWithLayout;
import windowing.layout.HorizontalLayout;

/**
 * ...
 * @author David Speck
 */
class Window extends Sprite
{
	//{ Member
	// Window width
	public var windowWidth : Float;
	// Window height
	public var windowHeight : Float;
	// Border thickness
	public var borderSize : Int = 2;
	// Color of the window border
	public var borderColor : Int = 0x666666;
	// Background color for content area
	public var backgroundColor : Int = 0xdddddd;
	
	// Title bar component of this window
	public var titleBar : TitleBar;
	// Window content
	public var content : ContainerWithLayout;
	// Controller who handles event logic
	var controller : WindowController;
	
	var isMinimized : Bool = false;
	//}

	public function new(title : String, width : Float, height : Float) 
	{
		super();
		
		// Assign width & height
		windowWidth = width;
		windowHeight = height;
		
		// Create title bar
		titleBar = new TitleBar(title, windowWidth, 22);
		this.addChild(titleBar);
		
		// Create content container
		var layout = new HorizontalLayout();
		content = new ContainerWithLayout(layout);
		content.x = 0;
		content.y = titleBar.titlebarHeight;
		this.addChild(content);
		
		// Setup controller
		controller = new WindowController(this);
	}
	
	// Draw this window and all its components.
	public function draw() : Void
	{
		graphics.clear();
		if (isMinimized) {
			// Draw border rectangle
			// around title bar only
			graphics.beginFill(borderColor);
			graphics.drawRect(-borderSize, -borderSize, windowWidth + 2*borderSize, titleBar.titlebarHeight + 2*borderSize);
			graphics.endFill();
		} else {
			// Draw border rectangle 
			// around window
			graphics.beginFill(borderColor);
			graphics.drawRect(-borderSize, -borderSize, windowWidth + 2*borderSize, windowHeight + 2*borderSize);
			graphics.endFill();
			// Fill content area with background color
			graphics.beginFill(backgroundColor);
			graphics.drawRect(0, titleBar.titlebarHeight, windowWidth, windowHeight - titleBar.titlebarHeight);
			graphics.endFill();
		}
		
		titleBar.Draw();
	}
	
	// Bring window to the front and highlight it as active.
	public function activate() : Void 
	{
		titleBar.isActive = true;
		draw();
		
		dispatchEvent(new WindowEvent(WindowEvent.ACTIVATED, this));
	}
	
	// Display windows as inactive.
	public function deactivate() : Void 
	{
		titleBar.isActive = false;
		draw();
		
		dispatchEvent(new WindowEvent(WindowEvent.DEACTIVATED, this));
	}
	
	// Move window to coordinates (x,y).
	public function moveTo(x : Float, y : Float)
	{
		this.x = x;
		this.y = y;
	}
	
	// Close this window by detaching it from its parent.
	public function close() 
	{
		parent.removeChild(this);
		dispatchEvent(new WindowEvent(WindowEvent.CLOSED, this));
	}
	
	// Reduce window to title bar and back to full view.
	public function toggleMinimize() 
	{
		isMinimized = !isMinimized;
		draw();
		
		if (isMinimized) {
			content.visible = false;
			dispatchEvent(new WindowEvent(WindowEvent.MINIMIZED, this));
		} else {
			content.visible = true;
			dispatchEvent(new WindowEvent(WindowEvent.SIZE_RESTORED, this));
		}
	}
}