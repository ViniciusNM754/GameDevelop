extends CharacterBody2D

var speed : int = 90
var player_chase = false
var player = null
@onready var animation = $AnimationPlayer

@export var max_health = 10
@onready var currentHealth: int = max_health

func _physics_process(delta):
	if player_chase:
		position += (player.position - position)/ speed
		animation.play("move")



func _on_detectionarea_body_entered(body):
	player = body
	player_chase = true


func _on_detectionarea_body_exited(body):
	player = null
	player_chase = false
	animation.stop()
	


func _on_hurbox_area_entered(area):
	if currentHealth == 0:
		if area == $hitbox: return
		$hitbox.set_deferred("monitorable", false)
		queue_free()
	else:
		print_debug(currentHealth)
		currentHealth -= 1
	
