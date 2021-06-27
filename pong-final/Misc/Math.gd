extends Resource

class_name Math

static func pointConversion(pointA: float, originalStart: float, originalEnd: float, newStart:float, newEnd: float) -> float:
	var length = originalEnd - originalStart
	var newLength = newEnd - newStart
	
	return ((pointA - originalStart) * (newLength/length)) + newStart

static func vectorScaling(original: Vector2, scale: float) -> Vector2:
	var result: Vector2
	
	# result = original * scale # Godot Game Engine support only
	result.x = original.x * scale
	result.y = original.y * scale
	
	return result


# original (Vector2): the vector to rotate
# degree (float): the amount to rotate the vector in degrees
#
# return: Vector2 value of the newly created rotated vector in the cartesian graph system
# cartesian graph system =/= Godot Game Engine Graph System
#
static func vectorRotation(original: Vector2, degree: float)-> Vector2:
	var result: Vector2
	var radian: float = deg2rad(degree)
	var sine: float = sin(radian)
	var cosine: float = cos(radian)
	
	result.x = (original.x * cosine) - (original.y * sine)
	result.y = (original.x * sine) + (original.y * cosine)
	
	return result 

# TODO: Rename function
#
# return: float value, specifically values between 0.0 <-> 1.0
# with a normal distribution around 0.5
#
static func primitiveNormalDistributionRandom() -> float:
	var iterate: int = 6
	var result: float = 0.0
	
	randomize()
	
	for i in iterate:
		result += randf()
	
	return result / float(iterate)

