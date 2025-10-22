extends Node2D

@export var speed:float = -1
@export var target:Node2D
var x:float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	x = target.position.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	position.x =(target.position.x - x) *speed+position.x
	x = target.position.x
func xPlus(_dummy):
	position.x= position.x +600
	
func xMinus(_dummy):
	position.x= position.x -600
