extends CharacterBody2D


@onready var inventory_hud = $InventoryHUD
@onready var sprite = $AnimatedSprite2D


@export var speed = 200.0

var has_rifle = false
var is_rifle_in_hand = false

var direction = "backward"
const ANIMATION_IDLE_MAP = {
	"forward": {
		[false, false]: "idle_forward",
		[true, false]: "idle_forward_rifle_on_back",
		[true, true]: "idle_forward_rifle_in_hand",
	},
	"backward": {
		[false, false]: "idle_backward",
		[true, false]: "idle_backward_rifle_on_back",
		[true, true]: "idle_backward_rifle_in_hand",
	},
	"right": {
		[false, false]: "idle_right",
		[true, false]: "idle_right_rifle_on_back",
		[true, true]: "idle_right_rifle_in_hand",
	},
	"left": {
		[false, false]: "idle_left",
		[true, false]: "idle_left_rifle_on_back",
		[true, true]: "idle_left_rifle_in_hand",
	}
}
const ANIMATION_WALK_MAP = {
	"forward": {
		false: "walk_forward",
		true: "walk_forward_rifle_on_back",
	},
	"backward": {
		false: "walk_backward",
		true: "walk_backward",
	},
	"right": {
		false: "walk_right",
		true: "walk_right_rifle_on_back",
	},
	"left": {
		false: "walk_left",
		true: "walk_left_rifle_on_back",
	}
}

var geiger_counter_level = 0


func _physics_process(delta):
	#region Movement
	velocity = Vector2.ZERO
	if Input.is_action_pressed("move_up") and not Input.is_action_pressed("open_geiger_counter"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down") and not Input.is_action_pressed("open_geiger_counter"):
		velocity.y += 1
	if Input.is_action_pressed("move_right") and not Input.is_action_pressed("open_geiger_counter"):
		velocity.x += 1
	if Input.is_action_pressed("move_left") and not Input.is_action_pressed("open_geiger_counter"):
		velocity.x -= 1
	velocity = velocity.normalized() * speed
	move_and_slide()
	#endregion
	
	#region Sprite Animation
	if velocity.y < 0:
		direction = "forward"
	elif velocity.y > 0:
		direction = "backward"
	elif velocity.x > 0:
		direction = "right"
	elif velocity.x < 0:
		direction = "left"
		
	if not sprite.animation == "watch_geiger_counter" or (sprite.animation == "watch_geiger_counter" and not sprite.is_playing() and sprite.frame == 0):
		sprite.animation = ANIMATION_WALK_MAP.get(direction).get(has_rifle)
		if velocity == Vector2.ZERO:
			sprite.animation = ANIMATION_IDLE_MAP.get(direction).get([has_rifle, is_rifle_in_hand])
		sprite.play()
	#endregion
	
	#region Geiger Counter Animation and HUD
	if Input.is_action_just_pressed("open_geiger_counter"):
		inventory_hud.open_geiger_counter()
		sprite.play("watch_geiger_counter")
		
	elif Input.is_action_just_released("open_geiger_counter"):
		inventory_hud.close_geiger_counter()
		sprite.play_backwards("watch_geiger_counter")
	#endregion
	
