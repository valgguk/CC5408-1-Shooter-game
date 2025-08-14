class_name HurtboxEnemy
extends Area2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	#Debug.log(area)
	#verifico que sea hitbox, si no es -> area = null
	var hitbox_player = area as HitboxPlayer
	if hitbox_player:
		var damage: int = hitbox_player.damage
		#Debug.log(hitbox_player)
		#Debug.log(damage)
		if owner:
			#Debug.log(owner.get_class())
			if owner.has_method("take_damage"):
				#Debug.log("El owner tiene el método take_damage()")
				owner.take_damage(damage)
			#else:
				#Debug.log("ERROR: El owner NO tiene el método take_damage()")
		else:
			Debug.log("ERROR: Owner es NULL")
			
			
	#else:
		#Debug.log("El área detectada NO es un HitboxPlayer")
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
