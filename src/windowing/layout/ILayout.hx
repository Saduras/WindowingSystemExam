package windowing.layout;
import openfl.display.Sprite;

/**
 * @author David Speck
 */

interface ILayout 
{
	// Returns a id string for each layout.
	// Can be used to identify different layout types.
	public function getId() : String;
	// Arrange the children of the given container 
	// to match the implemented layout.
	public function apply(container : ContainerWithLayout) : Void;
}