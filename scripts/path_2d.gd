extends Path2D

@onready var path_follow: PathFollow2D = $PathFollow2D

func move_block(dir, delta):
	path_follow.progress_ratio += delta * dir
