extends Node3D #Door

#To help with autocompletion
class_name QuizDoor

@export var speed = 0.15

@warning_ignore("unused_parameter")
func _process(delta):
	position += Vector3 (speed, 0, 0)
#@export variables can be set from the editor, in the inspector.  
#The format is "@export var" followed by the name of the variable, then  
#separated by a ":", the type that will reside in the variable.  
#If the type is of "Node" (or a descendant of it) you can set a reference to it with the variable

#Label is a descendant from Node
@export var labelWithProblem:Label  
@export var labelWithAnswerOne:Label3D      
@export var labelWithAnswerTwo:Label3D
@export var labelForAnswerOne:Label3D
@export var labelForAnswerTwo:Label3D      
  
#A Dictionary can contain any amount of pairs of keys and values.   
#Each element in a pair is separated by a ":" and the pair terminated with a ","    
@export var questions:Dictionary = {  
"What is 23x-1?" : "-23",  
"100x0.5?" : "50",  

}    

#Some examples of functions  
#The "->String" indicates this function equals (returns) a string (which is what you'd use it for in this case), it will warn you if it doesn't.  
func get_random_question()->String:   

	#.keys() is a function from Dictionary, it equals an Array of the keys in it  
	#.pick_random() is a function from Array, it returns a random element inside of it.
	var randomQuestion:String = questions.keys().pick_random()     

	return randomQuestion
	
  

func get_answer_to_question(question:String)->String:     

	#To get a value from a dictionary using it's key, you put the key inside []'s
	var answer:String = questions[question]          

	return answer  

func get_wrong_answer(question:String)->String:      

	#You can specify what elements an Array can contain by putting it inside []'s  

	var answers:Array[String] = questions.values()    

	#Remove the correct answer from the list  
	answers.erase( get_answer_to_question(question) )	  
	return answers.pick_random()

func present_question():      
	var question:String = get_random_question()  


	#randi() % 1 equals a random number between 0 and 1 
	if randi() % 1 == 1:  
		labelForAnswerOne.text = get_answer_to_question( question )  
		labelForAnswerTwo.text = get_wrong_answer( question )    
	else:
		labelForAnswerTwo.text = get_answer_to_question( question )
		labelForAnswerOne.text = get_wrong_answer( question )    


func is_answer_to_question(answer:String, question:String)->bool:  
	if questions[question] == answer:   
		return true  
	else:  
		return false



#Signal that the Main node can use to know what was selected
#This signal carries the answer with it
signal answer_chosen(answer:String)

#For easy access to the areas, like with the labels
@export var labelOneDetector:Area3D
@export var labelTwoDetector:Area3D

#Connecting the areas to the labels
func _ready():
	labelOneDetector.body_entered.connect(on_label_one_chosen)

	labelTwoDetector.body_entered.connect(on_label_two_chosen)

#And functions to react to their activation
func on_label_one_chosen( _whatever ):
	answer_chosen.emit(labelWithAnswerOne.text)

func on_label_two_chosen( _whatever ):
	answer_chosen.emit(labelWithAnswerTwo.text)
