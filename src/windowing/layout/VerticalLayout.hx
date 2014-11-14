package windowing.layout;
import openfl.display.Sprite;

/**
 * ...
 * @author David Speck
 */
class VerticalLayout implements ILayout
{
	public function new() { }
	
	public function getId():String { return "VERTICAL"; }
	
	public function apply(container : Sprite) : Void 
	{
		var offsetY : Float = calculateStartOffset(container);
		for (i in 0...container.numChildren) {
			var child = container.getChildAt(i);
			child.x = 0;
			child.y = offsetY;
			offsetY += child.height;
		}
	}
	
	// Calculate offset such that the content will be centered.
	// If the content is bigger then the container the offest will be 0.
	private function calculateStartOffset(container : Sprite) : Float
	{
		var contentHeight : Float = 0;
		for (i in 0...container.numChildren) {
			contentHeight += container.getChildAt(i).height;
		}
		
		return (contentHeight > container.height) ? 0 : container.height / 2.0 - contentHeight / 2.0;
	}
}