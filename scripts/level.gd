extends Node2D

@onready var g_plat_1: Path2D = $grey_platforms/GPlat1
@onready var g_plat_2: Path2D = $grey_platforms/GPlat2
@onready var path_2d: Path2D = $grey_platforms/Path2D

func _ready() -> void:
	Signals.player_moves.connect(g_plat_1.move_block)
	Signals.player_moves.connect(g_plat_2.move_block)
	
	Signals.player_moves.connect(path_2d.move_block)
