extends Control

var game_manager : Node

@onready var pause_menu: Panel = $PauseMenu
@onready var victory_panel: Panel = $VictoryPanel
@onready var music_button: Button = $PauseMenu/MusicButton
@onready var sound_button: Button = $PauseMenu/SoundButton
@onready var death_panel: Panel = $DeathPanel

@onready var SOUND_OFF = preload("res://Sprites/sound-off.svg")
@onready var SOUND_ON = preload("res://Sprites/sound-on.svg")
@onready var SPEAKER = preload("res://Sprites/speaker.svg")
@onready var SPEAKER_OFF = preload("res://Sprites/speaker-off.svg")

var isPauseMenuOn = false	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_manager = get_node("%GameManager")
	
	pause_menu.visible = false
	isPauseMenuOn = false
	
	#game_manager.Victory.connect(ToggleVictoryPanel)	
	#game_manager.Death.connect(ToggleDeathPanel)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#PauseMenu listener
	if Input.is_action_just_pressed("PauseMenu") and Globals.canPauseMenuToggle:
		TogglePauseMenu()


#Pausemenu handler
func TogglePauseMenu():
	if isPauseMenuOn:
		pause_menu.visible = false
		isPauseMenuOn = false
		Engine.time_scale = 1
	else:
		pause_menu.visible = true
		isPauseMenuOn = true
		Engine.time_scale = 0


#Continue button handler
func _on_continue_button_button_down() -> void:
	TogglePauseMenu()

#Reset scény a nastaví čas na 1
func _on_reset_button_button_down() -> void:
	get_tree().reload_current_scene()
	Engine.time_scale = 1
	

#Vypne hru 
func _on_quit_button_button_down() -> void:
	get_tree().quit()


#Vypne nebo zapne hudbu
func _on_music_button_button_down() -> void:
	if game_manager.isMusicOn:
		music_button.icon = SOUND_OFF
	else:	
		music_button.icon = SOUND_ON
		
	game_manager.ToggleMusic()


#Vypne nebo zapne zvuky
func _on_sound_button_button_down() -> void:
	if game_manager.isSoundOn:
		sound_button.icon = SPEAKER_OFF
	else:	
		sound_button.icon = SPEAKER

	game_manager.ToggleSound()
	
	
func ToggleVictoryPanel():
	victory_panel.visible = not victory_panel.visible


func ToggleDeathPanel():
	print("Death panel fire")
	death_panel.visible = not death_panel.visible

func _on_victory_reset_button_button_down() -> void:
	get_tree().reload_current_scene()
	pass # Replace with function body.
