package windowing.layout;
import openfl.display.Sprite;

/**
 * This layout places as much elements a possible in horizontal rows
 * and centers these rows.
 * @author David Speck
 */
class HorizontalLayout implements ILayout
{
	var elementSpacing : Float;
	
	public function new(spacing : Float = 5) 
	{ 
		elementSpacing = spacing;
	}
	
	public function getId():String { return "HORIZONTAL"; }
	
	// Apply layout by arraning containers children accordently.
	public function apply(container : ContainerWithLayout) : Void 
	{
		// Count of child fitting in each row
		var rowChildCount : Array<Int> = calculateRowDistribution(container);
		
		// Max height for childs in one row
		var maxChildHeight : Float = -100;
		
		// Index of current row
		var rowIndex : Int = 0;
		// Index of first child in this row
		var rowStartIndex : Int = 0;
		
		// Offsets applied to position of the childs
		// Will be updated for each child
		var offsetX : Float = calculateStartOffsetX(container, 0, rowChildCount[rowIndex]);
		var offsetY : Float = container.containerPaddingY;
		
		for (i in 0...container.numChildren) {
			var child = container.getChildAt(i);
			
			// Set coordinates
			child.x = offsetX;
			child.y = offsetY;
			
			// Calculate offset for next child
			if (i + 1 < container.numChildren) {
				var nextChild = container.getChildAt(i + 1);
				if (i + 1 < rowChildCount[rowIndex] + rowStartIndex) {
					// Set offsets
					offsetX += nextChild.width + elementSpacing;
					
					// Update max height
					if (child.height > maxChildHeight) {
						maxChildHeight = nextChild.height;
					}
				} else {
					// Update indicies
					rowIndex++;
					rowStartIndex = i + 1;
					
					// Set offsets
					offsetX = calculateStartOffsetX(container, rowStartIndex, rowChildCount[rowIndex]);
					offsetY += maxChildHeight;
					
					// Reset max
					maxChildHeight = -100;
				}
			}
		}
	}
	
	// Calculate count of childs fitting in each row.
	// Put atleast one child in one row.
	private function calculateRowDistribution(container : ContainerWithLayout) : Array<Int>
	{
		var rows : Array<Int> = new Array<Int>();
		var j : Int = 0;
		rows[j] = 0;
		
		var sumX : Float = 0;
		for (i in 0...container.numChildren) {
			var child = container.getChildAt(i);
			// Count child to current row if row is empty or container has enough space
			if (sumX == 0 || sumX + child.width + elementSpacing < container.containerWidth - 2 * container.containerPaddingX) {
				rows[j]++;
				// Update sumX
				sumX += child.width + elementSpacing;
			} else {
				// Count child to new row
				j++;
				rows[j] = 1 ;
				// Reset sum counter
				sumX = child.width + elementSpacing;
			}
		}
		
		return rows;
	}
	
	// Calculate offset such that the content row will be centered
	private function calculateStartOffsetX(container : ContainerWithLayout, startIndex : Int, childCount : Int) : Float
	{
		var contentWidth : Float = 0;
		for (i in startIndex...(startIndex + childCount)) {
			contentWidth += container.getChildAt(i).width + elementSpacing;
		}
		
		return (container.containerWidth - container.containerPaddingX) / 2.0 - contentWidth / 2.0;
	}
}