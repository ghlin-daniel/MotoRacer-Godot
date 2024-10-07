extends Area2D
signal hit

@export var speed = 200
var screen_size

func start(pos):
	position = pos


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size= get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1

	position += velocity * delta * speed
	position = position.clamp(Vector2.ZERO, screen_size)


func _on_body_entered(body: Node2D) -> void:
	hit.emit()
