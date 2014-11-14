package windowing.layout;
import flash.display.DisplayObjectContainer;

/**
 * ...
 * @author David Speck
 */
class HorizontalLayout implements ILayout
{

	public function new() 
	{
		
	}
	
	function get_id() : String 
	{
		return "HORIZONTAL";
	}
	
	public function apply(container : DisplayObjectContainer) : Void 
	{
		var offsetX : Float = 0;
		for (i = 0...container.numChildren) {
			var child = container.getChildAt(i);
		}
	}
	
}