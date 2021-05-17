extends Resource

class_name Collisions08

static func pointToPoint(pointA: Vector2, pointB: Vector2) -> bool:
	return pointA.x == pointB.x and pointA.y == pointB.y

static func pointToRectangle(point: Vector2, rect: Rect2) -> bool:
	var rectLeft: float = rect.position.x
	var rectRight: float = rectLeft + rect.size.x
	var rectTop: float = rect.position.y
	var rectBottom: float = rectTop + rect.size.y
	
	return (rectLeft <= point.x and point.x <= rectRight
	and rectTop <= point.y and point.y <= rectBottom)
