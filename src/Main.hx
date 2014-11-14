package ;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
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
		
		// Add some stuff
		var addressInput = new InputField("Address:", "address", "This where its snake house is placed");
		win1.content.addChild(addressInput);
		addressInput.x = 20;
		addressInput.y = 35;
		
		var speedInput = new InputField("Speed:", "float", "This tells how fast the snake travels on the grid");
		win1.content.addChild(speedInput);
		speedInput.x = 25;
		speedInput.y = 55;
		
		var nameInput = new InputField("Name:", "text", "The most important fucking property!!! The name of the snake! Choose wisly!");
		win1.content.addChild(nameInput);
		nameInput.x = 120;
		nameInput.y = 55;
		
		
		
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
