package ;

import basicUI.Button;
import basicUI.OutputField;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import openfl.events.MouseEvent;
import windowing.Window;
import windowing.Screen;
import basicUI.InputField;

/**
 * ...
 * @author David Speck
 */

class Main extends Sprite 
{
	var inited:Bool;

	/* ENTRY POINT */
	
	function resize(e) 
	{
		if (!inited) init();
		// else (resize or orientation change)
	}
	
	function init() 
	{
		if (inited) return;
		inited = true;

		// (your code here)
		
		// Stage:
		// stage.stageWidth x stage.stageHeight @ stage.dpiScale
		
		// Assets:
		// nme.Assets.getBitmapData("img/assetname.jpg");
		
		var screen = new Screen(stage.stageWidth, stage.stageHeight);
		var win1 = screen.createWindow("First window");
		var win2 = screen.createWindow("Secound window");
		
		win1.moveTo(40, 40);
		win2.moveTo(100, 200);
		
		// Add a simple form to window one
		var formController = new FormController();
		var addressInput = new InputField("Address:", "address", "Physical address of the person.");
		win1.content.addChild(addressInput);
		addressInput.x = 20;
		addressInput.y = 30;
		formController.addInputField(addressInput);
		
		var ageInput = new InputField("Age:", "number", "Age of the person in years");
		win1.content.addChild(ageInput);
		ageInput.x = 30;
		ageInput.y = 80;
		formController.addInputField(ageInput);
		
		var nameInput = new InputField("Name:", "text", "Name of the person.");
		win1.content.addChild(nameInput);
		nameInput.x = 35;
		nameInput.y = 130;
		formController.addInputField(nameInput);
		
		var output = new OutputField(300.0, 400.0, 30.0);
		win1.content.addChild(output);
		output.x = 20;
		output.y = 180;
		formController.setOutputField(output);
		
		var submitButton = new Button("Submit", 120.0, 20.0);
		win1.content.addChild(submitButton);
		submitButton.draw();
		submitButton.x = 40;
		submitButton.y = 230;
		submitButton.addEventListener(MouseEvent.CLICK, function(e : Event) {
			formController.submit();
		});
		
		stage.addChild(screen);
	}

	/* SETUP */

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
}
