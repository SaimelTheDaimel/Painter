extends Path2D

@onready var path_follow: PathFollow2D = $PathFollow2D

func move_block(dir):
	path_follow.progress_ratio += 0.01 * dir
