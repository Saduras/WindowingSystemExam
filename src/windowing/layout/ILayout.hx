package windowing.layout;
import openfl.display.Sprite;

/**
 * @author David Speck
 */

interface ILayout 
{
  public function getId() : String;
  
  public function apply(container : Sprite) : Void;
}