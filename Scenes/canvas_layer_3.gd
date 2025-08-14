extends CanvasLayer

@onready var game_over_sprite: Sprite2D = $game_over_sprite

func check_game_over():
	if Game.life <= 0:
		game_over_sprite.visible = true
		await get_tree().create_timer(2.5).timeout  # Muestra GAME OVER 2.5s
		Game.life = 3  # Reinicia las vidas
		get_tree().change_scene_to_file("res://MainMenu.tscn")  # Ajusta la ruta
