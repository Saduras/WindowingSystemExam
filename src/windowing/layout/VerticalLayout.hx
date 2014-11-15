package windowing.layout;
import openfl.display.Sprite;

/**
 * This layout places as much elements a possible in vertical columns
 * and centers these columns.
 * @author David Speck
 */
class VerticalLayout implements ILayout
{
	var elementSpacing : Float;
	
	public function new(spacing : Float = 5) 
	{ 
		elementSpacing = spacing;
	}
	
	public function getId():String { return "VERTICAL"; }
	
	// Apply layout by arraning containers children accordently.
	public function apply(container : ContainerWithLayout) : Void 
	{
		// Count of child fitting in each column
		var columnChildCount : Array<Int> = calculateColumnDistribution(container);
		
		// Max height for childs in one column
		var maxChildWidth : Float = -100;
		
		// Index of current row
		var columnIndex : Int = 0;
		// Index of first child in this column
		var columnStartIndex : Int = 0;
		
		// Offsets applied to position of the childs
		// Will be updated for each child
		var offsetX : Float = container.containerPaddingX;
		var offsetY : Float = calculateStartOffsetY(container, 0, columnChildCount[columnIndex]);
		
		for (i in 0...container.numChildren) {
			var child = container.getChildAt(i);
			
			// Set coordinates
			child.x = offsetX;
			child.y = offsetY;
			
			// Calculate offset for next child
			if (i + 1 < container.numChildren) {
				var nextChild = container.getChildAt(i + 1);
				if (i + 1 < columnChildCount[columnIndex] + columnStartIndex) {
					// Set offsets
					offsetY += nextChild.height + elementSpacing;
					
					// Update max width
					if (child.width > maxChildWidth) {
						maxChildWidth = nextChild.width;
					}
				} else {
					// Update indicies
					columnIndex++;
					columnStartIndex = i + 1;
					
					// Set offsets
					offsetX += maxChildWidth;
					offsetY = calculateStartOffsetY(container, columnStartIndex, columnChildCount[columnIndex]);
					
					// Reset max
					maxChildWidth = -100;
				}
			}
		}
	}
	
	// Calculate count of childs fitting in each column.
	// Put atleast one child in one column.
	private function calculateColumnDistribution(container : ContainerWithLayout) : Array<Int>
	{
		var columns : Array<Int> = new Array<Int>();
		var j : Int = 0;
		columns[j] = 0;
		
		var sumY : Float = 0;
		for (i in 0...container.numChildren) {
			var child = container.getChildAt(i);
			// Count child to current row if row is empty or container has enough space
			if (sumY == 0 || sumY + child.height + elementSpacing < container.containerHeight - 2 * container.containerPaddingY) {
				columns[j]++;
				// Update sumX
				sumY += child.height + elementSpacing;
			} else {
				// Count child to new row
				j++;
				columns[j] = 1 ;
				// Reset sum counter
				sumY = child.height + elementSpacing;
			}
		}
		
		return columns;
	}
	
	// Calculate offset such that the content column will be centered
	private function calculateStartOffsetY(container : ContainerWithLayout, startIndex : Int, childCount : Int) : Float
	{
		var contentHeight : Float = 0;
		for (i in startIndex...(startIndex + childCount)) {
			contentHeight += container.getChildAt(i).height + elementSpacing;
		}
		
		return (container.containerHeight - container.containerPaddingY) / 2.0 - contentHeight / 2.0;
	}
}