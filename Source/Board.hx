class Board {
	public function new():Void {

		var map = new Array<Array<Int>>();
		var line = new Array<Int>();
		for(x in 0...9) {
			line.insert(x,0);
		}

		for(x in 0...9) {
			map.insert(x, line);
		}

		trace(map.toString());	
	} 
}
