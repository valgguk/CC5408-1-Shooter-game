extends HitboxPlayer

@export var max_speed = 1000
@onready var timer: Timer = $Timer

func _physics_process(delta: float) -> void:
	position.y -= max_speed * delta  # Movimiento hacia arriba

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame  # Esperar un frame antes de habilitar colisiones
	body_entered.connect(_on_body_entered)
	timer.timeout.connect(queue_free)

func _on_body_entered(body: Node) -> void:
	if body is Player:
		return
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
