package windowing.layout;
import openfl.display.Sprite;

/**
 * A layout implementation which doesn't overwrite the position of the content elements.
 * I.e. it's equivalent to not using a layout at all.
 * @author David Speck
 */
class FreeLayout implements ILayout
{
	public function new() { }
	
	public function getId() : String { return "FREE"; }
	
	public function apply(container : Sprite) : Void 
	{
		// Do nothing here
	}
	
}