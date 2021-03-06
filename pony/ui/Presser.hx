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
package pony.ui;

import pony.time.ITimer;
import pony.time.DTimer;
import pony.time.Time;
import pony.time.DT;

/**
 * Presser
 * @author AxGord <axgord@gmail.com>
 */
class Presser {
	
	static public var useDeltaTime = true;
	static public var pressFirstDelay:Time = 500;
	static public var pressDelay:Time = 200;
	
	private var firstTimer:ITimer<Dynamic>;
	private var secondTimer:ITimer<Dynamic>;
	
	private var callBack:Void->Void;
	
	public function new(callBack:Void->Void) {
		this.callBack = callBack;
		if (useDeltaTime) {
			firstTimer = DTimer.fixedDelay(pressFirstDelay, firstTickDelta);
		} else {
			#if (!neko || munit)
			firstTimer = pony.time.Timer.delay(pressFirstDelay, firstTickClassic);
			#end
		}
	}
	
	private function firstTickDelta(dt:DT):Void {
		firstTimer = null;
		secondTimer = DTimer.fixedRepeat(pressDelay, callBack, dt);
		callBack();
	}
	#if (!neko || munit)
	private function firstTickClassic():Void {
		firstTimer = null;
		secondTimer = pony.time.Timer.repeat(pressDelay, callBack);
		callBack();
	}
	#end
	public function destroy():Void {
		if (firstTimer != null) {
			firstTimer.destroy();
			firstTimer = null;
		}
		if (secondTimer != null) {
			secondTimer.destroy();
			secondTimer = null;
		}
		callBack = null;
	}
	
}