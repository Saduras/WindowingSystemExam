package windowing;

import flash.events.MouseEvent;
import flash.events.Event;

/**
 * ...
 * @author David Speck
 */
class WindowController
{
	var windowView : Window;
	
	var lastMousePos : Array<Float>;

	public function new(target : Window) 
	{
		this.windowView = target;
		
		// Window click event connection
		windowView.addEventListener(MouseEvent.CLICK, onMouseClick);
		// Titlebar event connection
		windowView.titleBar.addEventListener(MouseEvent.MOUSE_DOWN, onTitleBarMouseDown);
		windowView.titleBar.addEventListener(MouseEvent.MOUSE_UP, onTitleBarMouseUp);
		// Button event connection
		windowView.titleBar.closeButton.addEventListener(MouseEvent.CLICK, onCloseClick);
		windowView.titleBar.minimizeButton.addEventListener(MouseEvent.CLICK, onMinimzeClick);
		// Resize event connection
		windowView.resizeHandle.addEventListener(MouseEvent.MOUSE_DOWN, onResizeStart);
		windowView.resizeHandle.addEventListener(MouseEvent.MOUSE_UP, onResizeStop);
	}
	
	// Activate window on click.
	private function onMouseClick(e : Event) : Void 
	{
		windowView.activate();
	}
	
	//{ Titlebar event handler
	
	// Start drag if mouse is hold on the title bar.
	private function onTitleBarMouseDown(e : Event) : Void 
	{
		windowView.startDrag();
	}
	
	// Drop window at current mouse position.
	private function onTitleBarMouseUp(e : Event) : Void 
	{
		windowView.stopDrag();
	}
	//}
	
	//{ Button event handler
	
	// Close this window if the close button is clicked
	// and stop further event handling.
	private function onCloseClick(e : Event) : Void
	{
		windowView.close();
		e.stopImmediatePropagation();
	}
	
	// Toggle minimze on this window 
	// and stop further event handling.
	private function onMinimzeClick(e : Event) : Void
	{
		windowView.toggleMinimize();
		e.stopImmediatePropagation();
	}
	//}
	
	//{ Resize window
	// Resize window by let the resize handle follow the mouse.
	private function onResizeStart(e : Event) : Void
	{
		// Store last mose position
		lastMousePos = [windowView.mouseX, windowView.mouseY];
		// Start resize process
		windowView.addEventListener(Event.ENTER_FRAME, onResizeMove);
	}
	
	// Stop resize and update layout.
	private function onResizeStop(e : Event) : Void
	{
		// Disconnect event to stop resize process
		windowView.removeEventListener(Event.ENTER_FRAME, onResizeMove);
		windowView.content.updateLayout();
	}
	
	// Resize window by mouse delta movement.
	private function onResizeMove(e : Event) : Void
	{
		// Resize window for mouse delta movement
		windowView.windowWidth += windowView.mouseX - lastMousePos[0];
		windowView.windowHeight += windowView.mouseY - lastMousePos[1];
		
		// Re-draw window
		windowView.draw();
		
		// Store last mose position
		lastMousePos = [windowView.mouseX, windowView.mouseY];
	}
	//}
}