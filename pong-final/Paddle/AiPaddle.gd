extends Paddle

class_name AiPaddle

const _CHASE_BUFFER: float = 15.0

onready var chasePosition: float = _halfHeight

func _init(box:BoundBox) -> void:
	_boundBox = box
	_pos = Vector2(_boundBox.getSize().x - (_padding + _size.x), _boundBox.getHalfHeight() - _halfHeight) # specific to subclass
	_resetPos = _pos
	_rect = Rect2(_pos, _size)

func checkMovement(delta: float, ballPos: Vector2):
	if ballPos.y <= (_pos.y + chasePosition) - _CHASE_BUFFER:
		moveUp(delta)
		updatePosition()
	elif ballPos.y >= (_pos.y + chasePosition) + _CHASE_BUFFER:
		moveDown(delta)
		updatePosition()

func moveUp(delta: float) -> void:
	_pos.y -= _speed.y * delta

func moveDown(delta: float) -> void:
	_pos.y += _speed.y * delta


func changeChasePosition() -> void:
	var rndDistribution: float = Math.primitiveNormalDistributionRandom()
	var rndMin: float = 0.0
	var rndMax: float = 1.0
	var minChaseSize: float = 0.0
	var maxChaseSize: float = _size.y
	
	chasePosition = Math.pointConversion(rndDistribution, rndMin, rndMax, minChaseSize, maxChaseSize)

