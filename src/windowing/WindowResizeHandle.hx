package windowing;
import openfl.events.MouseEvent;
import openfl.display.Sprite;

/**
 * Resize handle view. Resize logic is handled by WindowController.
 * Is core component of window.
 * @author David Speck
 */
class WindowResizeHandle extends Sprite
{
	// Colors used to draw handle icon.
	public var backgroundColor : Int = 0x666666;
	public var lineColor : Int = 0xdddddd;
	
	// Size of the icon.
	public var handleSize : Float = 16;

	public function new() 
	{
		super();
	}
	
	// Draw a rippled triangle for the bottom right corner.
	public function draw() : Void
	{
		graphics.clear();
		
		// Draw background triangle
		graphics.beginFill(backgroundColor);
		graphics.moveTo(0, handleSize);
		graphics.lineTo(handleSize, 0);
		graphics.lineTo(handleSize, handleSize);
		graphics.lineTo(0, handleSize);
		graphics.endFill();
		
		// Offsets for the starting points at the bottom line
		var lineOffsetX : Float = handleSize / 4.0;
		var lineOffsetY : Float = handleSize - handleSize / 10.0;
		// Draw lines perpendicular to {x = y}
		graphics.lineStyle(1.0, lineColor);
		// Line 1
		graphics.moveTo(1 * lineOffsetX, lineOffsetY);
		graphics.lineTo(lineOffsetY, 1 * lineOffsetX);
		// Line 2
		graphics.moveTo(2 * lineOffsetX, lineOffsetY);
		graphics.lineTo(lineOffsetY, 2 * lineOffsetX);
		// Line 3
		graphics.moveTo(3 * lineOffsetX, lineOffsetY);
		graphics.lineTo(lineOffsetY, 3 * lineOffsetX);
	}
}