package;

import Controls.Control;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import lime.app.Application;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.FlxCamera;
import flixel.util.FlxStringUtil;

class PauseSubState extends MusicBeatSubstate
{
	var grpMenuShit:FlxTypedGroup<Alphabet>;

	var menuItems:Array<String> = [];
	var menuItemsOG:Array<String> = ['Resume', 'Restart Song', 'Options', 'Change Difficulty', 'Exit to menu'];
	var difficultyChoices = [];
	var curSelected:Int = 0;
	var composer:String = '';
	var charter:String = '';

	var pauseMusic:FlxSound;
	var practiceText:FlxText;
	var skipTimeText:FlxText;
	var skipTimeTracker:Alphabet;
	var curTime:Float = Math.max(0, Conductor.songPosition);
	var botplayText:FlxText;

	public static var songName:String = '';

	public function new(x:Float, y:Float)
	{
		super();
		if(CoolUtil.difficulties.length < 2) menuItemsOG.remove('Change Difficulty'); //No need to change difficulty if there is only one!

		if(PlayState.chartingMode)
		{
			menuItemsOG.insert(2, 'Leave Charting Mode');
			
			var num:Int = 0;
			if(!PlayState.instance.startingSong)
			{
				num = 1;
				menuItemsOG.insert(3, 'Skip Time');
			}
			menuItemsOG.insert(3 + num, 'End Song');
			menuItemsOG.insert(4 + num, 'Toggle Practice Mode');
			menuItemsOG.insert(5 + num, 'Toggle Botplay');
		}
		menuItems = menuItemsOG;

		for (i in 0...CoolUtil.difficulties.length) {
			var diff:String = '' + CoolUtil.difficulties[i];
			difficultyChoices.push(diff);
		}
		difficultyChoices.push('BACK');


		pauseMusic = new FlxSound();
		if(songName != null) {
			pauseMusic.loadEmbedded(Paths.music(songName), true, true);
		} else if (songName != 'None') {
			pauseMusic.loadEmbedded(Paths.music(Paths.formatToSongPath(ClientPrefs.pauseMusic)), true, true);
		}
		pauseMusic.volume = 0;
		pauseMusic.play(false, FlxG.random.int(0, Std.int(pauseMusic.length / 2)));

		FlxG.sound.list.add(pauseMusic);

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0;
		bg.scrollFactor.set();
		add(bg);

		switch(PlayState.SONG.song)
				{
					case 'Atrocity':
					Application.current.window.title = "Friday Night Funkin': Demolition Engine - " + WeekData.getCurrentWeek().weekName + ": " + PlayState.SONG.song + " [" + CoolUtil.difficultyString() + "] - Composed by: Saster (Paused)";
					case 'Tutorial' | 'Bopeebo' | 'Fresh' | 'Dad Battle' | 'Spookeez' | 'South' | 'Pico' | 'Philly Nice' | 'Blammed' | 'Satin Panties' | 'High' | 'Milf' | 'Cocoa' | 'Eggnog' | 'Senpai' | 'Roses' | 'Thorns' | 'Ugh' | 'Guns' | 'Stress':
					Application.current.window.title = "Friday Night Funkin': Demolition Engine - " + WeekData.getCurrentWeek().weekName + ": " + PlayState.SONG.song + " [" + CoolUtil.difficultyString() + "] - Composed by: Kawai Sprite (Paused)";
					case 'Monster' | 'Winter Horrorland':
					Application.current.window.title = "Friday Night Funkin': Demolition Engine - " + WeekData.getCurrentWeek().weekName + ": " + PlayState.SONG.song + " [" + CoolUtil.difficultyString() + "] - Composed by: Kawai Sprite & Bassetfilms (Paused)";
					default:
					Application.current.window.title = "Friday Night Funkin': Demolition Engine - " + WeekData.getCurrentWeek().weekName + ": " + PlayState.SONG.song + " [" + CoolUtil.difficultyString() + "] (Paused)";
				}

		var levelInfo:FlxText = new FlxText(20, 15, 0, "", 32);
		levelInfo.text += PlayState.SONG.song;
		levelInfo.scrollFactor.set();
		levelInfo.setFormat(Paths.font("vcr.ttf"), 32);
		levelInfo.updateHitbox();
		add(levelInfo);

		var composerCredit:FlxText = new FlxText(20, 15 + 32, 0, "", 32);
		switch(PlayState.SONG.song)
		{
			case 'Atrocity':
			composer = 'By Saster';
			case 'Tutorial' | 'Bopeebo' | 'Fresh' | 'Dad Battle' | 'Spookeez' | 'South' | 'Pico' | 'Philly Nice' | 'Blammed' | 'Satin Panties' | 'High' | 'Milf' | 'Cocoa' | 'Eggnog' | 'Senpai' | 'Roses' | 'Thorns' | 'Ugh' | 'Guns' | 'Stress':
			composer = 'By Kawai Sprite';
			case 'Monster' | 'Winter Horrorland':
			composer = 'By Kawai Sprite & Bassetfilms';
		}
		composerCredit.text += composer;
		composerCredit.scrollFactor.set();
		composerCredit.setFormat(Paths.font('vcr.ttf'), 32);
		composerCredit.updateHitbox();
		add(composerCredit);

		var charterCredit:FlxText = new FlxText(20, 15 + 64, 0, "", 32);
		switch(PlayState.SONG.song)
		{
			case 'Atrocity':
			charter = 'Chart by DEMOLITIONDON96';
			case 'Tutorial' | 'Bopeebo' | 'Fresh' | 'Dad Battle' | 'Spookeez' | 'South' | 'Monster' | 'Pico' | 'Philly Nice' | 'Blammed' | 'Satin Panties' | 'High' | 'Milf' | 'Cocoa' | 'Eggnog' | 'Winter Horrorland' | 'Senpai' | 'Roses' | 'Thorns' | 'Ugh' | 'Guns' | 'Stress':
			charter = 'Chart by ninjamuffin99';
		}
		charterCredit.text += charter;
		charterCredit.scrollFactor.set();
		charterCredit.setFormat(Paths.font('vcr.ttf'), 32);
		charterCredit.updateHitbox();
		add(charterCredit);

		var levelDifficulty:FlxText = new FlxText(20, 15 + 96, 0, "", 32);
		levelDifficulty.text += CoolUtil.difficultyString();
		levelDifficulty.scrollFactor.set();
		levelDifficulty.setFormat(Paths.font('vcr.ttf'), 32);
		levelDifficulty.updateHitbox();
		add(levelDifficulty);

		var blueballedTxt:FlxText = new FlxText(20, 15 + 128, 0, "", 32);
		blueballedTxt.text = "Blueballed: " + PlayState.deathCounter;
		blueballedTxt.scrollFactor.set();
		blueballedTxt.setFormat(Paths.font('vcr.ttf'), 32);
		blueballedTxt.updateHitbox();
		add(blueballedTxt);

		practiceText = new FlxText(20, 15 + 162, 0, "PRACTICE MODE", 32);
		practiceText.scrollFactor.set();
		practiceText.setFormat(Paths.font('vcr.ttf'), 32);
		practiceText.x = FlxG.width - (practiceText.width + 20);
		practiceText.updateHitbox();
		practiceText.visible = PlayState.instance.practiceMode;
		add(practiceText);

		var chartingText:FlxText = new FlxText(20, 15 + 162, 0, "CHARTING MODE", 32);
		chartingText.scrollFactor.set();
		chartingText.setFormat(Paths.font('vcr.ttf'), 32);
		chartingText.x = FlxG.width - (chartingText.width + 20);
		chartingText.y = FlxG.height - (chartingText.height + 20);
		chartingText.updateHitbox();
		chartingText.visible = PlayState.chartingMode;
		add(chartingText);

		blueballedTxt.alpha = 0;
		composerCredit.alpha = 0;
		charterCredit.alpha = 0;
		levelDifficulty.alpha = 0;
		levelInfo.alpha = 0;

		levelInfo.x = FlxG.width - (levelInfo.width + 20);
		composerCredit.x = FlxG.width - (composerCredit.width + 20);
		charterCredit.x = FlxG.width - (charterCredit.width + 20);
		levelDifficulty.x = FlxG.width - (levelDifficulty.width + 20);
		blueballedTxt.x = FlxG.width - (blueballedTxt.width + 20);

		FlxTween.tween(bg, {alpha: 0.6}, 0.4, {ease: FlxEase.quartInOut});
		FlxTween.tween(levelInfo, {alpha: 1, y: 20}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.3});
		FlxTween.tween(levelDifficulty, {alpha: 1, y: levelDifficulty.y + 5}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.9});
		FlxTween.tween(composerCredit, {alpha: 1, y: composerCredit.y + 5}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.5});
		FlxTween.tween(charterCredit, {alpha: 1, y: charterCredit.y + 5}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.7});
		FlxTween.tween(blueballedTxt, {alpha: 1, y: blueballedTxt.y + 5}, 0.4, {ease: FlxEase.quartInOut, startDelay: 1.1});

		grpMenuShit = new FlxTypedGroup<Alphabet>();
		add(grpMenuShit);

		for (i in 0...menuItems.length)
		{
			var songText:Alphabet = new Alphabet(0, (70 * i) + 30, menuItems[i], true, false);
			songText.isMenuItem = true;
			songText.targetY = i;
			grpMenuShit.add(songText);
		}

		changeSelection();

		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
	}

	var holdTime:Float = 0;
	override function update(elapsed:Float)
	{
		if (pauseMusic.volume < 0.5)
			pauseMusic.volume += 0.01 * elapsed;

		super.update(elapsed);
		updateSkipTextStuff();

		var upP = controls.UI_UP_P;
		var downP = controls.UI_DOWN_P;
		var accepted = controls.ACCEPT;

		if (upP)
		{
			changeSelection(-1);
		}
		if (downP)
		{
			changeSelection(1);
		}

		var daSelected:String = menuItems[curSelected];
		switch (daSelected)
		{
			case 'Skip Time':
				if (controls.UI_LEFT_P)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
					curTime -= 1000;
					holdTime = 0;
				}
				if (controls.UI_RIGHT_P)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
					curTime += 1000;
					holdTime = 0;
				}

				if(controls.UI_LEFT || controls.UI_RIGHT)
				{
					holdTime += elapsed;
					if(holdTime > 0.5)
					{
						curTime += 45000 * elapsed * (controls.UI_LEFT ? -1 : 1);
					}

					if(curTime >= FlxG.sound.music.length) curTime -= FlxG.sound.music.length;
					else if(curTime < 0) curTime += FlxG.sound.music.length;
					updateSkipTimeText();
				}
		}

		if (accepted)
		{
			if (menuItems == difficultyChoices)
			{
				if(menuItems.length - 1 != curSelected && difficultyChoices.contains(daSelected)) {
					var name:String = PlayState.SONG.song;
					var poop = Highscore.formatSong(name, curSelected);
					PlayState.SONG = Song.loadFromJson(poop, name);
					PlayState.storyDifficulty = curSelected;
					MusicBeatState.resetState();
					FlxG.sound.music.volume = 0;
					PlayState.changedDifficulty = true;
					PlayState.chartingMode = false;
					skipTimeTracker = null;

					if(skipTimeText != null)
					{
						skipTimeText.kill();
						remove(skipTimeText);
						skipTimeText.destroy();
					}
					skipTimeText = null;
					return;
				}

				menuItems = menuItemsOG;
				regenMenu();
			}

			switch (daSelected)
			{
				case "Resume":
					switch(PlayState.SONG.song)
				{
					case 'Atrocity':
					Application.current.window.title = "Friday Night Funkin': Demolition Engine - " + WeekData.getCurrentWeek().weekName + ": " + PlayState.SONG.song + " [" + CoolUtil.difficultyString() + "] - Composed by: Saster";
					case 'Tutorial' | 'Bopeebo' | 'Fresh' | 'Dad Battle' | 'Spookeez' | 'South' | 'Pico' | 'Philly Nice' | 'Blammed' | 'Satin Panties' | 'High' | 'Milf' | 'Cocoa' | 'Eggnog' | 'Senpai' | 'Roses' | 'Thorns' | 'Ugh' | 'Guns' | 'Stress':
					Application.current.window.title = "Friday Night Funkin': Demolition Engine - " + WeekData.getCurrentWeek().weekName + ": " + PlayState.SONG.song + " [" + CoolUtil.difficultyString() + "] - Composed by: Kawai Sprite";
					case 'Monster' | 'Winter Horrorland':
					Application.current.window.title = "Friday Night Funkin': Demolition Engine - " + WeekData.getCurrentWeek().weekName + ": " + PlayState.SONG.song + " [" + CoolUtil.difficultyString() + "] - Composed by: Kawai Sprite & Bassetfilms";
					default:
					Application.current.window.title = "Friday Night Funkin': Demolition Engine - " + WeekData.getCurrentWeek().weekName + ": " + PlayState.SONG.song + " [" + CoolUtil.difficultyString() + "]";
				}
					close();
				case 'Change Difficulty':
					menuItems = difficultyChoices;
					regenMenu();
				case 'Toggle Practice Mode':
					PlayState.instance.practiceMode = !PlayState.instance.practiceMode;
					PlayState.changedDifficulty = true;
					practiceText.visible = PlayState.instance.practiceMode;
				case "Restart Song":
					restartSong();
				case "Leave Charting Mode":
					restartSong();
					PlayState.chartingMode = false;
				case 'Skip Time':
					if(curTime < Conductor.songPosition)
					{
						PlayState.startOnTime = curTime;
						restartSong(true);
					}
					else
					{
						if (curTime != Conductor.songPosition)
						{
							PlayState.instance.clearNotesBefore(curTime);
							PlayState.instance.setSongTime(curTime);
						}
						close();
					}
				case "End Song":
					close();
					PlayState.instance.finishSong(true);
				case 'Toggle Botplay':
					PlayState.instance.cpuControlled = !PlayState.instance.cpuControlled;
					PlayState.changedDifficulty = true;
					PlayState.instance.botplayTxt.visible = PlayState.instance.cpuControlled;
					PlayState.instance.botplayTxt.alpha = 1;
					PlayState.instance.botplaySine = 0;
				case "Exit to menu":
					PlayState.deathCounter = 0;
					PlayState.seenCutscene = false;
					if(PlayState.isStoryMode) {
						Application.current.window.title = "Friday Night Funkin': Demolition Engine";
						MusicBeatState.switchState(new StoryMenuState());
					} else {
						Application.current.window.title = "Friday Night Funkin': Demolition Engine";
						MusicBeatState.switchState(new FreeplayState());
					}
					PlayState.cancelMusicFadeTween();
					FlxG.sound.playMusic(Paths.music('freakyMenu'));
					PlayState.changedDifficulty = false;
					PlayState.chartingMode = false;
				case "Options":
					Application.current.window.title = "Friday Night Funkin': Demolition Engine - Settings";
					LoadingState.loadAndSwitchState(new altoptions.PauseOptionsState());
			}
		}
	}

	public static function restartSong(noTrans:Bool = false)
	{
		PlayState.instance.paused = true; // For lua
		FlxG.sound.music.volume = 0;
		PlayState.instance.vocals.volume = 0;

		if(noTrans)
		{
			FlxTransitionableState.skipNextTransOut = true;
			FlxG.resetState();
		}
		else
		{
			MusicBeatState.resetState();
		}
	}

	override function destroy()
	{
		pauseMusic.destroy();

		super.destroy();
	}

	function changeSelection(change:Int = 0):Void
	{
		curSelected += change;

		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		if (curSelected < 0)
			curSelected = menuItems.length - 1;
		if (curSelected >= menuItems.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in grpMenuShit.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));

				if(item == skipTimeTracker)
				{
					curTime = Math.max(0, Conductor.songPosition);
					updateSkipTimeText();
				}
			}
		}
	}

	function regenMenu():Void {
		for (i in 0...grpMenuShit.members.length) {
			var obj = grpMenuShit.members[0];
			obj.kill();
			grpMenuShit.remove(obj, true);
			obj.destroy();
		}

		for (i in 0...menuItems.length) {
			var item = new Alphabet(0, 70 * i + 30, menuItems[i], true, false);
			item.isMenuItem = true;
			item.targetY = i;
			grpMenuShit.add(item);

			if(menuItems[i] == 'Skip Time')
			{
				skipTimeText = new FlxText(0, 0, 0, '', 64);
				skipTimeText.setFormat(Paths.font("vcr.ttf"), 64, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
				skipTimeText.scrollFactor.set();
				skipTimeText.borderSize = 2;
				skipTimeTracker = item;
				add(skipTimeText);

				updateSkipTextStuff();
				updateSkipTimeText();
			}
		}
		curSelected = 0;
		changeSelection();
	}
	
	function updateSkipTextStuff()
	{
		if(skipTimeText == null || skipTimeTracker == null) return;

		skipTimeText.x = skipTimeTracker.x + skipTimeTracker.width + 60;
		skipTimeText.y = skipTimeTracker.y;
		skipTimeText.visible = (skipTimeTracker.alpha >= 1);
	}

	function updateSkipTimeText()
	{
		skipTimeText.text = FlxStringUtil.formatTime(Math.max(0, Math.floor(curTime / 1000)), false) + ' / ' + FlxStringUtil.formatTime(Math.max(0, Math.floor(FlxG.sound.music.length / 1000)), false);
	}
}
