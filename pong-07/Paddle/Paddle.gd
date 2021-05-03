extends Node2D

class_name Paddle07

var _color: Color = Color.white
var _size: Vector2 = Vector2(10.0,100.0)
var _padding: float = 10.0
var _speed: Vector2 = Vector2(0.0, 400.0) # only moves in y-axis
var _resetSpeed: Vector2 = _speed
var _halfHeight: float = _size.y/2.0

# handled by subclass
var _rect: Rect2
var _pos: Vector2
var _resetPos: Vector2
var _boundBox: BoundBox07

func _draw() -> void:
	draw_rect(_rect, _color)

func getHalfHeight() -> float:
	return _halfHeight

func getRect() -> Rect2:
	return _rect

func resetPosition() -> void:
	_pos = _resetPos
	_rect = Rect2(_pos, _size)
	update()

func updatePosition() -> void:
	_pos.y = clamp(_pos.y, _boundBox.getPosition().y, _boundBox.getSize().y - _size.y)
	_rect = Rect2(_pos, _size)
	update()

# overriden subclass
func moveUp(delta: float) -> void:
	assert(false, "Method Moveup has not been overridden")

# overriden subclass
func moveDown(delta: float) -> void:
	assert(false, "Method Movedown has not been overridden")
