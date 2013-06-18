class Board {
	var map : Array<Array<Int>>;
	public function new():Void {
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
		var mc : flash.display.MovieClip = flash.Lib.current;
	}
	private function drawX(posX : Int,  posY : Int,  size : Int):Void{
		var mc : flash.display.MovieClip = flash.Lib.current;
		mc.graphics.beginFill( 0xFF0000 );
		mc.graphics.moveTo( posX, posY );
		mc.graphics.lineTo( posX+size, posY );
		mc.graphics.lineTo( posX+size, posY+size );
		mc.graphics.lineTo( posX, posY+size );
		mc.graphics.endFill();
	}
	public function draw():Void{
		for(x in 0...9){
			trace(map[x].toString());	
		}
		for(y in 0...9){
			for(x in 0...9){
				if(map[y][x]==0){
					drawX(y,x,10);
				}
			}
		}			
	
	}
}
