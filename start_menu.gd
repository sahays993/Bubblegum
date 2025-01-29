extends Control

@onready var menu = $mainmenu_buttons
@onready var options = $options
@onready var video = $Video
@onready var audio = $Audio

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):  # 'ui_cancel' is bound to the Esc key by default
		go_to_main_menu()

func toggle() -> void:
	self.visible = not self.visible
	get_tree().paused = self.visible

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://screen/level1.tscn")

func _on_options_pressed() -> void:
	show_and_hide(options, menu)

func show_and_hide(first: Control, second: Control) -> void:
	# Show the first UI element and hide the second
	first.show()
	second.hide()

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_audio_pressed() -> void:
	show_and_hide(audio, options)

func _on_video_pressed() -> void:
	show_and_hide(video, options)

func go_to_main_menu() -> void:
	get_tree().change_scene_to_file("res://StartMenu.tscn")
	menu.show()
	options.hide()
	video.hide()
	audio.hide()


func _on_backfromoptions_pressed() -> void:
	go_to_main_menu()


func _on_backfromvideo_pressed() -> void:
	go_to_main_menu()


func _on_backfromaudio_pressed() -> void:
	go_to_main_menu()
