package windowing.layout;
import flash.display.DisplayObjectContainer;

/**
 * ...
 * @author David Speck
 */
class HorizontalLayout implements ILayout
{
	
	
	public function new() { }
	
	public function getId():String { return "HORIZONTAL"; }
	
	public function apply(container : DisplayObjectContainer) : Void 
	{
		var offsetX : Float = 0;
		for (i in 0...container.numChildren) {
			var child = container.getChildAt(i);
			child.x = offsetX;
			child.y = 0;
			offsetX += child.width;
		}
	}
}