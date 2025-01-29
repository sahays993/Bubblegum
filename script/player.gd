extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -300.0
#power ki beti
var power_cooldown = false
var block_powers = false
#power var
var float_speed = -60
var is_floating = false  # Whether the player is floating
var float_duration = 2.0  # Maximum duration of floating in seconds
var float_timer = 0.0  # Timer to track how long the player has been floating
var float_queued = false  # Whether floating is queued after pressing 'Q'

#shield variables
var shield_speed = 150
var shield_is_up = false
var shield_duration = 1.0
var shield_timer = 0.0
var shield_queued = false

#Maut
var is_dead = false

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var float_power = $"%float"
@onready var all_interactions = []
@onready var InteractLabel = $"Interaction Components/interaction label"
@onready var float_stimer = $FloatTimer  # Reference to the Timer node
@onready var shield_power = $"%shield"
@onready var shield_stimer = $Shield_Timer
@onready var cd_timer = $cdTimer



var gravity = 500


# Called when the node enters the scene tree for the first time.
func _ready():
	float_power.hide()
	float_timer = 0.0
	float_stimer.connect("timeout", Callable(self,"_on_FloatDelayTimer_timeout"))
	shield_power.hide()
	shield_timer = 0.0
	shield_stimer.connect("timeout", Callable(self,"_on_ShieldDelayTimer_timeout"))
	cd_timer.connect("timeout", Callable(self,"_on_CooldownTimer_timeout"))
	is_dead = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float):
	if not is_on_floor():
		velocity.y += gravity*delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	var direction = Input.get_axis("move_left","move_right")
	
	if direction>0:
		animated_sprite.flip_h = false
	elif direction<0:
		animated_sprite.flip_h = true
	
	if shield_is_up:
		shield_power.play("dhaal")
		velocity.x = shield_speed
		shield_timer += delta
		
	if shield_timer >= shield_duration:
		shield_is_up = false
		shield_power.hide()
		shield_timer = 0.0
		block_powers = false
	if not block_powers and not power_cooldown:
		if Input.is_action_just_pressed("shield_button") and not shield_is_up and not shield_queued:
			queue_shield()
			block_powers = true
		if Input.is_action_just_pressed("float_power") and not is_floating and not float_queued:
			queue_floating()
			block_powers  = true
		
		
		
		
		
	if is_floating:
		float_power.play("upar")
		velocity.y = float_speed  # Apply upward force for floating
		float_timer += delta  # Count how long the player has been floating
		# Stop floating if the duration has been exceeded
	if float_timer >= float_duration:
		is_floating = false
		float_power.hide()
		float_timer = 0.0
		block_powers = false
	else:
		# Apply gravity if not floating
		velocity.y += gravity * delta
	# Start floating when the 'Q' key is pressed
	
		#_____________________________
	if is_dead:
		return # Stop everything if the player is dead !
		#-----------------------------
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle_b")
		else:
			animated_sprite.play("movement")
	else:
		animated_sprite.play("jump")
		
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()
func queue_floating():
	float_queued = true
	float_stimer.start()  # Start the delay timer
	float_power.show()
	float_power.play("phulna")  # Optional: Add pre-floating idle animation

func queue_shield():
	shield_queued = true
	shield_stimer.start()
	shield_power.show()
	shield_power.play("uthali")
func _on_ShieldDelayTimer_timeout():
	shield_is_up = true  # Start floating
	shield_queued = false  # Reset the queued state
	shield_power.play("dhaal") 
	await get_tree().create_timer(shield_duration).timeout
	block_powers = false
	start_cooldown()
	
func _on_FloatDelayTimer_timeout():
	is_floating = true  # Start floating
	float_queued = false  # Reset the queued state
	float_power.play("upar")
	await get_tree().create_timer(float_duration).timeout
	block_powers = false
	start_cooldown()
func start_cooldown() -> void:
	cd_timer.start(1.0)
	power_cooldown = true
# interaction methods
func _on_CooldownTimer_timeout()->void:
	power_cooldown = false 
	
func _on_interaction_area_area_entered(area):
	all_interactions.insert(0, area)
	update_interactions()


func _on_interaction_area_area_exited(area):
	all_interactions.erase(area)
	update_interactions()
	
func update_interactions():
	if all_interactions:
		InteractLabel.text = all_interactions[0].interact_label
	else:
		InteractLabel.text = ""


func _on_interactable_body_entered(body: Node2D) -> void:
	if body.name =="Player" :
		get_tree().change_scene_to_file("res://screen/level2.tscn")


func _on_interactable_1_body_entered(body: Node2D) -> void:
	if body.name =="Player" :
		get_tree().change_scene_to_file("res://screen/level3.tscn")


func _on_interactable_2_body_entered(body: Node2D) -> void:
	if body.name =="Player" :
		get_tree().change_scene_to_file("res://screen/level4.tscn")


func _on_interactable_3_body_entered(body: Node2D) -> void:
	if body.name =="Player" :
		get_tree().change_scene_to_file("res://screen/level5.tscn")


func _on_interactable_4_body_entered(body: Node2D) -> void:
	if body.name =="Player" :
		get_tree().change_scene_to_file("res://screen/level6.tscn")


func _on_interactable_5_body_entered(body: Node2D) -> void:
	if body.name =="Player" :
		get_tree().change_scene_to_file("res://screen/level7.tscn")


func _on_interactable_6_body_entered(body: Node2D) -> void:
	if body.name =="Player" :
		get_tree().change_scene_to_file("res://screen/level8.tscn")


func _on_interactable_7_body_entered(body: Node2D) -> void:
	if body.name =="Player" :
		get_tree().change_scene_to_file("res://screen/level9.tscn")


func _on_interactable_8_body_entered(body: Node2D) -> void:
	if body.name =="Player" :
		get_tree().change_scene_to_file("res://screen/level10.tscn")


func _on_interactable_9_body_entered(body: Node2D) -> void:
	if body.name =="Player" :
		get_tree().change_scene_to_file("res://screen/level11.tscn")


func _on_interactable_10_body_entered(body: Node2D) -> void:
	if body.name =="Player" :
		get_tree().change_scene_to_file("res://screen/level12.tscn")
		
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):  # 'ui_cancel' is bound to the Esc key by default
		get_tree().change_scene_to_file("res://StartMenu.tscn")

func _on_killzone_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print('You died')
		is_dead = true
		animated_sprite.play("Death")
		await get_tree().create_timer(1.5).timeout
		get_tree().reload_current_scene()

func _on_killzone_body_entered_4(body: Node2D) -> void:
	if body.name == "Player":
		print('You died')
		is_dead = true
		animated_sprite.play("Death")
		await get_tree().create_timer(1.5).timeout
		get_tree().reload_current_scene()

func _on_killzone_body_entered_5(body: Node2D) -> void:
	if body.name == "Player":
		print('You died')
		is_dead = true
		animated_sprite.play("Death")
		await get_tree().create_timer(1.5).timeout
		get_tree().reload_current_scene()
