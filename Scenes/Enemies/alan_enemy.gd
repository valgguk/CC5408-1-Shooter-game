class_name EnemyAlan
extends CharacterBody2D

@export var speed = 300.0
@export var down_velocity = 400.0
@export var hp = 20

@onready var auch_sound: AudioStreamPlayer2D = $auch_sound
@onready var die_sound: AudioStreamPlayer2D = $die_sound


@export var bullet_enemy_scene: PackedScene
@onready var bullet_spawn: Marker2D = $BulletSpawn

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")

#cuando parte el juego
func _ready() -> void:
	animation_tree.active = true
	
func take_damage(damage: int) -> void:
	hp -= damage
	if hp <= 0:
		die_sound.play()
		death()
	else: 
		auch_sound.play()
		playback.travel("auch")
		fire() #re-ataque potente 
	
func death() -> void:
	set_physics_process(false)
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
