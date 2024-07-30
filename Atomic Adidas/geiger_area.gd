extends Node2D


@onready var geiger_area_1 = $GeigerArea1
@onready var geiger_area_2 = $GeigerArea2
@onready var geiger_area_3 = $GeigerArea3
@onready var geiger_area_4 = $GeigerArea4
@onready var geiger_area_5 = $GeigerArea5
@onready var player = $".."


var area_counter = 0


func _ready():
	geiger_area_1.area_entered.connect(_on_radiation_area_entered)
	geiger_area_2.area_entered.connect(_on_radiation_area_entered)
	geiger_area_3.area_entered.connect(_on_radiation_area_entered)
	geiger_area_4.area_entered.connect(_on_radiation_area_entered)
	geiger_area_5.area_entered.connect(_on_radiation_area_entered)
	geiger_area_1.area_entered.connect(_on_radiation_area_exited)
	geiger_area_2.area_entered.connect(_on_radiation_area_exited)
	geiger_area_3.area_entered.connect(_on_radiation_area_exited)
	geiger_area_4.area_entered.connect(_on_radiation_area_exited)
	geiger_area_5.area_entered.connect(_on_radiation_area_exited)


func _process(delta):
	pass


func _on_radiation_area_entered(area):
	if "radiation_level" in area:
		area_counter += 1
		player.geiger_counter_level = min(area_counter, area.radiation_level)


func _on_radiation_area_exited(area):
	if "radiation_level" in area:
		area_counter -= 1
		player.geiger_counter_level = min(area_counter, area.radiation_level)
