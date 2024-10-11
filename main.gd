extends Node

@export var car_scene: PackedScene
var score

func new_game():
	score = 0
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Racer.init($StartPosition.position)
	$StartTimer.start()

func game_over():
	get_tree().call_group("cars", "queue_free")
	$ScoreTimer.stop()
	$CarTimer.stop()
	$HUD.show_game_over()

func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_start_timer_timeout():
	$CarTimer.start()
	$ScoreTimer.start()
	$Racer.start()

func _on_car_timer_timeout():
	var car = car_scene.instantiate()
	
	var car_spawn_location = $CarPath/CarSpawnLocation
	car_spawn_location.progress_ratio = randf()

	car.position = car_spawn_location.position
	
	var velocity = Vector2(0, randf_range(150, 250))
	car.linear_velocity = velocity
	
	add_child(car)
