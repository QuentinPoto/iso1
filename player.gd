extends KinematicBody2D

# est dans le meme ordre que les sprites d'animation de Kenney
enum direction {
	UP_RIGHT,
	RIGHT,
	DOWN_RIGHT,
	DOWN,
	DOWN_LEFT
	LEFT,
	UP_LEFT,
	UP,
}

export (int) var speed = 500
onready var _animated_sprite = $AnimatedSprite
var last_direction = direction.DOWN
var velocity = Vector2()

func _ready():
	_animated_sprite.play("0_standing")
	_animated_sprite.stop()

func get_input():
    velocity = Vector2()
    if Input.is_action_pressed("ui_right"):
        velocity.x += 1
    if Input.is_action_pressed("ui_left"):
        velocity.x -= 1
    if Input.is_action_pressed("ui_down"):
        velocity.y += 1
    if Input.is_action_pressed("ui_up"):
        velocity.y -= 1
    velocity = velocity.normalized() * speed

func _physics_process(delta):
    get_input()
    velocity = move_and_slide(velocity)

func animation():
	if Input.is_action_pressed("ui_up") && Input.is_action_pressed("ui_right"):
		last_direction = direction.UP_RIGHT
	elif Input.is_action_pressed("ui_up") && Input.is_action_pressed("ui_left"):
		last_direction = direction.UP_LEFT
	elif Input.is_action_pressed("ui_down") && Input.is_action_pressed("ui_right"):
		last_direction = direction.DOWN_RIGHT
	elif Input.is_action_pressed("ui_down") && Input.is_action_pressed("ui_left"):
		last_direction = direction.DOWN_LEFT
	elif Input.is_action_pressed("ui_right"):
		last_direction = direction.RIGHT
	elif Input.is_action_pressed("ui_up"):
		last_direction = direction.UP 
	elif Input.is_action_pressed("ui_left"):
		last_direction = direction.LEFT 
	elif Input.is_action_pressed("ui_down"):
		last_direction = direction.DOWN
	
	if Input.is_action_pressed("ui_down") || Input.is_action_pressed("ui_up") || \
			Input.is_action_pressed("ui_left") || Input.is_action_pressed("ui_right"):
		_animated_sprite.play(str(last_direction) + "_running")
	else:
		_animated_sprite.play(str(last_direction) + "_standing")
		_animated_sprite.stop()

func _process(_delta):
	animation()
