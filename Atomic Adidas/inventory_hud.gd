extends CanvasLayer


@onready var geiger_counter_sprite = $GeigerCounter
@onready var geiger_counter_animation_player = $GeigerCounter/AnimationPlayer
@onready var player = get_node("..")


const geiger_counter_animation = ["level_1", "level_2", "level_3", "level_4", "level_5"]

# AAAAAAAAAAAAAAAAAAAAA
func _ready():
	pass


func _process(delta):
	pass
		

#region Geiger Counter
func open_geiger_counter():
	geiger_counter_animation_player.play("pick_up")
	geiger_counter_sprite.play(geiger_counter_animation[player.geiger_counter_level])

func close_geiger_counter():
	geiger_counter_animation_player.play_backwards("pick_up")
	geiger_counter_sprite.stop()
#endregion

#testoacazzo
