package options;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;

using StringTools;

class DemoSubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Demo Settings Menu';
		rpcTitle = 'Demo Settings Menu'; //for Discord Rich Presence

		//bedrock can kiss my ass XD
		var option:Option = new Option('Rating System:',
		    "What should your Rating System be?", 
			'ratingSystem', 
			'string', 
			'Bedrock',
			['Bedrock', 'Psych', 'Forever', 'Andromeda', "Etterna", 'Mania', "None"]);
		addOption(option);
		
			var option:Option = new Option('Kade Engine Input System',
			'If checked, KE input system will be on, this will not effect the rating system',
			'keAccuracy',
			'bool',
			false);
		addOption(option);
		
		var option:Option = new Option('Hide Judgement Counter',
			'If checked, hides Judgement Counter on the screen',
			'hideJudgement',
			'bool',
			false);
		addOption(option);

		var option:Option = new Option('Enable Anti Mash',
		"If Checked, Anti Mash Is Enabled IDK WHAT THIS DOES\nITS BEEN 10 FUCKING YEARS PLZ\nDEMO LET ME OUT :(",
		'antiMash',
		'bool',
		true);
		addOption(option);

		var option:Option = new Option('Enable Lane Underlay', //Stolen from DAB
		'Check for a underlay behind the notes',
		'laneunderlay',
		'bool',
		true);
		addOption(option);
		
		var option:Option = new Option('Lane Underlay',
		'Set lane underlay (Lane underlay must be enabled)',
		'laneTransparency',
		'float',
		0);
		option.minValue = 0;
		option.maxValue = 1;
		option.changeValue = 0.1;
		addOption(option);

		var option:Option = new Option('Marvelouses Rating',
		'If checked, marvelouses rating will appear on the\nJudgment counter and will show\n when hit',
		'marvelouses',
		'bool',
		true); //Default value
		addOption(option);

		var option:Option = new Option('Winning Icons',
			'If checked, enables extra icon frames',
			'winningIcon',
			'bool',
			true);
		//addOption(option);

		var option:Option = new Option('Enable Funky Lights',
			'If checked, Funky Lights Will Play Each Hit',
			'funkyLights',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Icon Bounce:',
			'How should your icons bounce?',
			'iconBounce',
			'string',
			'Default',
			['Default', 'Golden Apple', 'None']);
		addOption(option);

		var option:Option = new Option('Judgement Skin:', 
		"What should your judgements look like?", 
		'uiSkin', 
		'string', 
		'Demolition',
			['Demolition', 'Classic', 'BEAT!', 'BEAT! Gradient', 'Bedrock', 'Matt :)']);
		addOption(option);
		
		var option:Option = new Option('Simplify Score Text',
			"If checked, Score Text under the Health Bar \ndisplays less text",
			'simplifiedScore',
			'bool',
		        false);
		addOption(option);

		var option:Option = new Option('Camera Movement',
			'If checked, camera moves to the corresponding note.',
			'camMove',
			'bool',
		   	true);
		addOption(option);

		var option:Option = new Option('Health Drain',
			'How much the player should loose with health?',
			'healthDrain',
			'string',
		    '10%',
			['0%', '10%', '20%', '30%', '40%', '50%']);
		addOption(option);

		var option:Option = new Option('FreePlay Type',
			'What Should The FreePlay Be',
			'itemType',
			'string',
		    'Classic',
			['Classic', 'Vertical', 'C-Shape', 'D-Shape']);
		addOption(option);

	    var option:Option = new Option('Long Health Bar',
			"If unchecked, the health bar will be short.",
			'longBar',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Show Watermarks',
			"If unchecked, hides engine watermarks from the bottom left corner.", 
			'showWatermarks', 
			'bool', 
			true);
		addOption(option);

		var option:Option = new Option('Toggle Shaders',
			'If checked, you will see some cool visuals.\n(TURN THIS OFF IF YOUR DEVICE CRASHES WITH SHADERS ON)',
			'funiShaders',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Enable Screen Shake',
			'If checked, the screen will shake, Reccomend to turn off due to i belive elipisity??',
			'screenShake',
			'bool',
			true);
		addOption(option);

		super();
	}
}
