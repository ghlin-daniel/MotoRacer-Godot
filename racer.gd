extends Area2D
signal hit

@export var speed = 200
var left_top_bound = Vector2(30, 0)
var right_bottom_bound

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _ready():
	var screen_size = get_viewport_rect().size
	right_bottom_bound= Vector2(screen_size.x - 30, screen_size.y)

func _process(delta: float):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1

	position += velocity * delta * speed
	position = position.clamp(left_top_bound, right_bottom_bound)


func _on_body_entered(body: Node2D):
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
