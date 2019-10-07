package;


import haxe.io.Bytes;
import lime.utils.AssetBundle;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {


	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	public static var rootPath:String;


	public static function init (config:Dynamic):Void {

		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();

		rootPath = null;

		if (config != null && Reflect.hasField (config, "rootPath")) {

			rootPath = Reflect.field (config, "rootPath");

		}

		if (rootPath == null) {

			#if (ios || tvos || emscripten)
			rootPath = "assets/";
			#elseif android
			rootPath = "";
			#elseif console
			rootPath = lime.system.System.applicationDirectory;
			#else
			rootPath = "./";
			#end

		}

		Assets.defaultRootPath = rootPath;

		#if (openfl && !flash && !display)
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_monsterrat_ttf);
		
		#end

		var data, manifest, library, bundle;

		#if kha

		null
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("null", library);

		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("null");

		#else

		data = '{"name":null,"assets":"aoy4:pathy26:assets%2Fdata%2Fisland.oely4:sizei324921y4:typey4:TEXTy2:idR1y7:preloadtgoR0y27:assets%2Fdata%2Fisland2.oelR2i6787R3R4R5R7R6tgoR0y27:assets%2Fdata%2Fisland2.oepR2i6485R3R4R5R8R6tgoR0y36:assets%2Fmusic%2Fmusic-goes-here.txtR2zR3R4R5R9R6tgoR0y36:assets%2Fsounds%2Fsounds-go-here.txtR2zR3R4R5R10R6tgoR0y29:assets%2Fsprites%2FClouds.pngR2i5648R3y5:IMAGER5R11R6tgoR0y30:assets%2Fsprites%2FCredits.pngR2i6012R3R12R5R13R6tgoR0y30:assets%2Fsprites%2Fdoodads.pngR2i16235R3R12R5R14R6tgoR0y35:assets%2Fsprites%2Feditfoocolors.pyR2i865R3R4R5R15R6tgoR0y31:assets%2Fsprites%2Ffollower.pngR2i4319R3R12R5R16R6tgoR0y31:assets%2Fsprites%2Ffootdust.pngR2i87R3R12R5R17R6tgoR0y35:assets%2Fsprites%2FFOO_Title.piskelR2i4091R3R4R5R18R6tgoR0y32:assets%2Fsprites%2FFOO_Title.pngR2i2132R3R12R5R19R6tgoR0y46:assets%2Fsprites%2Fgravestones-spritesheet.pngR2i282R3R12R5R20R6tgoR0y29:assets%2Fsprites%2Fleader.pngR2i4803R3R12R5R21R6tgoR0y27:assets%2Fsprites%2Fodin.pngR2i6705R3R12R5R22R6tgoR0y30:assets%2Fsprites%2Foverlay.pngR2i69849R3R12R5R23R6tgoR0y28:assets%2Fsprites%2Fraven.pngR2i3126R3R12R5R24R6tgoR0y30:assets%2Fsprites%2Fterrain.pngR2i267R3R12R5R25R6tgoR0y30:assets%2Fsprites%2Ftileset.pngR2i3493R3R12R5R26R6tgoR0y28:assets%2Fsprites%2Fwater.pngR2i1321R3R12R5R27R6tgoR2i2114R3y5:MUSICR5y26:flixel%2Fsounds%2Fbeep.mp3y9:pathGroupaR29y26:flixel%2Fsounds%2Fbeep.ogghR6tgoR2i39706R3R28R5y28:flixel%2Fsounds%2Fflixel.mp3R30aR32y28:flixel%2Fsounds%2Fflixel.ogghR6tgoR2i5794R3y5:SOUNDR5R31R30aR29R31hgoR2i33629R3R34R5R33R30aR32R33hgoR2i15744R3y4:FONTy9:classNamey35:__ASSET__flixel_fonts_nokiafc22_ttfR5y30:flixel%2Ffonts%2Fnokiafc22.ttfR6tgoR2i29724R3R35R36y36:__ASSET__flixel_fonts_monsterrat_ttfR5y31:flixel%2Ffonts%2Fmonsterrat.ttfR6tgoR0y33:flixel%2Fimages%2Fui%2Fbutton.pngR2i519R3R12R5R41R6tgoR0y36:flixel%2Fimages%2Flogo%2Fdefault.pngR2i3280R3R12R5R42R6tgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
		

		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		

		#end

	}


}


#if kha

null

#else

#if !display
#if flash

@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_island_oel extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_island2_oel extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_island2_oep extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_music_goes_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sprites_clouds_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sprites_credits_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sprites_doodads_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sprites_editfoocolors_py extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sprites_follower_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sprites_footdust_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sprites_foo_title_piskel extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sprites_foo_title_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sprites_gravestones_spritesheet_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sprites_leader_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sprites_odin_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sprites_overlay_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sprites_raven_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sprites_terrain_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sprites_tileset_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sprites_water_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:keep @:file("assets/data/island.oel") @:noCompletion #if display private #end class __ASSET__assets_data_island_oel extends haxe.io.Bytes {}
@:keep @:file("assets/data/island2.oel") @:noCompletion #if display private #end class __ASSET__assets_data_island2_oel extends haxe.io.Bytes {}
@:keep @:file("assets/data/island2.oep") @:noCompletion #if display private #end class __ASSET__assets_data_island2_oep extends haxe.io.Bytes {}
@:keep @:file("assets/music/music-goes-here.txt") @:noCompletion #if display private #end class __ASSET__assets_music_music_goes_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/sounds-go-here.txt") @:noCompletion #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends haxe.io.Bytes {}
@:keep @:image("assets/sprites/Clouds.png") @:noCompletion #if display private #end class __ASSET__assets_sprites_clouds_png extends lime.graphics.Image {}
@:keep @:image("assets/sprites/Credits.png") @:noCompletion #if display private #end class __ASSET__assets_sprites_credits_png extends lime.graphics.Image {}
@:keep @:image("assets/sprites/doodads.png") @:noCompletion #if display private #end class __ASSET__assets_sprites_doodads_png extends lime.graphics.Image {}
@:keep @:file("assets/sprites/editfoocolors.py") @:noCompletion #if display private #end class __ASSET__assets_sprites_editfoocolors_py extends haxe.io.Bytes {}
@:keep @:image("assets/sprites/follower.png") @:noCompletion #if display private #end class __ASSET__assets_sprites_follower_png extends lime.graphics.Image {}
@:keep @:image("assets/sprites/footdust.png") @:noCompletion #if display private #end class __ASSET__assets_sprites_footdust_png extends lime.graphics.Image {}
@:keep @:file("assets/sprites/FOO_Title.piskel") @:noCompletion #if display private #end class __ASSET__assets_sprites_foo_title_piskel extends haxe.io.Bytes {}
@:keep @:image("assets/sprites/FOO_Title.png") @:noCompletion #if display private #end class __ASSET__assets_sprites_foo_title_png extends lime.graphics.Image {}
@:keep @:image("assets/sprites/gravestones-spritesheet.png") @:noCompletion #if display private #end class __ASSET__assets_sprites_gravestones_spritesheet_png extends lime.graphics.Image {}
@:keep @:image("assets/sprites/leader.png") @:noCompletion #if display private #end class __ASSET__assets_sprites_leader_png extends lime.graphics.Image {}
@:keep @:image("assets/sprites/odin.png") @:noCompletion #if display private #end class __ASSET__assets_sprites_odin_png extends lime.graphics.Image {}
@:keep @:image("assets/sprites/overlay.png") @:noCompletion #if display private #end class __ASSET__assets_sprites_overlay_png extends lime.graphics.Image {}
@:keep @:image("assets/sprites/raven.png") @:noCompletion #if display private #end class __ASSET__assets_sprites_raven_png extends lime.graphics.Image {}
@:keep @:image("assets/sprites/terrain.png") @:noCompletion #if display private #end class __ASSET__assets_sprites_terrain_png extends lime.graphics.Image {}
@:keep @:image("assets/sprites/tileset.png") @:noCompletion #if display private #end class __ASSET__assets_sprites_tileset_png extends lime.graphics.Image {}
@:keep @:image("assets/sprites/water.png") @:noCompletion #if display private #end class __ASSET__assets_sprites_water_png extends lime.graphics.Image {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,6,3/assets/sounds/beep.mp3") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,6,3/assets/sounds/flixel.mp3") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,6,3/assets/sounds/beep.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,6,3/assets/sounds/flixel.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends haxe.io.Bytes {}
@:keep @:font("export/html5/obj/webfont/nokiafc22.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font {}
@:keep @:font("export/html5/obj/webfont/monsterrat.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel/4,6,3/assets/images/ui/button.png") @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel/4,6,3/assets/images/logo/default.png") @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends lime.graphics.Image {}
@:keep @:file("") @:noCompletion #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else

@:keep @:expose('__ASSET__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/nokiafc22"; #else ascender = 2048; descender = -512; height = 2816; numGlyphs = 172; underlinePosition = -640; underlineThickness = 256; unitsPerEM = 2048; #end name = "Nokia Cellphone FC Small"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/monsterrat"; #else ascender = 968; descender = -251; height = 1219; numGlyphs = 263; underlinePosition = -150; underlineThickness = 50; unitsPerEM = 1000; #end name = "Monsterrat"; super (); }}


#end

#if (openfl && !flash)

#if html5
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#else
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#end

#end
#end

#end
