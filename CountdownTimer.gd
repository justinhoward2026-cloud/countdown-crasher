extends Node
@onready var label: Label = $Label
@onready var timer: Timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CountdownManager.clock_updated.connect(update_clock)
	CountdownManager.time_up.connect(_on_time_up)
	
	update_clock()
	timer.start()


func update_clock():
	label.text = "%02d:%02d:%02d" % [
		CountdownManager.hours,
		CountdownManager.minutes,
		CountdownManager.seconds
	]

func _on_timer_timeout() -> void:
	CountdownManager.subtract_time(0,0,1)

func _on_time_up():
	timer.stop()
	print("Time's up!")
