// i'mma have the songs separate in 2 different menus from here
package;

#if desktop
import Discord.DiscordClient;
#end
import editors.ChartingState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import lime.utils.Assets;
import flixel.system.FlxSound;
import openfl.utils.Assets as OpenFlAssets;
import WeekData;
#if MODS_ALLOWED
import sys.FileSystem;
#end

using StringTools;
//just a copy from FreeplayState lol

class FreeplayCategoryState extends MusicBeatState
{
        var vanillaGame:FlxSprite;
        var exclusiveShit:FlxSprite;
        var modsMusic:FlxSprite;
        var selectorBox:FlxSprite;
  
        var bg:FlxSprite;
	      public var camZooming:Bool = false;
  
        override function create()
      	{
                Paths.clearStoredMemory();
		            Paths.clearUnusedMemory();
		
		            persistentUpdate = true;

		            #if desktop
		            // Updating Discord Rich Presence
		            DiscordClient.changePresence("In Freeplay Category", null);
		            #end
                  
                bg = new FlxSprite().loadGraphic(Paths.image('menuFreeplayCate'));
		bg.antialiasing = ClientPrefs.globalAntialiasing;
                bg.color = 0xFF424d54;
		add(bg);
		bg.screenCenter();
          
                exclusiveShit = new FlxSprite().loadGraphic(Paths.image('bonusBanner'));
                exclusiveShit.antialiasing = ClientPrefs.globalAntialiasing;
                add(exclusiveShit);
          
                modsMusic = new FlxSprite().loadGraphic(Paths.image('modsMenuBanner'));
                modsMusic.antialiasing = ClientPrefs.globalAntialiasing;
                add(modsMusic);
          	
		vanillaGame = new FlxSprite().loadGraphic(Paths.image('mainGameBanner'));
                vanillaGame.antialiasing = ClientPrefs.globalAntialiasing;
                add(vanillaGame);
		
                selectorBox = new FlxSprite().loadGraphic(Paths.image('daSelecta'));
                selectorBox.antialiasing = ClientPrefs.globalAntialiasing;
                add(selectorBox);
          
                super.create();
        }
}
//We workin' on this, clearly not finished lmao
