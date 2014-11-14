package windowing.layout;
import openfl.display.Sprite;

/**
 * ...
 * @author David Speck
 */
class HorizontalLayout implements ILayout
{
	public function new() { }
	
	public function getId():String { return "HORIZONTAL"; }
	
	public function apply(container : Sprite) : Void 
	{
		var offsetX : Float = calculateStartOffset(container);
		for (i in 0...container.numChildren) {
			var child = container.getChildAt(i);
			child.x = offsetX;
			child.y = 0;
			offsetX += child.width;
		}
	}
	
	// Calculate offset such that the content will be centered.
	// If the content is bigger then the container the offest will be 0.
	private function calculateStartOffset(container : Sprite) : Float
	{
		var contentWidth : Float = 0;
		for (i in 0...container.numChildren) {
			contentWidth += container.getChildAt(i).width;
		}
		
		return (contentWidth > container.width) ? 0 : container.width / 2.0 - contentWidth / 2.0;
	}
}