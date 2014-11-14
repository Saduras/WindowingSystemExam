package windowing.events;

import openfl.events.Event;
import windowing.Window;

/**
 * ...
 * @author David Speck
 */
class WindowEvent extends Event
{
	public static inline var ACTIVATED : String = "ACTIVATED";
	public static inline var DEACTIVATED : String = "DEACTIVATED";
	public static inline var CLOSED : String = "CLOSED";
	public static inline var MINIMIZED : String = "MINIMIZED";
	public static inline var SIZE_RESTORED : String = "SIZE_RESTORED";
	
	public var source : Window;

	public function new(type:String, source) 
	{
		super(type);
		
		this.source = source;
	}
	
}