extends StaticBody2D

@onready var interactable = $Interactable
@onready var animation_player = $lever/AnimationPlayer

func _ready() -> void:
	interactable.interact = Callable(self, "on_interact")

func on_interact():
	if interactable.monitoring:
		animation_player.play("Lever")
		interactable.is_interactable = false
		interactable.monitoring = false
		print("Machine activated!")
	
