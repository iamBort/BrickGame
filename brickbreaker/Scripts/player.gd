extends CharacterBody2D

@export_group("Script Properties")
@export_range(100, 1000, 5, "Speed") var SPEED : float = 500.0

var positionOrigin : Vector2

func _ready() -> void:
	positionOrigin = position
	
func _process(delta: float) -> void:
	self.transform.origin.y = positionOrigin.y #Drží hráče ve stejné rovině

func _physics_process(delta: float) -> void:
	#pokud hra nezačala, tak se hráč nebude moci hýbat
	if not Globals.gameStart:
		return

	Move()

# Spravuje pohyb
func Move():
	var direction := Input.get_axis("Left", "Right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
