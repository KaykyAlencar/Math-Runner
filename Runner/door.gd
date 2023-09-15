extends StaticBody3D

@export var speed = 1


func _process(delta):
	position += Vector3 (0.15, 0, 0)
