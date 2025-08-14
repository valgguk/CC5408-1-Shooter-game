class_name Player
extends CharacterBody2D

@export var max_speed = 500.0  # Velocidad de la nave
@export var jump_velocity = -400.0 #hacia arriba es negativo (eje y invertido)
@export var hp = 50
@onready var label_lifes: Label = $CanvasLayer2/label_lifes
@onready var life_1: Sprite2D = $CanvasLayer2/life_1
@onready var life_2: Sprite2D = $CanvasLayer2/life_2
@onready var life_3: Sprite2D = $CanvasLayer2/life_3


@export var bullet_player_scene: PackedScene
@onready var bullet_spawn_right: Marker2D = $BulletSpawnRight
@onready var bullet_spawn_left: Marker2D = $BulletSpawnLeft

@onready var disparo_sound: AudioStreamPlayer2D = $disparo_sound
@onready var explota_sound: AudioStreamPlayer2D = $explota_sound
@onready var auch_sound: AudioStreamPlayer2D = $auch_sound

@export var takeoff_height = 500.0  # Altura que debe subir antes de quedar en idle
@export var takeoff_duration: float = 1.0  # Tiempo que tarda en subir
var is_taking_off = true  # Indica si la nave está en despegue
var start_position: Vector2  # Guarda la posición inicial

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")

#cuando parte el juego
func _ready() -> void:
	animation_tree.active = true
	label_lifes.text = str(Game.life)

func take_damage(damage: int) -> void:
	if hp > 0:
		hp -= damage
		if hp <= 0:
			explota_sound.play()
			death()
		else: 
			auch_sound.play()
			playback.travel("auch")

func death() -> void:
	Game.life -= 1
	label_lifes.text = str(Game.life)
	if Game.life <= 0:
		get_tree().change_scene_to_file("res://ui/game_over.tscn")
	
	set_physics_process(false)
	playback.travel("die")
	await animation_tree.animation_finished
	queue_free()
	Debug.log("Use ESC for Restart!")
	
#en cada segundo
func _process(delta: float) -> void:
	pass
	

func _physics_process(delta: float) -> void:
	var direction = Input.get_axis("move_left", "move_right")  # Usa las teclas izquierda/derecha
	velocity.x = direction * max_speed
	#al final:
	move_and_slide()
	
	if Input.is_action_just_pressed("attack"):
		playback.travel("attack")
		return
	
	# Animation : 
	if velocity.x > 0.0: 
		playback.travel("move_right")
	elif velocity.x < 0.0:
		playback.travel("move_left")
	else:
		playback.travel("idle")
	
	
func _input(event: InputEvent) -> void:
	pass
	
func fire() -> void:
	disparo_sound.play()
	var bullet_inst_left = bullet_player_scene.instantiate()
	get_parent().add_child(bullet_inst_left)
	bullet_inst_left.global_position = bullet_spawn_left.global_position + Vector2(0, -10)  # Ajustar la posición inicial
	bullet_inst_left.global_rotation = 0
	
	var bullet_inst_right = bullet_player_scene.instantiate()
	get_parent().add_child(bullet_inst_right)
	bullet_inst_right.global_position = bullet_spawn_right.global_position + Vector2(0, -10)  # Ajustar la posición inicial
	bullet_inst_right.global_rotation = 0
