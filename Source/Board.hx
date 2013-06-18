class Board {
	var map = Array<Array<Int>>();
	public function new():Void {

		var line = new Array<Int>();
		for(x in 0...9) {
			line.insert(x,0);
		}

		for(x in 0...9) {
			map.insert(x, line);
		}

		//trace(map.toString());	
	} 
}
