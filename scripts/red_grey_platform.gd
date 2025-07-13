extends Path2D

@onready var path_follow_2d: PathFollow2D = $PathFollow2D

func move_block(dir, speed, delta):
	path_follow_2d.progress += speed * dir * delta 
	
