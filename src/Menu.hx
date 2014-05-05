import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import flash.text.TextFieldAutoSize;
class Menu extends Sprite {
	var current : Sprite;
	var buttons : Sprite;
	public function new(){
		super();
		current = flash.Lib.current;

		var width = flash.Lib.current.stage.stageWidth;
		var height = flash.Lib.current.stage.stageHeight;

		buttons = new Sprite();
		current.addChild(buttons);
		{ //startGame
			var button = new Sprite();
			button.x = width/6;
			button.y = height/5;
			button.graphics.beginFill(0xED7703);
			button.graphics.drawRoundRect(0, 0, width*6/10, height/10, 50, 50);
			button.addEventListener(MouseEvent.MOUSE_DOWN, startCPUGame);

			button.addChild(getTextField("Player vs Computer"));
			buttons.addChild(button);
		}

		{ //startGame
			var button = new Sprite();
			button.x = width/6;
			button.y = height/5*2;
			button.graphics.beginFill(0x0279EC);
			button.graphics.drawRoundRect(0, 0,width*6/10, height/10, 50, 50);
			button.addEventListener(MouseEvent.CLICK, start2PlayerGame);
			buttons.addChild(button);

			button.addChild(getTextField("Player vs Player"));
		}

		{ //startGame
			var button = new Sprite();
			button.x = width/6;
			button.y = height/5*3;
			button.graphics.beginFill(0x84A40B);
			button.graphics.drawRoundRect(0, 0,width*6/10, height/10, 50, 50);
			button.addEventListener(MouseEvent.CLICK, showTuto);
			buttons.addChild(button);

			button.addChild(getTextField("Instructions"));
		}


	}
	public function startCPUGame(e : MouseEvent){
		var board = new Board(true);
		current.addChild(board);
		buttons.visible = false;
		
	}
	public function start2PlayerGame(e : MouseEvent){
		var board = new Board(false);
		current.addChild(board);
		buttons.visible = false;
	}
	public function showTuto(e : MouseEvent){
		//TODO
	}
	public function getTextField(txt : String){
			var text = new TextField();
			text.y = 11;
			text.text = txt;
			text.selectable = false;
			text.textColor = 0xffffff;
			text.width = flash.Lib.current.stage.stageWidth*6/10;
			text.height = flash.Lib.current.stage.stageHeight/10;
			
			var form = new TextFormat();
			form.size = 45;
			form.align = TextFormatAlign.CENTER;
			text.setTextFormat(form);
			return text;
	}
}