extends CharacterBody2D

var game_manager: Node
@export var Speed : float = 500
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var start_timer: Timer = $StartTimer
@onready var death_timer: Timer = $DeathTimer


var rng : RandomNumberGenerator

func _ready() -> void:
	game_manager = get_node("%GameManager")
	
	
func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		CollisionHandling(collision)
	
	


#Začne process zničení bally
func Delete():
	game_manager.DecreaseBallNumber()
	velocity = Vector2(0,0)
	death_timer.start()
	

func DestroyBall():
	queue_free()

func _on_timer_timeout() -> void:
	rng = RandomNumberGenerator.new()
	velocity = Vector2(rng.randf_range(-200.0, 200.0), rng.randf_range(-200.0, -100)).normalized() * Speed


func _on_death_timer_timeout() -> void:
	DestroyBall()


func CollisionHandling(collision : KinematicCollision2D):
	audio_stream_player.pitch_scale = rng.randf_range(0.8,1.2)
	audio_stream_player.play()
	
	velocity = velocity.bounce(collision.get_normal())
	
	var collidedObject = collision.get_collider()
	
	if collidedObject.is_in_group("Brick") and collidedObject.has_method("HitBrick"):
		# Získání globální pozice kolize
		var collision_position = collision.get_position()
		
		# Získání normály kolize
		var normal = collision.get_normal()
		
		# Úprava pozice pro přesnou detekci buňky v TileMap
		var adjusted_position = collision_position - normal * 0.1
		# Převod na lokální souřadnice TileMap
		var tilemap_local_pos = collidedObject.to_local(adjusted_position)
		# Získání souřadnic buňky v TileMap
		var tile_coords = collidedObject.local_to_map(tilemap_local_pos)
		
		# Volání metody pro zničení cihly
		collidedObject.HitBrick(tile_coords)
