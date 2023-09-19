extends Node3D

#0.15 matches door's movement speed
@export var speed:float = 0.15

#How far should the mesh move before dissapearing, 
@export var dissapearDistance:float = 200

#Set this to the length of the mesh (it's size in the x axis) i think it is 100
@export var groundSpacing:float

#To remember that it already created another
var canDuplicate:bool = true

@warning_ignore("unused_parameter")
func _process(delta:float):
	position += Vector3.RIGHT * speed

	#If this one hasn't duplicated yet and is far enough for the next part to appear.
	if canDuplicate and position.x > groundSpacing: 
		#Add another
		spawn_next()
		
		#Prevent any more duplicates from this one.
		canDuplicate = false
	
	#If past the dissapearing distance
	if position.x > dissapearDistance:
	
		#Delete self
		queue_free()
		
func spawn_next():

	#Create a new duplicate of this one.
	var newGround:Node3D = self.duplicate(  DUPLICATE_SCRIPTS + DUPLICATE_GROUPS + DUPLICATE_SIGNALS  )
	
	#Center the copy back at it's original position.
	newGround.position = Vector3.ZERO
	
	#Let this copy duplicate when it has to
	newGround.canDuplicate = true
	
	#Add it
	add_sibling(newGround)
