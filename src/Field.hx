import flash.display.Sprite;
//import flash.display.CapsStyle;

class Field extends Sprite {

	public var highlited : Int;
	var size : Int;
	public var scored : Int;
	public function new(posY : Int, posX : Int, s : Int) {
		super();
		highlited = 0;
		scored = 0;
		this.x = posX;
		this.y = posY;
		size = s;
		draw();
	}
	private function drawX(){
		graphics.lineStyle(10, 0x000000);//, CapsStyle.NONE);??

		graphics.moveTo(10, 10);
		graphics.lineTo(size - 10, size - 10);

		graphics.moveTo(size - 10, 10);
		graphics.lineTo(10, size - 10);
	}
	private function drawO(){
		graphics.lineStyle(10, 0x000000);
		graphics.drawCircle(size/2, size/2, size/2-10);
	}
	public function draw(){
		graphics.clear();
		switch (highlited) {
			case 0: graphics.beginFill(0xFFFFFF);
			case 1: graphics.beginFill(0xff3e3e);
			case 2: graphics.beginFill(0x4682b4);
			case 3: graphics.beginFill(0xe7c389);	
		}

		graphics.drawRect(0, 0, size, size);
		graphics.endFill();
		if(scored == 1) {
			drawX();
		} else if (scored == 2){
			drawO();
		}
	}
	public function click(turn : Int){
		if(highlited == 3 && scored == 0){
			//highlited = false;
			scored = turn;
			draw();	
			return true;
		} else {
			return false;
		}
		
	}

}