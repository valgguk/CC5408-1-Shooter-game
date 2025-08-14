class_name EnemyLips
extends CharacterBody2D

@export var speed = 300.0
@export var down_velocity = 400.0
@export var hp = 20

@onready var die_sound: AudioStreamPlayer2D = $die_sound

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
		playback.travel("auch")
	
func death() -> void:
	set_physics_process(false)
	playback.travel("die")
	await animation_tree.animation_finished
	queue_free()
	
	
func _physics_process(delta: float) -> void:
	move_and_slide()
