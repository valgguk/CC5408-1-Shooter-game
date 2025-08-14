class_name EnemyBonbon
extends CharacterBody2D

@export var speed = 300.0
@export var down_velocity = 400.0
@export var hp = 10

@export var bullet_enemy_scene: PackedScene
@onready var bullet_spawn: Marker2D = $BulletSpawn
@onready var fire_timer: Timer = $FireTimer

@onready var die_sound: AudioStreamPlayer2D = $die_sound

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")

#cuando parte el juego
func _ready() -> void:
	animation_tree.active = true
	# Conectamos el timer
	fire_timer.timeout.connect(_on_fire_timer_timeout)
	# Configuramos el primer tiempo aleatorio y lo activamos
	_set_random_fire_interval()
	fire_timer.start()
	
func _on_fire_timer_timeout() -> void:
	fire()
	_set_random_fire_interval()
	fire_timer.start()  # Reinicia el timer con el nuevo intervalo

func _set_random_fire_interval() -> void:
	# Escoge un tiempo aleatorio entre 0.5 y 2 segundos
	fire_timer.wait_time = randf_range(0.5, 5.0)

func take_damage(damage: int) -> void:
	hp -= damage
	if hp <= 0:
		die_sound.play()
		death()
	else: 
		playback.travel("auch")
	
func death() -> void:
	set_physics_process(false)
	fire_timer.stop() 
	playback.travel("die")
	await animation_tree.animation_finished
	queue_free()

func _physics_process(delta: float) -> void:
	move_and_slide()
	
func fire() -> void:
	var bullet_inst = bullet_enemy_scene.instantiate()
	get_parent().add_child(bullet_inst)
	bullet_inst.global_position = bullet_spawn.global_position + Vector2(0, 10)  # Ajustar la posición inicial
	bullet_inst.global_rotation = deg_to_rad(180)
