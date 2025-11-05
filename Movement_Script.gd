extends CharacterBody2D

@export var animatedSprite:AnimatedSprite2D
var jumpTime:float=5
var jumpWaitTime:float=5
var dashTime:float=0.4
var dashWaitTime:float=5
var midleTime:float=5
@export var Defealt_Jump_Time:float = 1
@export var Defealt_Dash_Time:float =1
var IsJumping:bool
var IsRunning:bool
var IsDashing:bool
var IsWalking
@export var CollisionStanding: CollisionPolygon2D
@export var CollisionCrouch: CollisionPolygon2D
@export var CollisionDetectorHead: bool

enum MoveState {IsWalking,IsJumping,Idle,IsRunning,IsDashing}
var CurrentState
var LastState

enum Direction {Left,Middle,Right}
var CurrentDir
var LastDir


func ChangeState(NewState):
	LastState = CurrentState
	CurrentState = NewState

func ChangeDir(NewDir):
	LastDir = CurrentDir
	CurrentDir = NewDir

func _process(_delta: float) -> void:
	var deplacement: Vector2
	var is_crouching: bool = false
	print("State : " + str(CurrentState))
	print("Dir : " + str(CurrentDir))
	if velocity.x == 0:
		ChangeState(MoveState.Idle)
	
	if Input.is_action_pressed("Control"):
		is_crouching = true
	else:
		is_crouching = false
		
	if CollisionDetectorHead:
		is_crouching = true
	
	
	if Input.is_action_pressed("Droite"):
		
		ChangeState(MoveState.IsWalking)
		ChangeDir(Direction.Right)
		
		if is_crouching == false:
			deplacement.x+= 70
		else:
			deplacement.x+= 30
		
	if Input.is_action_pressed("Gauche"):
		
		ChangeState(MoveState.IsWalking)
		ChangeDir(Direction.Left)
		if is_crouching == false:
			deplacement.x-= 70
		else:
			deplacement.x-= 30

	if Input.is_action_pressed("Shift"):
		if is_crouching == false:
			if CurrentDir == (Direction.Left):
				deplacement.x-= 50
			if CurrentDir == (Direction.Right):
				deplacement.x+= 50

	CollisionStanding.disabled = is_crouching
	CollisionCrouch.disabled = not is_crouching
	
	if Input.is_action_pressed("Shift") && Input.is_action_pressed("Control") && dashTime >0:
		var direction : int
		
		if CurrentDir == Direction.Left:
			direction = -1
		elif CurrentDir == Direction.Right:
			direction = 1
		elif CurrentDir == Direction.Middle: direction = 0
		
		deplacement.x+=150 * direction *dashTime/0.4
		
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
		
	
	if CurrentState == MoveState.Idle:
		if CurrentDir == Direction.Left:
			animatedSprite.play("Idle_Left")
		elif CurrentDir == Direction.Right:
			animatedSprite.play("Idle_Right")

	
	if CurrentState == MoveState.IsWalking:
		
		if CurrentDir == Direction.Left:
			if LastDir == Direction.Right:
				ChangeDir(Direction.Middle)
				animatedSprite.play("Idle_Middle")
			elif LastDir == Direction.Left && animatedSprite.animation_finished:
				animatedSprite.play("WalkLeft")
				
		if CurrentDir == Direction.Right:
			if LastDir == Direction.Left:
				ChangeDir(Direction.Middle)
				animatedSprite.play("Idle_Middle")
			elif LastDir == Direction.Right && animatedSprite.animation_finished:
				animatedSprite.play("WalkRight")
	
		if animatedSprite.animation_finished:
			
			if LastState == MoveState.IsWalking:
				if LastDir == Direction.Left:
					ChangeDir(Direction.Left)
				if LastDir == Direction.Right:
					ChangeDir(Direction.Right)
