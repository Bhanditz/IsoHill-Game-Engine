/* IsoHill engine, http://www.isohill.com
* Copyright (c) 2011, Jonathan Dunlap, http://www.jadbox.com
* All rights reserved. Licensed: http://www.opensource.org/licenses/bsd-license.php
* 
* Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
* 
* Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
*/
package isohill.loaders 
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import isohill.GridBool;
	import isohill.IsoDisplay;
	import isohill.AssetManager;
	import isohill.IsoSprite;
	import isohill.loaders.ImgLoader;
	import isohill.starling.HitImage;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.textures.Texture;
	/**
	 * Loads one texture for one frame
	 * @author Jonathan Dunlap
	 */
	public class TextureLoader implements ITextureLoader
	{
		private var url:String;
		private var offset:Point;
		private var texture:Texture;
		private var hitMap:GridBool;
		private var hitMapTest:Boolean;
		private static var proxyTexture:Texture;
		
		public function TextureLoader(url:String, offet:Point=null, hitMapTest:Boolean=true) 
		{
			this.url = url;
			this.offset = offset?offset:new Point();
			this.hitMapTest = hitMapTest;
		}
		public function getDisplay():DisplayObject {
			if(proxyTexture==null) proxyTexture = Texture.empty(1,1);
			return new HitImage(proxyTexture);
		}		
		private function onLoad(bd:BitmapData):void {
			texture = Texture.fromBitmapData(bd);
			if(hitMapTest) hitMap = GridBool.fromBitMapDataAlpha(bd);
		}
		public function setTexture(sprite:IsoDisplay):void {
			if (texture == null) return;
			if(!(sprite is IsoSprite)) throw new Error("sprite "+sprite.name+" was created as a "+sprite+" but it's asset was for an IsoSprite");
			IsoSprite(sprite).setTexture(offset, texture);
			IsoSprite(sprite).setHitmap(hitMap);
		}
		public function get isLoaded():Boolean {
			return texture !== null;
		}
		public function get id():String {
			return url;
		}
		public function load():void {
			ImgLoader.instance.getBitmapData(url, onLoad);
		}
	}

}
