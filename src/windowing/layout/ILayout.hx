package windowing.layout;
import flash.display.DisplayObjectContainer;

/**
 * @author David Speck
 */

interface ILayout 
{
  public var id(default, null) : String;
  
  public function apply(container : DisplayObjectContainer) : Void;
}