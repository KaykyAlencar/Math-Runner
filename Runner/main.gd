extends Node

@onready var restartButton:Button = $"Restart-Button"
@export var currentDoor:QuizDoor

@onready var scoreLabel:Label = $Score
var score:int

#Since the question label is not part of the door, it's reference should probably go here
@export var questionLabel:Label

#This is called automatically once all other nodes are added to the scene
func _ready():
  prepare_door()
  currentDoor.answer_chosen.connect(on_answer_chosen)
  restartButton.pressed.connect(restart)

func restart():
  get_tree().change_scene_to_file("res://main.gd")

func prepare_door():
  
  #Set the question
  questionLabel.text = currentDoor.get_random_question()

  currentDoor.present_question( questionLabel.text )
  #Connect the answer signal to the reaction, but make it so it only fires once.
  #currentDoor.answer_chosen.connect(on_answer_chosen, CONNECT_ONE_SHOT)

  
func on_answer_chosen(answer:String):

  #The question should still be in the label
  var currentQuestion:String = questionLabel.text

  #if currentDoor.answer_chosen.is_connected( on_answer_chosen ):
   #currentDoor.answer_chosen.disconnect( on_answer_chosen )

  if currentDoor.get_answer_to_question( currentQuestion ) == answer:
   print("Correct")
   #Increase the score
   score += 1 

   #Transform the score to a String and place it in the label
   scoreLabel.text = "Score: " + str(score)


  else:
   print("Wrong")
   get_tree().change_scene_to_file("res://main.tscn")
   restartButton.show()
   restartButton.disabled = false

  #Depending on how the stage moves, you may have to change the shift in position
  #This just moves it "forward" by 40 units.
  currentDoor.position += Vector3.LEFT * 40

  #Prepare the next set of doors as well as the question.
  prepare_door()




func _on_restart_button_pressed():
  pass # Replace with function body.
