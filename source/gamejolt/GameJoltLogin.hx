package gamejolt;

import flixel.ui.FlxButton;
import flixel.text.FlxText;
import flixel.addons.ui.FlxUIInputText;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.ui.FlxBar;
import flixel.FlxG;
import lime.system.System;

using StringTools;

class GameJoltLogin extends MusicBeatState
{
    var gamejoltText1:FlxText;
    var gamejoltText2:FlxText;
    var loginTexts:FlxTypedGroup<FlxText>;
    var loginBoxes:FlxTypedGroup<FlxUIInputText>;
    var loginButtons:FlxTypedGroup<FlxButton>;
    var usernameText:FlxText;
    var tokenText:FlxText;
    var usernameBox:FlxUIInputText;
    var tokenBox:FlxUIInputText;
    var signInBox:FlxButton;
    var helpBox:FlxButton;
    var logOutBox:FlxButton;
    var cancelBox:FlxButton;
    var username1:FlxText;
    var username2:FlxText;
    var baseX:Int = -190;
    var versionText:FlxText;
    var funnyText:FlxText;

    public static var login:Bool = false;
    public static var boyfriend:Character;

    override function create()
    {
        if(!login)
        {
            FlxG.sound.playMusic(Paths.music('freakyMenu'),0);
            FlxG.sound.music.fadeIn(2, 0, 0.85);
        }

        trace(FlxGameJolt.initialized);
        FlxG.mouse.visible = true;

        Conductor.changeBPM(102);
        
        var bg:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('menuDesat'));
        bg.setGraphicSize(FlxG.width);
        bg.antialiasing = ClientPrefs.globalAntialiasing;
        bg.updateHitbox();
        bg.screenCenter();
        bg.scrollFactor.set();
        bg.color = FlxColor.fromHSB(FlxG.random.int(0, 359), FlxG.random.float(0, 0.8), FlxG.random.float(0.3, 1));
        add(bg);

        boyfriend = new Character(840, 170, 'bf', true);
        boyfriend.setGraphicSize(Std.int(boyfriend.width * 0.75));
        boyfriend.updateHitbox();
        boyfriend.dance();
        add(boyfriend);

        gamejoltText1 = new FlxText(0, 25, 0, "GameJolt + FNF Integration", 16);
        gamejoltText1.screenCenter(X);
        gamejoltText1.x += baseX;
        gamejoltText1.color = FlxColor.fromRGB(84,155,149);
        add(gamejoltText1);

        gamejoltText2 = new FlxText(0, 45, 0, Date.now().toString(), 16);
        gamejoltText2.screenCenter(X);
        gamejoltText2.x += baseX;
        gamejoltText2.color = FlxColor.fromRGB(84,155,149);
        add(gamejoltText2);

        funnyText = new FlxText(5, FlxG.height - 40, 0, GameJoltInfo.textArray[FlxG.random.int(0, GameJoltInfo.textArray.length - 1)]+ " -Tenta", 12);
        add(funnyText);

        versionText = new FlxText(5, FlxG.height - 22, 0, "Game ID: " + GameJoltKeys.id + " API: " + GameJoltInfo.version, 12);
        add(versionText);

        loginTexts = new FlxTypedGroup<FlxText>(2);
        add(loginTexts);

        usernameText = new FlxText(0, 125, 300, "Username:", 20);

        tokenText = new FlxText(0, 225, 300, "Token: (Not PW)", 20);

        loginTexts.add(usernameText);
        loginTexts.add(tokenText);
        loginTexts.forEach(function(item:FlxText){
            item.screenCenter(X);
            item.x += baseX;
            item.font = GameJoltInfo.font;
        });

        loginBoxes = new FlxTypedGroup<FlxUIInputText>(2);
        add(loginBoxes);

        usernameBox = new FlxUIInputText(0, 175, 300, null, 32, FlxColor.BLACK, FlxColor.GRAY);
        #if android
        usernameBox.focusGained = () -> FlxG.stage.window.textInputEnabled = true;
        #end
        
        tokenBox = new FlxUIInputText(0, 275, 300, null, 32, FlxColor.BLACK, FlxColor.GRAY);
        #if android
        tokenBox.focusGained = () -> FlxG.stage.window.textInputEnabled = true;
        #end

        loginBoxes.add(usernameBox);
        loginBoxes.add(tokenBox);
        loginBoxes.forEach(function(item:FlxUIInputText){
            item.screenCenter(X);
            item.x += baseX;
            item.font = GameJoltInfo.font;
        });

        if(GameJoltAPI.getStatus())
        {
            remove(loginTexts);
            remove(loginBoxes);
        }

        loginButtons = new FlxTypedGroup<FlxButton>(3);
        add(loginButtons);

        signInBox = new FlxButton(0, 475, "Sign In", function()
        {
            trace(usernameBox.text);
            trace(tokenBox.text);
            GameJoltAPI.authDaUser(usernameBox.text,tokenBox.text,true);
        });

        helpBox = new FlxButton(0, 550, "GameJolt Token", function()
        {
            if (!GameJoltAPI.getStatus())openLink('https://www.youtube.com/watch?v=T5-x7kAGGnE');
            else
                {
                    GameJoltAPI.leaderboardToggle = !GameJoltAPI.leaderboardToggle;
                    trace(GameJoltAPI.leaderboardToggle);
                    FlxG.save.data.lbToggle = GameJoltAPI.leaderboardToggle;
                    Main.gjToastManager.createToast(GameJoltInfo.imagePath, "Score Submitting", "Score submitting is now " + (GameJoltAPI.leaderboardToggle ? "Enabled":"Disabled"), false);
                }
        });
        helpBox.color = FlxColor.fromRGB(84,155,149);

        logOutBox = new FlxButton(0, 625, "Log Out & Close", function()
        {
            GameJoltAPI.deAuthDaUser();
        });
        logOutBox.color = FlxColor.RED /*FlxColor.fromRGB(255,134,61)*/ ;

        cancelBox = new FlxButton(0,625, "Not Right Now", function()
        {
            FlxG.save.flush();
            FlxG.sound.play(Paths.sound('confirmMenu'), 0.7, false, null, true, function(){
                FlxG.save.flush();
                FlxG.sound.music.stop();
                MusicBeatState.switchState(new options.OptionsState());
            });
        });

        if(!GameJoltAPI.getStatus())
        {
            loginButtons.add(signInBox);
        }
        else
        {
            cancelBox.y = 475;
            cancelBox.text = "Continue";
            loginButtons.add(logOutBox);
        }
        loginButtons.add(helpBox);
        loginButtons.add(cancelBox);

        loginButtons.forEach(function(item:FlxButton){
            item.screenCenter(X);
            item.setGraphicSize(Std.int(item.width) * 3);
            item.x += baseX;
        });

        if(GameJoltAPI.getStatus())
        {
            username1 = new FlxText(0, 95, 0, "Signed in as:", 40);
            username1.alignment = CENTER;
            username1.screenCenter(X);
            username1.x += baseX;
            add(username1);

            username2 = new FlxText(0, 145, 0, "" + GameJoltAPI.getUserInfo(true) + "", 40);
            username2.alignment = CENTER;
            username2.screenCenter(X);
            username2.x += baseX;
            add(username2);
        }

        if(GameJoltInfo.font != null)
        {       
            // Stupid block of code >:(
            gamejoltText1.font = GameJoltInfo.font;
            gamejoltText2.font = GameJoltInfo.font;
            funnyText.font = GameJoltInfo.font;
            versionText.font = GameJoltInfo.font;
            username1.font = GameJoltInfo.font;
            username2.font = GameJoltInfo.font;
            loginBoxes.forEach(function(item:FlxUIInputText){
                item.font = GameJoltInfo.font;
            });
            loginTexts.forEach(function(item:FlxText){
                item.font = GameJoltInfo.font;
            });
        }
    }

    override function update(elapsed:Float)
    {
        gamejoltText2.text = Date.now().toString();

        if (GameJoltAPI.getStatus())
        {
            helpBox.text = "Leaderboards:\n" + (GameJoltAPI.leaderboardToggle ? "Enabled" : "Disabled");
            helpBox.color = (GameJoltAPI.leaderboardToggle ? FlxColor.GREEN : FlxColor.RED);
        }

        if (FlxG.sound.music != null)
            Conductor.songPosition = FlxG.sound.music.time;

        if (!FlxG.sound.music.playing)
        {
            FlxG.sound.playMusic(Paths.music('freakyMenu'));
        }

        if (FlxG.keys.justPressed.ESCAPE #if android || FlxG.android.justReleased.BACK #end)
        {
            FlxG.save.flush();
            FlxG.mouse.visible = false;
            MusicBeatState.switchState(new options.OptionsState());
        }

        if(boyfriend != null && boyfriend.animation.curAnim.finished) {
            if (!GameJoltAPI.getStatus())
            {
                boyfriend.animation.play('idle');
            }
            else
            {
                boyfriend.animation.play('hey');
            }
        }

        super.update(elapsed);
    }

    function openLink(url:String)
    {
        #if linux
        Sys.command('/usr/bin/xdg-open', [url, "&"]);
        #else
        FlxG.openURL(url);
        #end
    }
}