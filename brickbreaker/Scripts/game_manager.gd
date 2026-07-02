extends Node

var BallsOnScreen = 1 # počet ballů na obrazovce
var isSoundOn = true	
var isMusicOn = true

signal OnVictory
signal OnDeath

@export var game_ui : Control

@onready var explosion_stream_player: AudioStreamPlayer = $ExplosionStreamPlayer
@onready var death_stream_player: AudioStreamPlayer = $DeathStreamPlayer
@onready var theme_stream_player: AudioStreamPlayer = $ThemeStreamPlayer
@onready var victory_stream_player: AudioStreamPlayer = $VictoryStreamPlayer
@onready var death_timer: Timer = $DeathTimer



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Engine.time_scale = 0 # Při zapnutí hry se nastaví čas na 0 aby se mohl hráč připravit
	isSoundOn = true
	isMusicOn = true
		
	OnVictory.connect(game_ui.ToggleVictoryPanel)	
	OnDeath.connect(game_ui.ToggleDeathPanel)	
	
	#
	#BUDE SE MUSET ASI ZMĚNIT!! zapíná zvuk, aby při restartu fungovalo pause menu
	AudioServer.set_bus_mute(2, not isMusicOn)
	AudioServer.set_bus_mute(1, not isMusicOn)
	




func AddBall():
	#Create new ball(position)
	BallsOnScreen = BallsOnScreen + 1
	
#Vymaže ball z počtu ballů na obrazovce
func DecreaseBallNumber():
	BallsOnScreen = BallsOnScreen - 1
	explosion_stream_player.play()
	CheckBalls()
	
func CheckBalls():
	if BallsOnScreen == 0:
		#Popup game over screen with retry
		death_timer.start()
		print("GAME OVER")


func ToggleMusic(): 
	isMusicOn = not isMusicOn
	AudioServer.set_bus_mute(2, not isMusicOn)


func ToggleSound():
	isSoundOn = not isSoundOn
	AudioServer.set_bus_mute(1, not isSoundOn)	


func Death():
	Globals.canPauseMenuToggle = false
	Globals.gameStart = false
	OnDeath.emit()
	theme_stream_player.stream_paused = true
	death_stream_player.play()


func Victory():
	print("Victory!")
	theme_stream_player.stream_paused = true
	Engine.time_scale = 0
	victory_stream_player.play()
	Globals.canPauseMenuToggle = false
	Globals.gameStart = false
	OnVictory.emit()


func _on_death_timer_timeout() -> void:
	Death()


func _on_play_timer_timeout() -> void:
	Engine.time_scale = 1
	Globals.canPauseMenuToggle = true	
	Globals.gameStart = true	


func _on_theme_stream_player_finished() -> void:
	theme_stream_player.play()
