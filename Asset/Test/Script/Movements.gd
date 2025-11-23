extends CharacterBody2D

@export var animatedSprite:AnimatedSprite2D

var isWalking:bool = false
var isRunning:bool = false
var jumpTime:float=5
@export var TempsSautMax:float=0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _physics_process(_delta: float) -> void:
	if !animatedSprite.is_playing():
		if animatedSprite.animation == "jump_end":
			animatedSprite.animation = &"default"
			isWalking = false
			isRunning = false
			
		if animatedSprite.animation == "jump_start":
			animatedSprite.animation = "jumpidk"

		animatedSprite.play(animatedSprite.animation)

	var deplacement: Vector2
	
	var isNeedToWalk:bool = false
	var isNeedToRun:bool = false
	if Input.is_action_pressed("Droite"):
		if animatedSprite.animation != "jumpidk" && animatedSprite.animation != "jump_start" && animatedSprite.animation != "jump_middle":
			isNeedToWalk = true
			isNeedToRun = false
		deplacement.x+= 50
		
	if Input.is_action_pressed("Gauche"):
		if animatedSprite.animation != "jumpidk" && animatedSprite.animation != "jump_start" && animatedSprite.animation != "jump_middle":
			isNeedToWalk = true
			isNeedToRun = false
		deplacement.x-= 50
		
		
	if Input.is_action_pressed("Gauche") && Input.is_action_pressed("Shift"):
		if animatedSprite.animation != "jumpidk" && animatedSprite.animation != "jump_start" && animatedSprite.animation != "jump_middle":
			isNeedToRun = true
			isNeedToWalk = false
		deplacement.x-= 51
		
		
	if Input.is_action_pressed("Droite") && Input.is_action_pressed("Shift"):
		if animatedSprite.animation != "jumpidk" && animatedSprite.animation != "jump_start" && animatedSprite.animation != "jump_middle":
			isNeedToRun = true
			isNeedToWalk = false
		deplacement.x+= 51
		
		isRunning = isNeedToRun
		if isRunning:
			animatedSprite.animation = "Run"
		else:
			animatedSprite.animation = &"default"
	
	if isWalking != isNeedToWalk:
		isWalking = isNeedToWalk
		if isWalking:
			animatedSprite.animation = "Walk"
		else:
			animatedSprite.animation = &"default"
			
			
	if deplacement.x != 0 && deplacement.y == 0:
		if animatedSprite.animation != "jumpidk" && animatedSprite.animation != "jump_start" && animatedSprite.animation != "jump_middle":
			if Input.is_action_pressed("Shift"):
				animatedSprite.animation = ("Run")
			else:
				animatedSprite.animation = ("Walk")
	
	if animatedSprite.animation == ("jump_middle") && Input.is_action_pressed("Jump") && deplacement.y != 0:
		if animatedSprite.animation != "jumpidk" && animatedSprite.animation != "jump_start" && animatedSprite.animation != "jump_middle":
			animatedSprite.animation = ("jumpidk")
			
	if animatedSprite.animation == ("jump_end") && deplacement.x != 0:
		animatedSprite.animation = ("jump_end_walk")
	
	jumpTime -= _delta
			
	if animatedSprite.animation == &"default" || animatedSprite.animation == "Walk" || animatedSprite.animation == "Run":
		jumpTime = TempsSautMax
		
	if Input.is_action_pressed("Jump") && jumpTime >0:
		deplacement.y -= 80
		
	else: 
		deplacement.y += 80
		jumpTime = 0
	velocity = deplacement
	move_and_slide()
	if velocity.y < 0 && animatedSprite.animation!="jumpidk":
			animatedSprite.animation = "jump_start"
	if velocity.y > 0:
			animatedSprite.animation = "jump_middle"
	if velocity.x > 0:
		animatedSprite.scale.x = 1
		
	if velocity.x < 0:
		animatedSprite.scale.x = -1
		
	if velocity.y == 0:
		if animatedSprite.animation == "jump_middle":
			animatedSprite.animation = "jump_end"
			
	if velocity.y == 0:
		if animatedSprite.animation == "jumpidk":
			animatedSprite.animation = "jump_end"
