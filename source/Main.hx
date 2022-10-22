package;

import flixel.graphics.FlxGraphic;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxState;
import openfl.Assets;
import openfl.Lib;
import openfl.display.FPS;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.display.StageScaleMode;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
//crash handler stuff
import lime.app.Application;
import openfl.events.UncaughtErrorEvent;
import haxe.CallStack;
import haxe.io.Path;
import Discord.DiscordClient;
import sys.FileSystem;
import sys.io.File;
import sys.io.Process;
import flixel.input.mouse.FlxMouse;

class Main extends Sprite
{
	var gameWidth:Int = 1280; // Width of the game in pixels (might be less / more in actual pixels depending on your zoom).
	var gameHeight:Int = 720; // Height of the game in pixels (might be less / more in actual pixels depending on your zoom).
	var initialState:Class<FlxState> = TitleState; // The FlxState the game starts with.
	var zoom:Float = -1; // If -1, zoom is automatically calculated to fit the window dimensions.
	var framerate:Int = 240; // How many frames per second the game should run at.
	var skipSplash:Bool = true; // Whether to skip the flixel splash screen that appears in release mode.
	var startFullscreen:Bool = false; // Whether to start the game in fullscreen on desktop targets
	public static var fpsVar:FPS;
	
	public static var focusMusicTween:FlxTween;

	// You can pretty much ignore everything from here on - your code should go in your states.

	public static function main():Void
	{
		Lib.current.addChild(new Main());
	}

	public function new()
	{
		super();

		if (stage != null)
		{
			init();
		}
		else
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
	}

	private function init(?E:Event):Void
	{
		if (hasEventListener(Event.ADDED_TO_STAGE))
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}

		setupGame();
	}

	private function setupGame():Void
	{
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;

		var res = ClientPrefs.screenRes.split('x');
		gameWidth = Std.parseInt(res[0]);
		gameHeight = Std.parseInt(res[1]);

		if (zoom == -1)
		{
			var ratioX:Float = stageWidth / gameWidth;
			var ratioY:Float = stageHeight / gameHeight;
			zoom = Math.min(ratioX, ratioY);
			gameWidth = Math.ceil(stageWidth / zoom);
			gameHeight = Math.ceil(stageHeight / zoom);
		}

		#if !debug
		initialState = TitleState;
		#end
	
		ClientPrefs.loadDefaultKeys();
		addChild(new FlxGame(gameWidth, gameHeight, initialState, zoom, framerate, framerate, skipSplash, startFullscreen));

		#if !mobile
		fpsVar = new FPS(10, 3, 0xFFFFFF);
		addChild(fpsVar);
		Lib.current.stage.align = "tl";
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
		if(fpsVar != null) {
			fpsVar.visible = ClientPrefs.showFPS;
		}
		#end

		FlxG.autoPause = false;
		FlxG.mouse.visible = false;
	}
	
	var game:FlxGame;
	var oldVol:Float = 1.0;
	var newVol:Float = 0.3;

	public static var focused:Bool = true;

	// funi Indie Cross volume code
	function onWindowFocusOut()
		{
			focused = false;
	
			// Lower global volume when unfocused
			if (Type.getClass(FlxG.state) != PlayState)
			{
				oldVol = FlxG.sound.volume;
				if (oldVol > 0.3)
				{
					newVol = 0.3;
				}
				else
				{
					if (oldVol > 0.1)
					{
						newVol = 0.1;
					}
					else
					{
						newVol = 0;
					}
				}
	
				trace("Game unfocused");
	
				if (focusMusicTween != null)
					focusMusicTween.cancel();
				focusMusicTween = FlxTween.tween(FlxG.sound, {volume: newVol}, 0.5);
	
				// Conserve power by lowering draw framerate when unfocuced
				FlxG.drawFramerate = 60;
				FlxG.updateFramerate = 60;
			}
		}

		public function onResize(width:Int, height:Int) {
			FlxG.resizeWindow(width, height);
		}
	
		function onWindowFocusIn()
		{
			new FlxTimer().start(0.2, function(tmr:FlxTimer)
			{
				focused = true;
			});
	
			// Lower global volume when unfocused
			if (Type.getClass(FlxG.state) != PlayState)
			{
				trace("Game focused");
	
				// Normal global volume when focused
				if (focusMusicTween != null)
					focusMusicTween.cancel();
	
				focusMusicTween = FlxTween.tween(FlxG.sound, {volume: oldVol}, 0.5);
	
				// Bring framerate back when focused
				FlxG.drawFramerate = 60;
				FlxG.updateFramerate = 60;
			}
		}
}
