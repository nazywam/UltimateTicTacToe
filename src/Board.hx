import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import flash.events.MouseEvent;
class Board extends Sprite {
	var grid : Array<Array<Field>>;
	var macroGrid : Array<Array<Int>>;
	var boardSize : Int;
	var fieldSize : Int;
	var turn : Int;
	var cpu : Bool;
	var ai : AI;
	public function new(cpuOn : Bool) {
		super();
		cpu = cpuOn;
		if(flash.Lib.current.stage.stageWidth > flash.Lib.current.stage.stageHeight) {
			boardSize = Std.int(flash.Lib.current.stage.stageHeight*9/10);
		} else {
			boardSize = Std.int(flash.Lib.current.stage.stageWidth*9/10);
		}
		

		fieldSize = Std.int(boardSize / 9);
		grid = new Array<Array<Field>>();
		for (y in 0...9) {
			grid[y] = new Array<Field>();
			for (x in 0...9) {
				grid[y][x] = new Field(y*fieldSize, x*fieldSize, fieldSize);
				addChild(grid[y][x]);
				grid[y][x].addEventListener(MouseEvent.MOUSE_DOWN, mouseClick);
				grid[y][x].draw();
			}
		}
		macroGrid = new Array<Array<Int>>();
		for (y in 0...3) {
			macroGrid[y] = new Array<Int>();
			for (x in 0...3) {
				macroGrid[y][x] = 0;
			}
		}
		turn = 1;
		drawLines();

		{ //restart button
			var button = new Sprite();
			button.addEventListener(MouseEvent.MOUSE_DOWN, resetGame);
			button.y = fieldSize*9;
			button.graphics.beginFill(0x336AA4);
			button.graphics.drawRect(0,0,fieldSize*2, fieldSize);

			var text = new TextField();
			text.width = fieldSize*2;
			var form = new TextFormat();
			form.size = 36;
			form.align = TextFormatAlign.CENTER;
			text.defaultTextFormat = form;

			text.text = "Reset";
			text.selectable = false;
			
			button.addChild(text);

			addChild(button);
		}

		{ //menu button
			var button = new Sprite();
			button.addEventListener(MouseEvent.MOUSE_DOWN, toMenu);
			button.y = fieldSize*9;
			button.x = boardSize-fieldSize*2;

			button.graphics.beginFill(0x336AA4);
			button.graphics.drawRect(0,0,fieldSize*2, fieldSize);

			var text = new TextField();
			text.width = fieldSize*2;
			var form = new TextFormat();
			form.size = 36;
			form.align = TextFormatAlign.CENTER;
			text.defaultTextFormat = form;

			text.text = "Menu";
			text.selectable = false;
			
			button.addChild(text);

			addChild(button);	
		}

		highlitAll();
		if(cpu){
			ai = new AI(this);
		}

	}
	public function isFull(gridY : Int, gridX : Int){
		for (y in 0...3) {
			for (x in 0...3) {
				if(grid[gridY*3 + y][gridX*3 + x].scored == 0)return false;
			}
		}
		return true;
	}
	public function checkRow(row : Int, gridY : Int, gridX : Int){
		var s : Int = grid[gridY*3 + row][gridX*3].scored;
		if(s == 0) return 0;
		for (x in 0...3) {
			if(grid[gridY*3 + row][gridX*3 + x].scored != s) return 0;
		}
		return s;
	}
	public function checkColumn(column : Int, gridY : Int , gridX : Int) {
		var s : Int = grid[gridY*3][gridX*3 + column].scored;
		if(s == 0) return 0;
		for (y in 0...3) {
			if(grid[gridY*3 + y][gridX*3 + column].scored != s) return 0;
		}
		return s;
	}
	public function checkAcross(gridY : Int, gridX : Int){
		var s : Int = grid[gridY*3][gridX*3].scored;
		for (i in 0...3) {
			if(grid[gridY*3 + i][gridX*3 + i].scored != s) return 0;
		}
		return s;
	}
	public function checkCross(gridY : Int, gridX : Int){
		var s : Int = grid[gridY*3+2][gridX*3].scored;
		for (i in 0...3) {
			if(grid[gridY*3 + 2 - i][gridX*3 + i].scored != s) return 0;
		}
		return s;
	}
	public function updateMacroGridStatus(y : Int, x : Int) {
		if(macroGrid[y][x] == 0){
			for (_y in 0...3) {
				if(checkRow(_y, y, x) != 0) macroGrid[y][x] = checkRow(_y, y, x);
			}
			for (_x in 0...3) {
				if(checkColumn(_x, y, x) != 0) macroGrid[y][x] = checkColumn(_x, y, x);
			}
			if(checkAcross(y, x) != 0) macroGrid[y][x] = checkAcross(y, x);
			if(checkCross(y, x) != 0) macroGrid[y][x] = checkCross(y, x);
		}
	}

	public function clearHighlit() {
		for (y in 0...9) {
			for (x in 0...9) {
				if(grid[y][x].highlited == 3 || grid[y][x].highlited == 0){
					grid[y][x].highlited = 0;
					grid[y][x].draw();
				}
			}
		}
	}
	public function highlitAll() {
		for (y in 0...3) {
			for (x in 0...3) {
				if((macroGrid[y][x] == 0 || macroGrid[y][x] == 3) && !isFull(y,x)){
					highlitSquare(x, y, 3);	
				}
			}
		}
	}
	public function highlitSquare(x : Int, y : Int, color : Int) {
		for (_y in 0...3) {
			for (_x in 0...3) {
				grid[y*3 + _y][x*3 + _x].highlited = color;
				grid[y*3 + _y][x*3 + _x].draw();
			}
		}
	}
	public function mouseClick(e : MouseEvent) {
		var y : Int = Std.int(e.stageY/fieldSize);
		var x : Int = Std.int(e.stageX/fieldSize);

		clickField(y, x);
		if(cpu){
			ai.move();
		}
	}
	public function clickField(y : Int, x : Int) {

		var sqX : Int = Std.int(x/3);
		var sqY : Int= Std.int(y/3);
		if(y <= 9 && x<= 9){
			if(grid[y][x].click(turn)){
				updateMacroGridStatus(sqY, sqX);
				if(macroGrid[sqY][sqX] != 0 && macroGrid[sqY][sqX] != 3){
					highlitSquare(sqX, sqY, macroGrid[sqY][sqX]);
				}


				turn = turn % 2 + 1;
				clearHighlit();
				if((macroGrid[y%3][x%3] == 0 || macroGrid[y%3][x%3] == 3) && !isFull(y%3, x%3)){
					highlitSquare(x%3, y%3, 3);	
				} else {
					highlitAll();
				}
			}
		}
	}
	public function verticalLine(posX : Int, thick : Bool, lanes : Sprite) {
		lanes.graphics.lineStyle(2);
		if(thick){
			lanes.graphics.lineStyle(4);
		}
		lanes.graphics.moveTo(posX-2, 0);

		lanes.graphics.lineTo(posX-2, boardSize);
	}
	public function horizontalLine(posY : Int, thick : Bool, lanes : Sprite) {
		lanes.graphics.lineStyle(2);
		if(thick){
			lanes.graphics.lineStyle(4);
		}
		lanes.graphics.moveTo(0, posY-2);
		
		lanes.graphics.lineTo(boardSize, posY-2);
	}
	public function drawLines() {
		var lanes = new Sprite();
		for (y in 1...9) {
			horizontalLine(y*fieldSize, y%3==0, lanes);
		}
		for (x in 1...9) {
			verticalLine(x*fieldSize, x%3==0, lanes);
		}
		addChild(lanes);
	}
	public function resetGame(e : MouseEvent){
		turn = 1;
		for (y in 0...9) {
			for (x in 0...9) {
				grid[y][x].scored = 0;
				grid[y][x].highlited = 0;
				grid[y][x].draw();
			}
		}
		highlitAll();
	}
	public function toMenu(e : MouseEvent){
		this.visible = false;
		this.parent.visible = true; // ??

	}
}