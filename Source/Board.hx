import flash.display.StageScaleMode;

class Board {
	var map : Array<Array<Int>>;
	var sqSize : Int;	
	public function new():Void {
		var mc : flash.display.MovieClip = flash.Lib.current;
									//mc.stage.scaleMode = StageScaleMode.NO_SCALE;
		sqSize = Std.int(mc.stage.width);
		if(mc.stage.height<mc.stage.width){
			sqSize = Std.int(mc.stage.height);
		}		

		map = new Array<Array<Int>>();
		var line = new Array<Int>();
		for(x in 0...9) {
			line.insert(x,0);
		}

		for(x in 0...9) {
			map.insert(x, line);
		}
		
	} 
	
	private function drawO(posX : Int,  posY : Int,  size : Int):Void{
	
	}
	private function drawX(posX : Int,  posY : Int,  size : Int):Void{
		var mc : flash.display.MovieClip = flash.Lib.current;
		mc.graphics.beginFill( 0xFF0000 );
		mc.graphics.moveTo( posX, posY );
		mc.graphics.lineTo( posX+size, posY+size );
		mc.graphics.lineTo( posX+size-10, posY+size );
		mc.graphics.lineTo( posX, posY+10 );
		mc.graphics.endFill();

		mc.graphics.beginFill( 0xFF0000 );
		mc.graphics.moveTo( posX, posY+size );
		mc.graphics.lineTo( posX+size, posY );
		mc.graphics.lineTo( posX+size, posY+10 );
		mc.graphics.lineTo( posX+10, posY+size );
		mc.graphics.endFill();
	}
	private function drawLine(posX : Int, posY : Int, width: Int):Void{

	}
	public function draw():Void{
		var tileSize : Int = Std.int(sqSize/9);
		for(x in 0...9){
			trace(map[x].toString());	
		}
		for(y in 0...9){
			for(x in 0...9){
				if(map[y][x]==0){
					drawX(y*tileSize,x*tileSize, tileSize);
				}
				else if(map[y][x]==2){
					drawO(y*tileSize,x*tileSize, tileSize);
				}
			}
		}			
	
	}
}
