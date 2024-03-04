extends Node2D

@onready var player = get_node("Player")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.connect("request_bullet", $ProjectileManager.add_bullet_to_screen)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
