extends PanelContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(2.5).timeout  # Muestra GAME OVER 2.5s
	Game.life = 3  # Reinicia las vidas
	get_tree().change_scene_to_file("res://ui/main_menu.tscn") 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Game.current_player and Game.current_player.is_inside_tree():
		global_position = Game.current_player.global_position + Vector2(438, 120)
