extends Node2D

# states
enum GAME_STATE {MENU, SERVE, PLAY}
var isPlayerServe = true

# currentstate
var currentGameState = GAME_STATE.MENU

# screen values
onready var screenWidth = get_tree().get_root().size.x
onready var screenHeight = get_tree().get_root().size.y
onready var halfScreenWidth = screenWidth/2
onready var halfScreenHeight = screenHeight/2

# ball variables
var ballRadius = 10.0
var ballColor = Color.white

# paddle variables
var paddleColor = Color.white
var paddleSize = Vector2(10.0,100.0)
var halfPaddleHeight = paddleSize.y/2
var paddlePadding = 10.0

# font variable
var font = DynamicFont.new()
var robotoFile = load("res://Roboto-Light.ttf")
var fontSize = 24
var halfWidthFont
var heightFont
var stringValue = "Hello World!"

# ball variable
onready var ballPosition = Vector2(halfScreenWidth,halfScreenHeight)

# player paddle
onready var playerPosition = Vector2(paddlePadding, halfScreenHeight - halfPaddleHeight)
onready var playerRectangle = Rect2(playerPosition, paddleSize)

#ai paddle
onready var aiPostion = Vector2(screenWidth - (paddlePadding + paddleSize.x), 
halfScreenHeight - halfPaddleHeight)
onready var aiRectangle = Rect2(aiPostion, paddleSize)

#string variable
var stringPosition

# delta key
const RESET_DELTA_KEY = 0.0
const MAX_KEY_TIME = 0.3
var deltaKeyPress = RESET_DELTA_KEY

func _ready() -> void:
	# print(get_tree().get_root().size)
	font.font_data = robotoFile
	font.size = fontSize
	halfWidthFont = font.get_string_size(stringValue).x/2
	heightFont = font.get_height()
	stringPosition = Vector2(halfScreenWidth - halfWidthFont, heightFont)

func _physics_process(delta: float) -> void:
	
	deltaKeyPress += delta
	
	match currentGameState:
		GAME_STATE.MENU:
			changeString("MENU!!!!!")
			if(Input.is_key_pressed(KEY_SPACE) and
			deltaKeyPress > MAX_KEY_TIME):
				currentGameState = GAME_STATE.SERVE
				deltaKeyPress = RESET_DELTA_KEY
		GAME_STATE.SERVE:
			changeString("SERVE!!!!!")
			if(Input.is_key_pressed(KEY_SPACE) and
			deltaKeyPress > MAX_KEY_TIME):
				currentGameState = GAME_STATE.PLAY
				deltaKeyPress = RESET_DELTA_KEY
			
		GAME_STATE.PLAY:
			changeString("PLAY!!!!!")
			if(Input.is_key_pressed(KEY_SPACE) and
			deltaKeyPress > MAX_KEY_TIME):
				currentGameState = GAME_STATE.SERVE
				deltaKeyPress = RESET_DELTA_KEY

func _draw() -> void:
	setStartingPosition()

func setStartingPosition():
	draw_circle(ballPosition, ballRadius, ballColor)
	draw_rect(playerRectangle, paddleColor)
	draw_rect(aiRectangle, paddleColor)
	draw_string(font, stringPosition, stringValue)

func changeString(newStringValue):
	stringValue = newStringValue
	halfWidthFont = font.get_string_size(stringValue).x/2
	stringPosition = Vector2(halfScreenWidth - halfWidthFont, heightFont)
	update()
