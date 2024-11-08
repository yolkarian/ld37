class Shuriken extends Entity {

	public var rotSpeed = 0.;
	public var moveSpeed = 0.;
	var ang : Float = 0.;
	var heroLock : Float = 1.;

	public function new(t) {
		super();
		play([t]);
	}

	override function update(dt:Float) {
		if( rotSpeed == 0. )
			return;
		if( rotSpeed < 1 )
			rotSpeed += 0.02 * dt;
		if( rotSpeed > 0.4 ) {
			var ta = Math.atan2(game.hero.y - y, game.hero.x - x);
			ang = hxd.Math.angleLerp(ang, ta, heroLock); // Lock the direction towards hero
			heroLock *= Math.pow(0.9, dt);
			moveSpeed += 0.1 * dt; // update speed 
			x += moveSpeed * dt * Math.cos(ang); // update x coordinate
			y += moveSpeed * dt * Math.sin(ang); // update y coordinate
			checkHitHero(Math.cos(ang), Math.sin(ang)); // the input of checkHitHero seems to the direction of objects
		}
		anim.rotation += rotSpeed * 0.5 * dt;

		if( x < -20 || y < -20 || x > 550 || y > 350 )
			remove();
	}

}