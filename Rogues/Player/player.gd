extends CharacterBody2D

@export var speed : int = 50
@onready var animation = $AnimationPlayer

@export var max_health = 5
@onready var currentHealth: int = max_health
@onready var weapon = $Node2D


var is_attacking = false


func handleInput():
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = moveDirection*speed
	
	if Input.is_action_just_pressed("attack"):
		animation.play("attack_direita")
		is_attacking = true
		weapon.enable()
		await animation.animation_finished
		weapon.disable()
		is_attacking = false
	
func updateAnimation():
	if is_attacking: return
		
	if velocity.length() == 0:
		animation.stop()
	else:
		animation.play("idle")
		
func handle_colision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
	
func _physics_process(delta):
	handleInput()
	move_and_slide()
	handle_colision()
	updateAnimation()
	


func _on_hurtbox_area_entered(area):
	if area.name == "hitbox":
		currentHealth -= 1
		print_debug(currentHealth)
		if currentHealth == 0:
			get_tree().quit()
		
