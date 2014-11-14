package windowing.layout;
import flash.display.DisplayObjectContainer;

/**
 * @author David Speck
 */

interface ILayout 
{
  public function getId() : String;
  
  public function apply(container : DisplayObjectContainer) : Void;
}