package windowing.layout;

import openfl.display.DisplayObject;
import openfl.display.Sprite;

/**
 * A display container with a layout assigned. Every time the layout is updated, all children of this container
 * will be arranged according to this layout. If the children list changes the layout will be updated automaticly.
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
		updateLayout();
	}
	
	public function updateLayout() : Void
	{
		layout.apply(this);
	}
	
	// Apply layout when child list changes
	//{ override
	override public function addChild(child : DisplayObject) : DisplayObject 
	{
		var result = super.addChild(child);
		updateLayout();
		return result;
	}
	
	override public function addChildAt(child : DisplayObject, index : Int) : DisplayObject 
	{
		var result = super.addChildAt(child, index);
		updateLayout();
		return result;
	}
	
	override public function removeChild(child : DisplayObject) : DisplayObject 
	{
		var result = super.removeChild(child);
		updateLayout();
		return result;
	}
	
	override public function removeChildAt(index : Int) : DisplayObject 
	{
		var result = super.removeChildAt(index);
		updateLayout();
		return result;
	}
	
	override public function removeChildren(beginIndex : Int = 0, endIndex : Int = 0x7FFFFFFF) : Void 
	{
		super.removeChildren(beginIndex, endIndex);
		updateLayout();
	}
	
	override public function setChildIndex(child : DisplayObject, index : Int)  : Void
	{
		super.setChildIndex(child, index);
		updateLayout();
	}
	//}
}