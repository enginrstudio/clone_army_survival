class_name Spawner
extends Node2D

func spawn(_scene: PackedScene,
	_position: Vector2 = global_position,
	parent: Node = get_tree().current_scene):
	assert(_scene is PackedScene,
	"Error: specified scene is not PackedScene")
	
	var instance = _scene.instantiate()
	parent.add_child.call_deferred(instance)
	
	instance.global_position = _position
	
	return instance
