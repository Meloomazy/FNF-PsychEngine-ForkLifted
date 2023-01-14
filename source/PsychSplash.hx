package;

import flixel.util.FlxColor;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import openfl.utils.Assets as OpenFlAssets;
#if VIDEOS_ALLOWED
import vlc.MP4Handler;
#end

#if sys
import sys.FileSystem;
import sys.io.File;
#end

using StringTools;

class PsychSplash extends FlxState
{

    var splash:FlxSprite;
    var splashT:FlxSprite;
    var thestate:FlxState = new TitleState();
    var randomSplash:FlxText;
    var skipSplash:FlxText;
    var raresplash:Bool;

    var unfunnyVideos:Array<String> = [
    'mrbreast',
    'sex'];
    // i love psych engine community server
    var therandomText:Array<String> = [
    "'burp'  - Ache",
    "'nyaa~~'  - Swords",
    "'hmmmm (scratches testicles)'  - Stick-Pi",
    "'why have heating during winter when you can have kade engine'  - Eggu",
    "'i cant find the last raider'  - Cherri",
    "'Raid Shadow Legends'  - luneye",
    "'DO YOU WANT DA FOCKIN PHONE' - TPRS\nno  - Laztrix",
    "'psych,,, enenennegine,,,'  - Doggo",
    "'markiplier'  - boidavidman",
    "'Imagine yourself in a Frozen Forest...You're standing in a clearing. Trees around you so tall, they touch the sky…'  - Skry",
    "DO NOT CALL IT A FRICKIN ENGINE ITS A FRICKIN FORK",
    "my balls itch",
    "your mom :trollface:",
    "i dont know why this is exist lmfao",
    "Psych Port Goes Crazy",
    "made with no care by laztrix <3"
                                ];

 
	override function create()
	{

        if (FlxG.random.bool(90)){
       
        splash = new FlxSprite(0,-100).loadGraphic(Paths.image('thepsych'));
		splash.screenCenter(X);
        splash.setGraphicSize(Std.int(splash.width * 0.35));
        splash.alpha = 0;
        add(splash);

        randomSplash = new FlxText(-0, 0, 0,therandomText[FlxG.random.int(0, therandomText.length)] , 24);
        randomSplash.setFormat("VCR OSD Mono", 18, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        add(randomSplash);

        skipSplash = new FlxText(0, 0, 1250, '[PRESS SPACE TO SKIP]' , 0);
        skipSplash.autoSize = false;
        skipSplash.setFormat("VCR OSD Mono", 15, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        add(skipSplash);

        splashT = new FlxSprite(-200).loadGraphic(Paths.image('psych_text'));
        splashT.setGraphicSize(Std.int(splashT.width * 0.5));
		splashT.screenCenter(XY);
        splashT.y = 450;
        splashT.alpha = 0;
        add(splashT);
        
        // for auto fix teh text 
        randomSplash.x = FlxG.width + randomSplash.width;
        randomSplash.y = FlxG.height - randomSplash.height;

        new FlxTimer().start(1, function(tmr:FlxTimer)
            {
                FlxTween.tween(splash, {alpha: 1}, 1, {
                    ease: FlxEase.circOut,
                    onComplete: function(twen:FlxTween)
                    {
                    }
                });

                new FlxTimer().start(1.5, function(guh:FlxTimer)
                    {
                        FlxTween.tween(splashT, {alpha: 1}, 1, {
                            ease: FlxEase.circOut,
                            onComplete: function(tween:FlxTween)
                            {
                            }
                        });
                        FlxTween.tween(randomSplash, {x: FlxG.width - randomSplash.width}, 1, {
                            ease: FlxEase.sineInOut,
                            onComplete: function(tween:FlxTween)
                            {
                            }
                        });
                        FlxG.sound.play(Paths.sound("psych"));
                    
                        new FlxTimer().start(3, function(guh:FlxTimer)
                            {
                                FlxTween.tween(randomSplash, {x: FlxG.width + randomSplash.width}, 1, {
                                    ease: FlxEase.sineInOut,
                                    onComplete: function(tween:FlxTween)
                                    {
                                    }
                                });
                                FlxTween.tween(splash, {alpha: 0}, 1, {
                                    ease: FlxEase.expoOut,
                                    onComplete: function(twen:FlxTween)
                                    {
                                        remove(splash);
                                        splash.destroy();
                                    }
                                });
                                FlxTween.tween(splashT, {alpha: 0}, 2, {
                                    ease: FlxEase.expoOut,
                                    onComplete: function(tween:FlxTween)
                                    {
                                        remove(splashT);
                                        splashT.destroy();
                                        FlxG.switchState(thestate);
                                    }
                                });
                                
                            });
                    });
            });
        }
        else
        {
            new FlxTimer().start(1, function(guh:FlxTimer)
                {
                    startVideo('unfunny/'+ unfunnyVideos[FlxG.random.int(0, 2)]);
                });
        }

        super.create();
    }

    override function update(elapsed) 
    {
        if (FlxG.keys.justPressed.SPACE)   FlxG.switchState(thestate);

        super.update(elapsed);
    }
     
    function startVideo(name:String)
        {
            #if VIDEOS_ALLOWED
            var filepath:String = Paths.video(name);
            #if sys
            if(!FileSystem.exists(filepath))
            #else
            if(!OpenFlAssets.exists(filepath))
            #end
            {
                FlxG.log.warn('Couldnt find video file: ' + name);
                return;
            }
    
            var video:MP4Handler = new MP4Handler();
            video.playVideo(filepath);
            video.finishCallback = function()
            {
                FlxG.switchState(thestate);
                return;
            }
            #else
            FlxG.log.warn('Platform not supported!');
            return;
            #end
        }
}
