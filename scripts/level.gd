extends Node2D

@onready var rg_plat_1: Path2D = $red_grey_platforms/RGPlat1
@onready var rg_plat_2: Path2D = $red_grey_platforms/RGPlat2

func _ready() -> void:
	Signals.player_moves.connect(rg_plat_1.move_block)
	Signals.player_moves.connect(rg_plat_2.move_block)
