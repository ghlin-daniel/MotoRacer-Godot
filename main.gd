extends Node

@export var car_scene: PackedScene
var score

func new_game():
	score = 0
	$Racer.start($StartPosition.position)
	$StartTimer.start()

func _ready() -> void:
	new_game()

func _process(delta: float):
	pass

func game_over():
	$ScoreTimer.stop()
	$CarTimer.stop()

func _on_score_timer_timeout():
	score += 1

func _on_start_timer_timeout():
	$CarTimer.start()
	$ScoreTimer.start()

func _on_car_timer_timeout():
	var car = car_scene.instantiate()
	
	var car_spawn_location = $CarPath/CarSpawnLocation
	car_spawn_location.progress_ratio = randf()

	car.position = car_spawn_location.position
	
	var velocity = Vector2(0, randf_range(150, 250))
	car.linear_velocity = velocity
	
	add_child(car)
