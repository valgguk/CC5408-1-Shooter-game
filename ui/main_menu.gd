extends MarginContainer
@onready var start: Button = %Start
@onready var quit: Button = %Quit
@onready var credits: Button = %Credits
@onready var controls: Button = $PanelContainer/MarginContainer/VBoxContainer/Controls




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start.pressed.connect(_on_start_pressed)
	quit.pressed.connect(func(): get_tree().quit())
	credits.pressed.connect(func(): get_tree().change_scene_to_file("res://ui/credits.tscn"))
	controls.pressed.connect(func(): get_tree().change_scene_to_file("res://ui/control.tscn"))
func _on_start_pressed() -> void:
	Game.life = 3  # Reinicia las vidas
	get_tree().change_scene_to_file("res://Scenes/nivel.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
