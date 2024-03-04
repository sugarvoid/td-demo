class_name Projectile
extends Area2D

@onready var sprite: Sprite2D = get_node("Sprite2D")
@onready var visiblity_notifer: VisibleOnScreenNotifier2D = get_node("VisibleOnScreenNotifier2D")


var parent_node: Node2D

var projectile_ID: String
var speed: float = 400
var life: float = 3.0
var damage_given: int
var sprite_frame: int
var facing_dir: int


func get_class_name() -> String:
	return "Projectile"


func _physics_process(delta):
	self.global_position += (Vector2(cos(rotation), sin(rotation)) * speed * delta) #* facing_dir


func set_move_dir(facing: int):
	self.facing_dir = facing

func _ready() -> void:
	self.scale = Vector2(0.8,0.8)
	$LifeTimer.start(self.life)
	self.area_entered.connect(self.made_contact)
	self.body_entered.connect(self.made_contact)
	self.visiblity_notifer.screen_exited.connect(self._remove_self)


func _on_LifeTimer_timeout() -> void:
	self.queue_free()


func made_contact(thing: Node2D) -> void:
	if thing == self.parent_node:
		return
	elif thing.has_method("take_damage"):
		self.queue_free()
		thing.take_damage()
	else:
		print('googye')
		self.queue_free()
		


func _remove_self() -> void:
	self.queue_free()
