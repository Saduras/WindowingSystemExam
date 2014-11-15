package windowing;

import openfl.display.Sprite;
import windowing.events.WindowEvent;
import windowing.layout.ContainerWithLayout;
import windowing.layout.FreeLayout;
import windowing.layout.HorizontalLayout;
import windowing.layout.ILayout;
import windowing.layout.VerticalLayout;

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
	// Resize handle
	public var resizeHandle : WindowResizeHandle;
	// Controller who handles event logic
	var controller : WindowController;
	
	// Flag if the winow is currenlty minimized
	var isMinimized : Bool = false;
	//}

	public function new(title : String, width : Float, height : Float, layout : ILayout) 
	{
		super();
		
		// Assign width & height
		windowWidth = width;
		windowHeight = height;
		
		// Create title bar
		titleBar = new TitleBar(title, windowWidth, 22);
		this.addChild(titleBar);
		
		// Create content container
		content = new ContainerWithLayout(layout);
		content.x = 0;
		content.y = titleBar.titlebarHeight;
		this.addChild(content);
		
		// Create resize handle
		resizeHandle = new WindowResizeHandle();
		this.addChild(resizeHandle);
		
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
		
		// Draw title bar
		titleBar.titleBarWidth = windowWidth;
		titleBar.draw();
		
		// Draw resize handle
		resizeHandle.draw();
		// Place the handle in the bottom right corner
		resizeHandle.x = windowWidth - resizeHandle.handleSize;
		resizeHandle.y = windowHeight - resizeHandle.handleSize;
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
		// Toggle minimized
		isMinimized = !isMinimized;
		// Re-draw window
		draw();
		
		if (isMinimized) {
			// Hide everthing but the title bar
			content.visible = false;
			resizeHandle.visible = false;
			
			dispatchEvent(new WindowEvent(WindowEvent.MINIMIZED, this));
		} else {
			// Show hidden components again
			content.visible = true;
			resizeHandle.visible = true;
			
			dispatchEvent(new WindowEvent(WindowEvent.SIZE_RESTORED, this));
		}
	}
}