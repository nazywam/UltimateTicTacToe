
import flash.display.Sprite;
import flash.display.Stage;
import flash.events.MouseEvent;

class Board extends Sprite{
	var map : Array<Int>;
	var sqSize : Int;
	var highlited : Array<Boolean>
	function myClick(eventObject:MouseEvent) {
		map[Std.int(eventObject.stageY/(sqSize/9))*9+Std.int(eventObject.stageX/(sqSize/9))]=1;
		//trace(Std.int(eventObject.stageX/(sqSize/9)));
		//trace(Std.int(eventObject.stageY/(sqSize/9)));
		//trace(map[Std.int(eventObject.stageY/(sqSize/9))][Std.int(eventObject.stageX/(sqSize/9))]);
		trace(map.toString());
		draw();
	}
		


	public function new():Void {
		super();
		var mc : flash.display.MovieClip = flash.Lib.current;

		sqSize = Std.int(mc.stage.width);
		if(mc.stage.height<mc.stage.width){
			sqSize = Std.int(mc.stage.height);
		}		

		map = new Array<Int>();
		highlited = new Array<Boolean>();
		

		for(x in 0...81) {
			map.insert(x, 0);
		}

		for(x in 0...81) {
			highlited.insert(x, true);
		}
		stage.addEventListener(MouseEvent.CLICK, myClick);
		
		
	} 
	
	private function drawO(posY : Int,  posX : Int,  size : Int):Void{
	
		var mc : flash.display.MovieClip = flash.Lib.current;
		mc.graphics.beginFill( 0x000000 );
		mc.graphics.moveTo( posX+10, posY+10 );
		mc.graphics.lineTo( posX+10, posY+size-10 );
		mc.graphics.lineTo( posX+size-10, posY+size-10 );
		mc.graphics.lineTo( posX+size-10, posY+10 );
		mc.graphics.endFill();

		mc.graphics.beginFill( 0xFFFFFF );
		mc.graphics.moveTo( posX+20, posY+20 );
		mc.graphics.lineTo( posX+20, posY+size-20 );
		mc.graphics.lineTo( posX+size-20, posY+size-20 );
		mc.graphics.lineTo( posX+size-20, posY+20 );
		mc.graphics.endFill();

	}
	private function drawX(posY : Int,  posX : Int,  size : Int):Void{
		var mc : flash.display.MovieClip = flash.Lib.current;
		mc.graphics.beginFill( 0x000000 );
		mc.graphics.moveTo( posX+10, posY+10 );
		mc.graphics.lineTo( posX+size-10, posY+size-10 );
		mc.graphics.lineTo( posX+size-10-10, posY+size-10 );
		mc.graphics.lineTo( posX+10, posY+10+10 );
		mc.graphics.endFill();

		mc.graphics.beginFill( 0x000000 );
		mc.graphics.moveTo( posX+10, posY+size-10 );
		mc.graphics.lineTo( posX+size-10, posY+10 );
		mc.graphics.lineTo( posX+size-10, posY+10+10 );
		mc.graphics.lineTo( posX+10+10, posY+size-10 );
		mc.graphics.endFill();
	}
	private function drawLines(tileSize : Int):Void{
		var mc : flash.display.MovieClip = flash.Lib.current;

		var width : Int = 2;
		for(x in 0...10){
			
			if(x%3==0)width = 2;
			else width = 1;
				mc.graphics.beginFill( 0x000000 );
				mc.graphics.moveTo( x*tileSize-width, 0 );				
				mc.graphics.lineTo( x*tileSize-width, sqSize-4 );
				mc.graphics.lineTo( x*tileSize+width, sqSize-4 );				
				mc.graphics.lineTo( x*tileSize+width, 0 );
				mc.graphics.endFill();
		}
		for(y in 0...10){
			if(y%3==0)width = 2;
			else width = 1;
				mc.graphics.beginFill( 0x000000 );
				mc.graphics.moveTo( 0, y*tileSize-width );				
				mc.graphics.lineTo( sqSize-4, y*tileSize-width );
				mc.graphics.lineTo( sqSize-4, y*tileSize+width );				
				mc.graphics.lineTo( 0, y*tileSize+width );
				mc.graphics.endFill();
		}
		
	}
	public function draw():Void{	

		var tileSize : Int = Std.int(sqSize/9);
		var mc : flash.display.MovieClip = flash.Lib.current;
		mc.graphics.clear();
		for(x in 0...81){
			if(highlited[x]){
	
				var posX : Int = x%9;		
				var posY : Int = x/9;
				mc.graphics.beginFill( 0x000000 );
				mc.graphics.moveTo( x*tileSize, y*tileSize );				
				mc.graphics.lineTo( x*tileSize, y*tileSize+tileSize );
				mc.graphics.lineTo( x*tileSize+tileSize, y*tileSize+tileSize );				
				mc.graphics.lineTo( x*tileSize+tileSize, y*tileSize );
				mc.graphics.endFill();					
			}
			
		}
		drawLines(tileSize);
		for(x in 0...81){
			if(map[x]==1){
				drawX(Std.int(x/9)*tileSize,Std.int(x%9)*tileSize, tileSize);
			}
			else if(map[x]==2){
				drawO(Std.int(x/9)*tileSize,Std.int(x%9)*tileSize, tileSize);
			}
		}
		}			
	
	}

