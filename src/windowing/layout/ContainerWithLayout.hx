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
	// Selected layout
	var layout : ILayout;
	
	// Container size
	public var containerWidth : Float;
	public var containerHeight : Float;
	
	// Container padding
	public var containerPaddingX : Float = 5;
	public var containerPaddingY : Float = 5;

	public function new(layout : ILayout, width : Float, height : Float) 
	{
		super();
		
		// Initial set layout
		this.layout = layout;
		
		// Assign width & height
		this.containerWidth = width;
		this.containerHeight = height;
	}
	
	// Change layout of this container and update the arrangemengt
	public function setLayout(newLayout : ILayout) : Void
	{
		layout = newLayout;
		applyLayout();
	}
	
	// Apply layout to children in this container
	public function applyLayout() : Void
	{
		layout.apply(this);
	}
	
	// Apply layout when child list changes
	//{ override
	override public function addChild(child : DisplayObject) : DisplayObject 
	{
		var result = super.addChild(child);
		applyLayout();
		return result;
	}
	
	override public function addChildAt(child : DisplayObject, index : Int) : DisplayObject 
	{
		var result = super.addChildAt(child, index);
		applyLayout();
		return result;
	}
	
	override public function removeChild(child : DisplayObject) : DisplayObject 
	{
		var result = super.removeChild(child);
		applyLayout();
		return result;
	}
	
	override public function removeChildAt(index : Int) : DisplayObject 
	{
		var result = super.removeChildAt(index);
		applyLayout();
		return result;
	}
	
	override public function removeChildren(beginIndex : Int = 0, endIndex : Int = 0x7FFFFFFF) : Void 
	{
		super.removeChildren(beginIndex, endIndex);
		applyLayout();
	}
	
	override public function setChildIndex(child : DisplayObject, index : Int)  : Void
	{
		super.setChildIndex(child, index);
		applyLayout();
	}
	//}
}