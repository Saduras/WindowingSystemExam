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

	public function new(target : Window) 
	{
		this.windowView = target;
		
		windowView.addEventListener(MouseEvent.CLICK, onMouseClick);
		windowView.titleBar.addEventListener(MouseEvent.MOUSE_DOWN, onTitleBarMouseDown);
		windowView.titleBar.addEventListener(MouseEvent.MOUSE_UP, onTitleBarMouseUp);
		windowView.titleBar.closeButton.addEventListener(MouseEvent.CLICK, onCloseClick);
		windowView.titleBar.minimizeButton.addEventListener(MouseEvent.CLICK, onMinimzeClick);
	}
	
	//{ Event handler
	// Activate window on click.
	private function onMouseClick(e : Event) : Void 
	{
		windowView.activate();
	}
	
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
}