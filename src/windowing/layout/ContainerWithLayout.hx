package windowing.layout;

import openfl.display.DisplayObject;
import openfl.display.Sprite;

/**
 * ...
 * @author David Speck
 */
class ContainerWithLayout extends Sprite
{
	var layout : ILayout;

	public function new(layout : ILayout) 
	{
		super();
		
		this.layout = layout;
	}
	
	public function setLayout(newLayout : ILayout) : Void
	{
		layout = newLayout;
		layout.apply(this);
	}
	
	// Apply layout when child list changes
	//{ override
	override public function addChild(child : DisplayObject) : DisplayObject 
	{
		var result = super.addChild(child);
		layout.apply(this);
		return result;
	}
	
	override public function addChildAt(child : DisplayObject, index : Int) : DisplayObject 
	{
		var result = super.addChildAt(child, index);
		layout.apply(this);
		return result;
	}
	
	override public function removeChild(child : DisplayObject) : DisplayObject 
	{
		var result = super.removeChild(child);
		layout.apply(this);
		return result;
	}
	
	override public function removeChildAt(index : Int) : DisplayObject 
	{
		var result = super.removeChildAt(index);
		layout.apply(this);
		return result;
	}
	
	override public function removeChildren(beginIndex : Int = 0, endIndex : Int = 0x7FFFFFFF) : Void 
	{
		super.removeChildren(beginIndex, endIndex);
		layout.apply(this);
	}
	
	override public function setChildIndex(child : DisplayObject, index : Int)  : Void
	{
		super.setChildIndex(child, index);
		layout.apply(this);
	}
	//}
}