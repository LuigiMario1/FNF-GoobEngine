package psychlua;

import states.PlayState;
import flixel.tweens.FlxTween;
import backend.Conductor;
import psychlua.LuaUtils;

class ModchartAdditions
{
    public static function register(lua:Dynamic)
    {
        trace("REGISTERING MODCHART ADDITIONS");

        Lua_helper.add_callback(lua, "waveStrumsX", function(speed:Float, strength:Float)
        {
            waveStrumsX(speed, strength);
        });

        Lua_helper.add_callback(lua, "waveStrumsY", function(speed:Float, strength:Float)
        {
            waveStrumsY(speed, strength);
        });

        Lua_helper.add_callback(lua, "tweenStrumX", function(i:Int, x:Float, time:Float)
        {
            tweenStrumX(i, x, time);
        });
    }

    public static function waveStrumsX(speed:Float, strength:Float)
    {
        var ps = PlayState.instance;

        for (i in 0...ps.strumLineNotes.length)
        {
            var note = ps.strumLineNotes.members[i];
            note.x += Math.sin(Conductor.songPosition / speed + i) * strength;
        }
    }

    public static function waveStrumsY(speed:Float, strength:Float)
    {
        var ps = PlayState.instance;

        for (i in 0...ps.strumLineNotes.length)
        {
            var note = ps.strumLineNotes.members[i];
            note.y += Math.sin(Conductor.songPosition / speed + i) * strength;
        }
    }

    public static function tweenStrumX(i:Int, x:Float, time:Float)
    {
        var note = PlayState.instance.strumLineNotes.members[i];
        FlxTween.tween(note, {x: x}, time);
    }
}