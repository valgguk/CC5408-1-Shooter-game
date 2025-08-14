extends HitboxEnemy

@export var max_speed = 500
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _physics_process(delta: float) -> void:
	position.y += max_speed * delta  # Movimiento hacia abajo

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("idle")
	await get_tree().process_frame  # Esperar un frame antes de habilitar colisiones
	body_entered.connect(_on_body_entered)
	await get_tree().create_timer(3).timeout
	queue_free()
	

func _on_body_entered(body: Node) -> void:
	if body is EnemyAlan:
		return
	if body is EnemyBonbon:
		return
	if body is EnemyLips:
		return
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
