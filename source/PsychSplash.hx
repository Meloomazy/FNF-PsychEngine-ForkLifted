import flixel.addons.display.FlxBackdrop;
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
#if (hxCodec >= "2.6.1") import hxcodec.VideoHandler as MP4Handler;
#elseif (hxCodec == "2.6.0") import VideoHandler as MP4Handler;
#else import vlc.MP4Handler; #end
#end


#if sys
import sys.FileSystem;
import sys.io.File;
#end

using StringTools;

class PsychSplash extends FlxState
{
	var checkDrop:FlxBackdrop;
    var splash:FlxSprite;
    var splashT:FlxSprite;
    var thestate:FlxState = new TitleState();
    var randomSplash:FlxText;
    var skipSplash:FlxText;
    var textNeeded:String = '';

    // i love psych engine community server
    var psychServerText:Array<String> = [
    "'burp'  - Ache",
    "'nyaa~~'  - Swords",
    "'hmmmm (scratches testicles)'  - Stick-Pi",
    "'why have heating during winter when you can have kade engine'  - Eggu",
    "'i cant find the last raider'  - Cherri",
    "'Raid Shadow Legends'  - luneye",
    "'DO YOU WANT DA FOCKIN PHONE' - TPRS\nno  - Laztrix",
    "'psych,,, enenennegine,,,'  - Doggo",
    "'markiplier'  - boidavidman",
    "'Imagine yourself in a Frozen Forest...'  - Skry"];

    var forkLiftText:Array<String> = [
    "hello everybody my name is markiplier",
    "my balls itch",
    "what is this suppose to be?",
    "i dont know why this is exist lmfao",
    "the milkman is coming",
    "made with no care by laztrix <3"
                                ];

 
	override function create()
	{

        var bg:FlxSprite = new FlxSprite(0,0,Paths.image('bgSplash'));
		bg.screenCenter(X);
        add(bg);
        
		checkDrop = new FlxBackdrop(Paths.image('checkaboardMagenta'), XY, -0, -0);
		checkDrop.scrollFactor.set();
		checkDrop.scale.set(0.7,0.7);
		checkDrop.screenCenter(X);
		checkDrop.velocity.set(200,80);
		checkDrop.alpha = 0;
        add(checkDrop);

        skipSplash = new FlxText(0, 0, 1250, '[PRESS ACCEPT TO SKIP]' , 0);
        skipSplash.autoSize = false;
        skipSplash.setFormat("VCR OSD Mono", 15, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        add(skipSplash);

        if (FlxG.random.bool(65)) 
            textNeeded = forkLiftText[FlxG.random.int(0, forkLiftText.length)];
        else
            textNeeded = psychServerText[FlxG.random.int(0, psychServerText.length)];

        splash = new FlxSprite(0,-900).loadGraphic(Paths.image('thepsych'));
		splash.screenCenter(X);
        splash.setGraphicSize(Std.int(splash.width * 0.35));
        add(splash);

        randomSplash = new FlxText(-0, 0, 0, textNeeded, 24);
        randomSplash.setFormat("VCR OSD Mono", 18, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        add(randomSplash);

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
                FlxTween.tween(checkDrop, {alpha: 1}, 2, {
                    ease: FlxEase.circOut,
                    onComplete: function(twen:FlxTween)
                    {
                        FlxTween.tween(splash, {y: -100}, 2, {
                            ease: FlxEase.backInOut
                        });
                        FlxTween.tween(splash, {angle: splash.angle	+ 5}, 1, {ease: FlxEase.sineInOut, type: PINGPONG});

                    }
                });

                new FlxTimer().start(1.5, function(guh:FlxTimer)
                    {
                        FlxTween.tween(splashT, {alpha: 1}, 1, {
                            ease: FlxEase.circOut,
                            onComplete: function(tween:FlxTween)
                            {
                                FlxG.sound.play(Paths.sound("psych"));
                            }
                        });
                        FlxTween.tween(randomSplash, {x: FlxG.width - randomSplash.width}, 1, {
                            ease: FlxEase.sineInOut,
                            onComplete: function(tween:FlxTween)
                            {
                            }
                        });
                    
                        new FlxTimer().start(4, function(guh:FlxTimer)
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

                                    }
                                });
                                FlxTween.tween(splashT, {alpha: 0}, 2, {
                                    ease: FlxEase.expoOut,
                                    onComplete: function(tween:FlxTween)
                                    {
                             
                                        FlxG.switchState(thestate);
                                    }
                                });
                                
                            });
                    });
            });

        super.create();
    }

    
    override function update(elapsed) 
        {
            if (FlxG.keys.justPressed.SPACE || FlxG.keys.justPressed.ENTER)
                    FlxG.switchState(thestate);
            super.update(elapsed);
        }
}
