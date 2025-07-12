extends Node2D

@onready var path_2d: Path2D = $Path2D

func _ready() -> void:
	Signals.player_moves.connect(path_2d.move_block)
