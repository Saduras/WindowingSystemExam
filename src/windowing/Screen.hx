package windowing;

import openfl.display.Stage;
import openfl.events.Event;
import openfl.display.DisplayObjectContainer;
import openfl.display.Sprite;
import openfl.utils.Dictionary;
import windowing.events.WindowEvent;
import windowing.layout.NoneLayout;
import windowing.layout.ILayout;

/**
 * The screen class is the container for the windowing system. 
 * All windows are created as a child of a screen. 
 * This class also handles the minized window bar.
 * @author David Speck
 */
class Screen extends Sprite
{
	var windowList : List<Window>;
	var activeWindow : Window;
	
	// List of windows currently minimized
	var minimizedList : List<Window>;
	// Original position of minimized windows
	var orgPos : Map<Window, Array<Float>>;
	
	// Width of the screen
	public var screenWidth : Float;
	// Height of the screen
	public var screenHeight : Float;

	public function new(width : Float, height : Float) 
	{
		super();
		
		windowList = new List<Window>();
		minimizedList = new List<Window>();
		orgPos = new Map<Window, Array<Float>>();
		
		screenWidth = width;
		screenHeight = height;
	}

	// Create a new window and add it to the screen.
	public function createWindow(title : String, layout : ILayout = null) : Window
	{
		// Use free layout by default
		if (layout == null) layout = new NoneLayout();
		
		// Create window
		var window = new Window(title, 300, 200, layout);
		window.draw();
		
		// Connect events
		window.addEventListener(WindowEvent.ACTIVATED, onWindowActivated);
		window.addEventListener(WindowEvent.CLOSED, onWindowClosed);
		window.addEventListener(WindowEvent.MINIMIZED, onWindowMinimized);
		window.addEventListener(WindowEvent.SIZE_RESTORED, onWindowSizeResotred);
		
		// Add window to the screen
		windowList.add(window);	
		this.addChild(window);
		
		return window;
	}
	
	//{ Event handler
	
	// Bring the active window to the front 
	// and deactivate the prior active window.
	private function onWindowActivated(e : Event) : Void 
	{
		var we : WindowEvent = cast(e, WindowEvent);
		
		if (activeWindow != we.source) {
			// deactive prior active window
			if (activeWindow != null) {
				activeWindow.deactivate();
			}
			
			// bring the activated window to the front
			this.setChildIndex(we.source, this.numChildren - 1);
		}
		activeWindow = we.source;
	}
	
	// Remove closed window.
	private function onWindowClosed(e : Event) : Void
	{
		var window : Window = cast(e, WindowEvent).source;
		
		if (activeWindow == window) {
			activeWindow = null;
		}
		
		windowList.remove(window);
		
		// Remove event listener on closed window
		window.removeEventListener(WindowEvent.ACTIVATED, onWindowActivated);
		window.removeEventListener(WindowEvent.CLOSED, onWindowClosed);
		window.removeEventListener(WindowEvent.MINIMIZED, onWindowMinimized);
		window.removeEventListener(WindowEvent.SIZE_RESTORED, onWindowSizeResotred);
		
		// Clean up minimized list
		if (window.isMinimized) {
			minimizedList.remove(window);
			orgPos.remove(window);
			
			arrangeMinimizedWindows();
		}
	}
	
	// Add window to minimized list and save orginal position.
	private function onWindowMinimized(e : Event) : Void
	{
		var window : Window = cast(e, WindowEvent).source;
		
		minimizedList.add(window);
		// Save postion
		orgPos.set(window, [window.x, window.y]);
		
		arrangeMinimizedWindows();
	}
	
	// Move window back to orginal position 
	// and update minimized window list.
	private function onWindowSizeResotred(e : Event) : Void
	{
		var window : Window = cast(e, WindowEvent).source;
		
		// Move back to original position
		window.x = orgPos.get(window)[0];
		window.y = orgPos.get(window)[1];
		
		// Clean up lists
		orgPos.remove(window);
		minimizedList.remove(window);
		
		arrangeMinimizedWindows();
	}
	//}
	
	//{ Helper
	
	// Arrange minimized windows horizontal at the bottom of the screen.
	public function arrangeMinimizedWindows() : Void
	{
		var offsetX : Float = 0;
		for (win in minimizedList) 
		{
			win.x = offsetX;
			win.y = this.screenHeight - win.titleBar.titlebarHeight;
			
			offsetX += win.width;
		}
	}
	//}
}