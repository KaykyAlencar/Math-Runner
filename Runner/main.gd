extends Node

@export var currentDoor:QuizDoor


#Since the question label is not part of the door, it's reference should probably go here
@export var questionLabel:Label

#This is called automatically once all other nodes are added to the scene
func _ready():
  prepare_door()


func prepare_door():
  
  #Set the question
  questionLabel.text = currentDoor.get_random_question()

  currentDoor.present_question()
  #Connect the answer signal to the reaction, but make it so it only fires once.
  currentDoor.answer_chosen.connect(on_answer_chosen, CONNECT_ONE_SHOT)

  
func on_answer_chosen(answer:String):

  #The question should still be in the label
  var currentQuestion:String = questionLabel.text

  
  if currentDoor.get_answer_to_question( currentQuestion ) == answer:
   print("Correct")
  else:
   print("Wrong")
   get_tree().change_scene_to_file("res://Main.tscn")

  #Depending on how the stage moves, you may have to change the shift in position
  #This just moves it "forward" by 40 units.
  currentDoor.position += Vector3.BACK * 40 

  #Prepare the next set of doors as well as the question.
  prepare_door()
