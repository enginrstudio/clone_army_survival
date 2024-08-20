class_name HealthLabel
extends Label

var _timer:Timer = Timer.new()

func _ready() -> void:
	self.visible = false
	
	add_child(_timer)
	_timer.wait_time = 2
	_timer.timeout.connect(
		Callable(
			self,
			"_handle_timer_timeout"
		))

func show_remaining_health(val:int):
	self.text = str(val)
	self.visible = true
	_timer.start()

func _handle_timer_timeout():
	self.visible = false