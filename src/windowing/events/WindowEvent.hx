package windowing.events;

import openfl.events.Event;
import windowing.Window;

/**
 * Window event class. Each event consists of type and source window.
 * @author David Speck
 */
class WindowEvent extends Event
{
	// Event called if window was activated (e.g. by click)
	public static inline var ACTIVATED : String = "ACTIVATED";
	// Event called if window is deactivated after been active
	public static inline var DEACTIVATED : String = "DEACTIVATED";
	// Event called if windows close button is clicked
	public static inline var CLOSED : String = "CLOSED";
	// Event called if windows minimze button is clicked
	// and window wasn't minimized.
	public static inline var MINIMIZED : String = "MINIMIZED";
	// Event called if windows minimze button is clicked
	// while window is minimzed.
	public static inline var SIZE_RESTORED : String = "SIZE_RESTORED";
	
	// Window object that caused the event.
	public var source : Window;

	public function new(type:String, source) 
	{
		super(type);
		
		this.source = source;
	}
	
}