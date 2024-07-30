extends Area2D


@onready var player = get_node("../Player")


@export var radiation_level = 5

#
#func _ready():
	#body_entered.connect(_on_body_entered)
	#body_exited.connect(_on_body_exited)
#
#
#func _process(delta):
	#pass
#
#
#func _on_body_entered(body):
	#if body == player:
		#player.geiger_counter_level += radiation_level
#
#func _on_body_exited(body):
	#if body == player:
		#player.geiger_counter_level -= radiation_level
