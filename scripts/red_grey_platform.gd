extends Path2D

@onready var path_follow: PathFollow2D = $PathFollow2D
@export var ratio: PathFollow2D

func move_block(dir, delta):
	ratio.progress_ratio += delta * dir
