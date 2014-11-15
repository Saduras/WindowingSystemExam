package ;

import basicUI.Button;
import basicUI.OutputField;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.events.MouseEvent;
import openfl.text.TextField;
import windowing.layout.NoneLayout;
import windowing.layout.HorizontalLayout;
import windowing.layout.VerticalLayout;
import windowing.Window;
import windowing.Screen;
import basicUI.InputField;
import openfl.Assets;

/**
 * Main class to demonstrate windowing system.
 * @author David Speck
 */

class Main extends Sprite 
{
	var inited : Bool;
	var screen : Screen;

	/* ENTRY POINT */
	
	function resize(e) 
	{
		if (!inited) {
			init();
		}
		else if (screen != null) {			
			// Scale screen instance
			screen.screenWidth = stage.stageWidth;
			screen.screenHeight = stage.stageHeight;
			screen.arrangeMinimizedWindows();
		}
	}
	
	function init() 
	{
		if (inited) return;
		inited = true;
		
		screen = new Screen(stage.stageWidth, stage.stageHeight);
		stage.addChild(screen);
		
		// Define some buttons for examples and tests
		var buttons : List<Button> = new List<Button>();
		
		var horizontalWindowButton = new Button("Create window with horizontal layout", 200.0, 20.0);
		horizontalWindowButton.addEventListener(MouseEvent.CLICK, createHorizontalWindow);
		buttons.add(horizontalWindowButton);
		
		var verticalWindowButton = new Button("Create window with vertical layout", 200.0, 20.0);
		verticalWindowButton.addEventListener(MouseEvent.CLICK, createVerticalWindow);
		buttons.add(verticalWindowButton);
		
		var noneWindowButton = new Button("Create window with none layout", 200.0, 20.0);
		noneWindowButton.addEventListener(MouseEvent.CLICK, createNoneWindow);
		buttons.add(noneWindowButton);
		
		var formWindowButton = new Button("Create window with form", 200.0, 20.0);
		formWindowButton.addEventListener(MouseEvent.CLICK, createFormWindow);
		buttons.add(formWindowButton);
		
		var imageWindowButton = new Button("Create window with image", 200.0, 20.0);
		imageWindowButton.addEventListener(MouseEvent.CLICK, createImageWindow);
		buttons.add(imageWindowButton);
		
		// Add buttons to stage, arrange and draw them
		var offsetY : Float = 5;
		for (btn in buttons) {
			btn.x = 5;
			btn.y = offsetY;
			btn.draw();
			stage.addChild(btn);
			
			offsetY += 25;
		}
	}

	//{ Setup

	public function new() 
	{
		super();	
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
	}
	
	public static function main() 
	{
		// static entry point
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}
	//}

	//{ Button handler
	
	// Simple window to demonstrate horizontal layout inside a window.
	private function createHorizontalWindow(e : Event) : Void
	{
		var window = screen.createWindow("Window horizontal layout", new HorizontalLayout(5));
		window.moveTo(100.0, 100.0);
		
		for (i in 0...10) 
		{
			var btn : Button = new Button("Button " + i, 50.0, 20.0);
			btn.draw();
			window.content.addChild(btn);
		}
	}
	
	// Simple window to demonstrate vertical layout inside a window.
	private function createVerticalWindow(e : Event) : Void
	{
		var window = screen.createWindow("Window vertical layout", new VerticalLayout(5.0));
		window.moveTo(100.0, 100.0);
		
		for (i in 0...10) 
		{
			var btn : Button = new Button("Button " + i, 50.0, 20.0);
			btn.draw();
			window.content.addChild(btn);
		}
	}
	
	// Create window to demostrate none layout. Place children randomly inside the window.
	private function createNoneWindow(e : Event) : Void
	{
		var window = screen.createWindow("Window none layout", new NoneLayout());
		window.moveTo(100.0, 100.0);
		
		for (i in 0...10) 
		{
			var btn : Button = new Button("Button " + i, 50.0, 20.0);
			// Place button at random coordinates inside the window
			btn.x = Math.random() * (window.windowWidth - btn.buttonWidth);
			btn.y = Math.random() * (window.windowHeight - btn.buttonHeight - window.titleBar.titlebarHeight);
			btn.draw();
			window.content.addChild(btn);
		}
	}
	
	// Create window example with simple form with validation.
	private function createFormWindow(e : Event) : Void
	{
		var window = screen.createWindow("Form window", new VerticalLayout(5.0));
		
		window.moveTo(40, 40);
		
		// Add a simple form to window one
		var formController = new FormController();
		
		var nameInput = new InputField("Name:", "text");
		window.content.addChild(nameInput);
		formController.addInputField(nameInput);
		
		var addressInput = new InputField("Address:", "address");
		window.content.addChild(addressInput);
		formController.addInputField(addressInput);
		
		var ageInput = new InputField("Age:", "number");
		window.content.addChild(ageInput);
		formController.addInputField(ageInput);
		
		var heightInput = new InputField("Height:", "float");
		window.content.addChild(heightInput);
		formController.addInputField(heightInput);
		
		var output = new OutputField(250.0, 260.0, 22.0);
		window.content.addChild(output);
		formController.setOutputField(output);
		
		var submitButton = new Button("Submit", 120.0, 20.0);
		window.content.addChild(submitButton);
		submitButton.draw();
		submitButton.addEventListener(MouseEvent.CLICK, function(e : Event) {
			formController.submit();
		});
	}
	
	// Create a example window with a image inside
	private function createImageWindow(e : MouseEvent) : Void 
	{
		// Create window
		var window = screen.createWindow("Window none layout", new NoneLayout());
		window.moveTo(200.0, 200.0);
		
		// Load image from assets
		var bitmapData : BitmapData = Assets.getBitmapData("img/content_protection.png");
		var img : Bitmap = new Bitmap(bitmapData);
		
		// Add image to window content
		window.content.addChild(img);
		// Scale window such that it fits the image.
		window.setWidth(img.width + 10);
		window.setHeight(img.height + 62);
		
		// Center image
		img.x = window.content.containerWidth / 2.0 - img.width / 2.0;
		img.y = (window.content.containerHeight - 30) / 2.0 - img.height / 2.0;
		
		// Add a caption
		var caption : TextField = new TextField();
		caption.text = "Source: http://xkcd.com/129/";
		caption.width = caption.textWidth * 1.05;
		window.content.addChild(caption);
		// Place caption centered below image
		caption.x = window.content.containerWidth / 2.0 - caption.width / 2.0;
		caption.y = img.y + img.height + 5;
	}
	//}
}
