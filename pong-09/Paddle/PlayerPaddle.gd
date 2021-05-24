extends Paddle09

class_name PlayerPaddle09

func _init(box:BoundBox09) -> void:
	_boundBox = box
	_pos = Vector2(_padding, _boundBox.getHalfHeight() - _halfHeight) # specific to subclass
	_resetPos = _pos
	_rect = Rect2(_pos, _size)

func checkMovement(delta: float):
	if(Input.is_key_pressed(KEY_W)):
		moveUp(delta)
		updatePosition()
	if(Input.is_key_pressed(KEY_S)):
		moveDown(delta)
		updatePosition()

func moveUp(delta: float) -> void:
	_pos.y -= _speed.y * delta

func moveDown(delta: float) -> void:
	_pos.y += _speed.y * delta
