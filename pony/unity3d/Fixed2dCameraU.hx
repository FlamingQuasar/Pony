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
package pony.unity3d;

import unityengine.MonoBehaviour;
import unityengine.Camera;
import unityengine.Rect;
import unityengine.Screen;

/**
 * Fixed2dCameraU
 * @author AxGord <axgord@gmail.com>
 */
@:nativeGen class Fixed2dCameraU extends MonoBehaviour {

	public var size:Int = 100;
	public var mainCamera:Camera;
	
	public function Start() {
		Fixed2dCamera.obj = this;
		Fixed2dCamera.SIZE = size;
		Fixed2dCamera.exists = true;
	}
	
	private function Update():Void {
		Fixed2dCamera.begin = Screen.width - size;
		mainCamera.pixelRect = new Rect(0, 0, Fixed2dCamera.begin, mainCamera.pixelRect.height);
		camera.pixelRect = new Rect(Fixed2dCamera.begin, 0, size, mainCamera.pixelRect.height);
	}
	
}