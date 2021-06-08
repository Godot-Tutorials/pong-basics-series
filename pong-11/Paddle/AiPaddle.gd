extends Paddle11

class_name AiPaddle11

const _CHASE_BUFFER: float = 15.0

# dynamic ai collision
var chasePosition: float
func _init(box:BoundBox11) -> void:
	_boundBox = box
	_pos = Vector2(_boundBox.getSize().x - (_padding + _size.x), _boundBox.getHalfHeight() - _halfHeight) # specific to subclass
	_resetPos = _pos
	_rect = Rect2(_pos, _size)
	randomize() # randomize our seed
	chasePosition = _halfHeight

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
	# 1. get random number in distribution 0.0 <-> 1.0
	var rndDistribution: float = Math11.primitiveDistributionRandom()
	var rndMin: float = 0.0
	var rndMax: float = 1.0
	var minChaseSize: float = 0.0
	var maxChaseSize: float = _size.y
	
	# 2. convert decimal value into paddle size range
	var newPosition = Math11.pointConversion(rndDistribution, rndMin, rndMax, minChaseSize, maxChaseSize)
	
	# 3. change chasePosition
	var absPosition = abs(newPosition)
	absPosition = absPosition if absPosition <= _size.y else _halfHeight
	chasePosition = newPosition
	#print(newPosition)
