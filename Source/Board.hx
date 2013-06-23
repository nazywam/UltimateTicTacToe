
import flash.display.Sprite;
import flash.display.Stage;
import flash.events.MouseEvent;

class Board extends Sprite{
	var map : Array<Int>;
	var sqSize : Int;
	var highlited : Array<Bool>;
	var p1_turn : Bool;
	function myClick(eventObject:MouseEvent) {
		var clicked : Int = Std.int(eventObject.stageY/(sqSize/9))*9+Std.int(eventObject.stageX/(sqSize/9));
		if (highlited[clicked]){
			if(p1_turn){
				map[clicked]=1;
			}
			else{
				map[clicked]=2;
			}
			p1_turn=!p1_turn;
			highlited[clicked]=false;
			chooseCorner(clicked);
		}
		
		draw();
	}
		


	public function new():Void {
		super();
		p1_turn = true;
		var mc : flash.display.MovieClip = flash.Lib.current;

		sqSize = Std.int(mc.stage.width);
		if(mc.stage.height<mc.stage.width){
			sqSize = Std.int(mc.stage.height);
		}		

		map = new Array<Int>();
		highlited = new Array<Bool>();
		

		for(x in 0...81) {
			map.insert(x, 0);
		}

		for(x in 0...81) {
			highlited.insert(x, true);
		}
		stage.addEventListener(MouseEvent.CLICK, myClick);
		
		
	} 
	
	private function drawO(posY : Int,  posX : Int,  size : Int, mc : flash.display.MovieClip):Void{
	
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
	private function drawX(posY : Int,  posX : Int,  size : Int, mc : flash.display.MovieClip):Void{
		var mc : flash.display.MovieClip = flash.Lib.current;
		mc.graphics.beginFill( 0x000000 );
		mc.graphics.moveTo( posX, posY );
		mc.graphics.lineTo( posX+size, posY+size );
		mc.graphics.lineTo( posX+size, posY+size );
		mc.graphics.lineTo( posX, posY+10 );
		mc.graphics.endFill();

		mc.graphics.beginFill( 0x000000 );
		mc.graphics.moveTo( posX+10, posY+size-10 );
		mc.graphics.lineTo( posX+size-10, posY+10 );
		mc.graphics.lineTo( posX+size-10, posY+10+10 );
		mc.graphics.lineTo( posX+10+10, posY+size-10 );
		mc.graphics.endFill();
	}
	private function drawLines(tileSize : Int, mc : flash.display.MovieClip):Void{

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
	private function drawHighlited(tileSize : Int, mc : flash.display.MovieClip){
		mc.graphics.clear();
		for(x in 0...81){
			if(highlited[x]){
				var posX : Int = Std.int(x%9);		
				var posY : Int = Std.int(x/9);
				mc.graphics.beginFill( 0xe7c389 );
				mc.graphics.moveTo( posX*tileSize, posY*tileSize );				
				mc.graphics.lineTo( posX*tileSize, posY*tileSize+tileSize );
				mc.graphics.lineTo( posX*tileSize+tileSize, posY*tileSize+tileSize );				
				mc.graphics.lineTo( posX*tileSize+tileSize, posY*tileSize );
				mc.graphics.endFill();					
			}
			
		}
	}
	private function highlit(x : Int, y : Int){
		var space : Bool = false;
		for(q in 0...81){
			highlited[q]=false;
		}
		for(y1 in 0...3){
			for(x1 in 0...3){
				var index : Int = (y1+y)*9+(x1+x);
				if(map[index]==0){
					space = true;
					highlited[index] = true;
				}
			}
			
		}
		if (!space){
			for(q in 0...81){
				if(map[q]==0){
					highlited[q]=true;
				}
			}
		}
	}
	private function chooseCorner(x: Int){
		trace(Std.int((x/9)%3)*3+(x%9)%3);
		switch(Std.int((x/9)%3)*3+(x%9)%3){
			case 0:highlit(0,0);
			case 1:highlit(3,0);
			case 2:highlit(6,0);
			case 3:highlit(0,3);
			case 4:highlit(3,3);
			case 5:highlit(6,3);
			case 6:highlit(0,6);
			case 7:highlit(3,6);
			case 8:highlit(6,6);

		}
	}
	public function draw():Void{	

		var tileSize : Int = Std.int(sqSize/9);
		var mc : flash.display.MovieClip = flash.Lib.current;

		
		drawHighlited(tileSize, mc);
		drawLines(tileSize, mc);

		for(x in 0...81){
			if(map[x]==1){
				drawX(Std.int(x/9)*tileSize,Std.int(x%9)*tileSize, tileSize, mc);
			}
			else if(map[x]==2){
				drawO(Std.int(x/9)*tileSize,Std.int(x%9)*tileSize, tileSize, mc);
			}
		}
		}			
	
	}

