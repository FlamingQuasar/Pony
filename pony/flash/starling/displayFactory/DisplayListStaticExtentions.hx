/**
* Copyright (c) 2012-2017 Alexander Gordeyko <axgord@gmail.com>. All rights reserved.
* 
* Redistribution and use in source and binary forms, with or without modification, are
* permitted provided that the following conditions are met:
* 
* 1. Redistributions of source code must retain the above copyright notice, this list of
*   conditions and the following disclaimer.
* 
* 2. Redistributions in binary form must reproduce the above copyright notice, this list
*   of conditions and the following disclaimer in the documentation and/or other materials
*   provided with the distribution.
* 
* THIS SOFTWARE IS PROVIDED BY ALEXANDER GORDEYKO ``AS IS'' AND ANY EXPRESS OR IMPLIED
* WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
* FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL ALEXANDER GORDEYKO OR
* CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
* CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
* SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
* ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
* NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
* ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**/
package pony.flash.starling.displayFactory;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.geom.Rectangle;
import pony.flash.starling.displayFactory.DisplayFactory.IDisplayObject;
import pony.flash.starling.displayFactory.DisplayFactory.IMovieClip;
import pony.flash.starling.displayFactory.DisplayFactory.ITextField;
import pony.flash.starling.utils.UniversalDrag;

/**
 * DisplayListStaticExtentions
 * @author Maletin
 */
class DisplayListStaticExtentions 
{
	public static function setTouchable(object:IDisplayObject, value:Bool):Void
	{
		#if starling
		if (Std.is(object, starling.display.DisplayObject)) StarlingStaticExtentions.setTouchable(cast object, value);
		#end
		if (Std.is(object, flash.display.DisplayObject)) FlashStaticExtentions.setTouchable(cast object, value);
	}
	
	public static function getTouchable(object:IDisplayObject):Bool
	{
		#if starling
		if (Std.is(object, starling.display.DisplayObject)) return StarlingStaticExtentions.getTouchable(cast object);
		#end
		if (Std.is(object, flash.display.DisplayObject)) return FlashStaticExtentions.getTouchable(cast object);
		
		return false;
	}
	
	public static function startUniversalDrag(dragged:IDisplayObject, lockCenter:Bool = false, bounds:Rectangle = null):Void { UniversalDrag.startUniversalDrag(dragged, lockCenter, bounds); }
	public static function stopUniversalDrag(dragged:IDisplayObject):Void { UniversalDrag.stopUniversalDrag(dragged); }
	public static function stopUniversalDragKinetic(dragged:IDisplayObject):Void { UniversalDrag.stopUniversalDragKinetic(dragged); }
	
	public static function getTextWidth(textField:ITextField):Float
	{
		#if starling
		if (Std.is(textField, starling.text.TextField)) return StarlingStaticExtentions.getTextWidth(cast textField);
		#end
		if (Std.is(textField, flash.text.TextField)) return FlashStaticExtentions.getTextWidth(cast textField);
		
		return 0;
	}
	
	public static function getTextHeight(textField:ITextField):Float
	{
		#if starling
		if (Std.is(textField, starling.text.TextField)) return StarlingStaticExtentions.getTextHeight(cast textField);
		#end
		if (Std.is(textField, flash.text.TextField)) return FlashStaticExtentions.getTextHeight(cast textField);
		
		return 0;
	}
	
	public static function gotoAndPlay(clip:IMovieClip, frame:Int):Void
	{
		#if starling
		if (Std.is(clip, starling.display.MovieClip)) StarlingStaticExtentions.gotoAndPlay(cast clip, frame);
		#end
		if (Std.is(clip, flash.display.MovieClip)) cast(clip, flash.display.MovieClip).gotoAndPlay(frame);
	}
	
	public static function gotoAndStop(clip:IMovieClip, frame:Int):Void
	{
		#if starling
		if (Std.is(clip, starling.display.MovieClip)) StarlingStaticExtentions.gotoAndStop(cast clip, frame);
		#end
		if (Std.is(clip, flash.display.MovieClip)) cast(clip, flash.display.MovieClip).gotoAndStop(frame);
	}
}
#if starling
class StarlingStaticExtentions
{
	public static function setTouchable(object:starling.display.DisplayObject, value:Bool):Void { object.touchable = value; }
	public static function getTouchable(object:starling.display.DisplayObject):Bool { return object.touchable; }
	
	public static function startUniversalDrag(dragged:starling.display.DisplayObject, lockCenter:Bool = false, bounds:Rectangle = null):Void { UniversalDrag.startUniversalDrag(cast dragged, lockCenter, bounds); }
	public static function stopUniversalDrag(dragged:starling.display.DisplayObject):Void { UniversalDrag.stopUniversalDrag(cast dragged); }
	public static function stopUniversalDragKinetic(dragged:starling.display.DisplayObject):Void { UniversalDrag.stopUniversalDragKinetic(cast dragged); }
	
	public static function getTextWidth(textField:starling.text.TextField):Float { return textField.textBounds.width; }
	public static function getTextHeight(textField:starling.text.TextField):Float { return textField.textBounds.height; }
	
	public static function gotoAndPlay(clip:starling.display.MovieClip, frame:Int):Void {
		clip.currentFrame = frame - 1;
		clip.play();
	}
	public static function gotoAndStop(clip:starling.display.MovieClip, frame:Int):Void {
		clip.currentFrame = frame - 1;
		clip.pause();
	}
}
#end
class FlashStaticExtentions
{
	public static function setTouchable(object:flash.display.DisplayObject, value:Bool):Void
	{
		if (Std.is(object, flash.display.InteractiveObject)) cast (object, flash.display.InteractiveObject).mouseEnabled = value;
		if (Std.is(object, flash.display.DisplayObjectContainer)) cast (object, flash.display.DisplayObjectContainer).mouseChildren = value;
	}
	
	public static function getTouchable(object:flash.display.DisplayObject):Bool
	{
		if (Std.is(object, flash.display.InteractiveObject)) return cast (object, flash.display.InteractiveObject).mouseEnabled;
		
		return false;
	}
	
	public static function startUniversalDrag(dragged:flash.display.DisplayObject, lockCenter:Bool = false, bounds:Rectangle = null):Void { UniversalDrag.startUniversalDrag(cast dragged, lockCenter, bounds); }
	public static function stopUniversalDrag(dragged:flash.display.DisplayObject):Void { UniversalDrag.stopUniversalDrag(cast dragged); }
	public static function stopUniversalDragKinetic(dragged:flash.display.DisplayObject):Void { UniversalDrag.stopUniversalDragKinetic(cast dragged); }
	
	public static function getTextWidth(textField:flash.text.TextField):Float { return textField.textWidth; }
	public static function getTextHeight(textField:flash.text.TextField):Float { return textField.textHeight; }
}