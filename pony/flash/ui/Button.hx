/**
* Copyright (c) 2012-2014 Alexander Gordeyko <axgord@gmail.com>. All rights reserved.
*
* Redistribution and use in source and binary forms, with or without modification, are
* permitted provided that the following conditions are met:
*
*   1. Redistributions of source code must retain the above copyright notice, this list of
*      conditions and the following disclaimer.
*
*   2. Redistributions in binary form must reproduce the above copyright notice, this list
*      of conditions and the following disclaimer in the documentation and/or other materials
*      provided with the distribution.
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
*
* The views and conclusions contained in the software and documentation are those of the
* authors and should not be interpreted as representing official policies, either expressed
* or implied, of Alexander Gordeyko <axgord@gmail.com>.
**/
package pony.flash.ui;

import flash.display.DisplayObject;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.ui.Multitouch;
import flash.events.TouchEvent;
import pony.flash.FLTools;
import pony.time.DeltaTime;


import pony.events.Signal;
import pony.ui.ButtonCore;

using pony.flash.FLExtends;
using pony.flash.CPP_FL_TouchFix;

/**
 * Button
 * @see pony.ui.ButtonCore
 * @author AxGord
 */
class Button extends MovieClip {

	public static var config = {def: 1, focus: 2, press: 3, zone: 4, disabled: 5};
	
	public var core:ButtonCore;
	
	private var zone:Button;
	private var visual:Button;
	
	private var leftOver:Bool = false;
	
	public function new() {
		super();
		FLTools.setTrace();
		stop();
		removeChildren();
		var cl:Class<Button> = Type.getClass(this);
		
		visual = Type.createEmptyInstance(cl);
		visual.gotoAndStop(config.def);
		visual.mouseEnabled = false;
		visual.mouseChildren = false;
		visual.scaleX = scaleX;
		visual.scaleY = scaleY;
		addChild(visual);
		
		zone = Type.createEmptyInstance(cl);
		zone.gotoAndStop(config.zone);
		zone.buttonMode = true;
		zone.alpha = 0;
		zone.scaleX = scaleX;
		zone.scaleY = scaleY;
		addChild(zone);
		
		core = new ButtonCore();
		core.changeVisual.add(change);
		
		mouseEnabled = false;
		
		scaleX = 1;
		scaleY = 1;
		FLTools.init < init;
	}
	
	private function init():Void {
		
		/*if (CPP_FL_TouchFix.useFix) {
			zone.downSignal().add(core.mouseOver.bind(false));
			CPP_FL_TouchFix.move.add(touchMove);
			CPP_FL_TouchFix.down.add(touchMove);
			zone.upSignal().add(touchUp);
			
		} else {
		*/
		if (Multitouch.supportsTouchEvents) {
			zone.addEventListener(TouchEvent.TOUCH_OVER, touchOver);
			zone.addEventListener(TouchEvent.TOUCH_OUT, touchOut);
			zone.addEventListener(TouchEvent.TOUCH_TAP, touchPress);
		} else {
			zone.addEventListener(MouseEvent.MOUSE_OVER, over);
			zone.addEventListener(MouseEvent.MOUSE_OUT, core.mouseOut.v());
			zone.addEventListener(MouseEvent.MOUSE_DOWN, core.mouseDown.v());
			stage.addEventListener(MouseEvent.MOUSE_UP, core.mouseUp.v());
		}
	}
	
	private function touchOver(_):Void {
		core.mouseOver(false);
		core.mouseDown();
	}
	
	private function touchOut(_):Void {
		core.mouseOut();
		core.mouseUp();
		leftOver = false;
	}
	
	private function touchPress(_):Void {
		core.mouseUp();
		core.mouseOut();
		leftOver = false;
	}
	
	private function over(event:MouseEvent):Void core.mouseOver(event.buttonDown);
	
	private function change(state:ButtonStates, mode:Int, focus:Bool):Void {
		if (mode == 1) {
			zone.buttonMode = false;
			visual.gotoAndStop(config.disabled);
			return;
		}
		zone.buttonMode = true;
	
		visual.gotoAndStop((switch [state, focus] {
			case [Default, false]: config.def;
			case [Focus|Leave, _] | [_, true]: config.focus;
			case [Press, _]: config.press;
		}) + mode * 3 - (mode > 1?1:0));
	}
	
	
	//Touch screen in cpp
	
	private function touchMove(obj:InteractiveObject) {
		if (zone == obj) return;
		core.mouseOut();
		core.mouseUp();
	}
	
	private function touchUp() {
		core.mouseDown();
		core.mouseUp();
		core.mouseOut();
	}
	
	public function sw(v:Array<Int>):Void if (core != null) core.sw = v;
	
}