class_name HealthComponent
extends Area2D

signal on_die
signal on_damage(remaining:int)
signal on_multiply_rune(multiplier:int)

@export var HealthMax: int = 5
@export var CurrHealth: int = 5

func _ready() -> void:
	area_entered.connect(
		Callable(
			self,
			"_handle_area_entered"
		))

func damage(val:int):
	CurrHealth -= val

	if CurrHealth == 0:
		_die()
	
	on_damage.emit(CurrHealth)

func _die():
	on_die.emit()

func _handle_area_entered(area: Area2D):
	if area.is_in_group("rune_multiply"):
		var m: RuneMultiply = area as RuneMultiply
		on_multiply_rune.emit(m.multiply)
		area.queue_free()
		