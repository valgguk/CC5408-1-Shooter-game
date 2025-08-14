extends PanelContainer
@onready var resume: Button = %Resume
@onready var retry: Button = %Retry
@onready var menu: Button = %Menu
@onready var quit: Button = %Quit
@onready var controls: Button = $MarginContainer/VBoxContainer/Controls


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resume.pressed.connect(_on_resume_pressed)
	retry.pressed.connect(_on_retry_pressed)
	quit.pressed.connect(func(): get_tree().quit())
	menu.pressed.connect(_on_menu_pressed)
	controls.pressed.connect(_on_control_pressed)
	hide()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		get_tree().paused = not get_tree().paused
		visible = get_tree().paused
	
func _on_resume_pressed() -> void:
	get_tree().paused = false
	hide()
	
func _on_retry_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
	
func _on_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://ui/main_menu.tscn")

func _on_control_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://ui/control.tscn")
	
func _process(delta: float) -> void:
	if Game.current_player and Game.current_player.is_inside_tree():
		global_position = Game.current_player.global_position + Vector2(438, 120)
