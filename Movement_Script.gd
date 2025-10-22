extends CharacterBody2D

@export var animatedSprite:AnimatedSprite2D
var jumpTime:float=5
var jumpWaitTime:float=5
var dashTime:float=0.4
var dashWaitTime:float=5
@export var Defealt_Jump_Time:float = 1
@export var Defealt_Dash_Time:float =1
var IsJumping:bool
var IsRunning:bool
var IsDashing:bool
var IsWalking
@export var CollisionStanding: CollisionPolygon2D
@export var CollisionCrouch: CollisionPolygon2D
@export var CollisionDetectorHead: bool
var oriantation:int =1 #-1 gauche 0 face 1 droite
enum MoveState {IsWalkingLeft,IsWalkingRight,IsJumping,Idle,IdleMiddle,IsRunning,IsDashing}
var CurrentState
var LastState

func ChangeState(NewState):
	LastState = CurrentState
	CurrentState = NewState

func _process(_delta: float) -> void:
	var deplacement: Vector2
	var is_crouching: bool = false
	print(CurrentState)
	
	if velocity.x == 0:
		ChangeState(MoveState.Idle)
	
	if Input.is_action_pressed("Control"):
		is_crouching = true
	else:
		is_crouching = false
		
	if CollisionDetectorHead:
		is_crouching = true
	
	
	if Input.is_action_pressed("Droite"):
		oriantation =1
		if LastState == MoveState.IsWalkingLeft:
			ChangeState(MoveState.IdleMiddle)
			if animatedSprite.animation_finished:
				ChangeState(MoveState.IsWalkingRight)
		else:
			ChangeState(MoveState.IsWalkingRight)
		if is_crouching == false:
			deplacement.x+= 70
		else:
				deplacement.x+= 30
	else:
		!MoveState.IsWalkingRight
		
	if Input.is_action_pressed("Gauche"):
		oriantation =-1
		if LastState == MoveState.IsWalkingRight:
			ChangeState(MoveState.IdleMiddle)
			if animatedSprite.animation_finished:
					ChangeState(MoveState.IsWalkingLeft)
		else:
			ChangeState(MoveState.IsWalkingLeft)
		if is_crouching == false:
			deplacement.x-= 70
		else:
			deplacement.x-= 30
	else:
		!MoveState.IsWalkingLeft
		
	if Input.is_action_pressed("Droite") && Input.is_action_pressed("Shift"):
		if is_crouching == false:
			deplacement.x+= 50.5
	
	if Input.is_action_pressed("Gauche") && Input.is_action_pressed("Shift"):
		if is_crouching == false:
			deplacement.x-= 50.5

	CollisionStanding.disabled = is_crouching
	CollisionCrouch.disabled = not is_crouching
	
	if Input.is_action_pressed("Shift") && Input.is_action_pressed("Control") && dashTime >0:
		deplacement.x+=150 *oriantation *dashTime/0.4
		if !IsDashing:
			IsDashing = true
			dashTime = Defealt_Dash_Time /2
			
	if IsDashing:
		dashTime -= _delta
		
	if Input.is_action_just_released("Jump") && IsJumping:
		jumpTime = 0
	
		
	if Input.is_action_pressed("Jump") && jumpTime >0:
		if is_crouching == false:
			deplacement.y -= 100 *jumpTime+100
			if !IsJumping:
				IsJumping = true 
				jumpTime = Defealt_Jump_Time /2
		else:
			deplacement.y += 100 *jumpTime+90.9
			if !IsJumping:
				IsJumping = true
				jumpTime = Defealt_Jump_Time /4
	else: 
		deplacement.y += 120
		
			
	if IsJumping:
		jumpTime -= _delta
	velocity = deplacement
	move_and_slide()
	if velocity.y == 0 && jumpTime <-0.25:
		jumpWaitTime
		IsJumping = false
		jumpTime = Defealt_Jump_Time
		
	if dashTime <-4:
		IsDashing = false
		dashTime = Defealt_Dash_Time
		
	if Input.is_action_just_released("Jump") && IsJumping:
		jumpTime = 0
		
	
	if oriantation == 1 && CurrentState == MoveState.Idle:
			animatedSprite.play("Idle_Right")
			
	if oriantation == -1 && CurrentState == MoveState.Idle:
		animatedSprite.play("Idle_Left")
		
	if CurrentState == MoveState.IdleMiddle:
		animatedSprite.play("IdleMiddle")
		
	if oriantation == -1 && CurrentState == MoveState.IsWalkingRight:
		animatedSprite.play("WalkRight")
		
	if oriantation == 1 && CurrentState == MoveState.IsWalkingLeft:
		animatedSprite.play("WalkLeft")
