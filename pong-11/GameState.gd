extends Node2D

# music makers
var backgroundStream: AudioStreamPlayer = AudioStreamPlayer.new()
var backgroundManager: BackgroundManager11 = BackgroundManager11.new()
var soundStream: AudioStreamPlayer = AudioStreamPlayer.new()
var soundManager: SoundManager11 = SoundManager11.new()

# states
enum GAME_STATE {MENU, SERVE, PLAY}
var isPlayerServe: bool = true

# currentstate
var currentGameState: int = GAME_STATE.MENU

#scoring
var playerScore: int = 0
var aiScore: int = 0
var _SCORE_HEIGHT_PADDING: float = 50.0

# screen values
onready var screen: Rect2 = get_tree().get_root().get_visible_rect()
onready var screenBox: BoundBox11 = BoundBox11.new(screen)
# object instancing
onready var ball: Ball11 = Ball11.new(screenBox.getCenter())
onready var playerPaddle: PlayerPaddle11 = PlayerPaddle11.new(screenBox)
onready var aiPaddle: AiPaddle11 = AiPaddle11.new(screenBox)
onready var instructionText: Text11 = Text11.new(
	"Start a game by pressing the spacebar",
	Vector2(screenBox.getSize().x/2.0, 0.0)
)

onready var playerScoreText: Text11 = Text11.new(
	playerScore as String,
	Vector2(screenBox.getSize().x/4.0, _SCORE_HEIGHT_PADDING) # 25% from the left
)

onready var aiScoreText: Text11 = Text11.new(
	aiScore as String,
	Vector2(screenBox.getSize().x - screenBox.getSize().x/4.0, _SCORE_HEIGHT_PADDING) #25% from the right
)

# delta key
const RESET_DELTA_KEY: float = 0.0
const MAX_KEY_TIME: float = 0.3
var deltaKeyPress: float = RESET_DELTA_KEY

const MAX_SCORE: int = 3
var isPlayerWin: bool

func _ready() -> void:
	# set audio manager
	backgroundStream.name = "BackgroundStream"
	soundStream.name = "SoundStream"
	backgroundStream.add_child(backgroundManager)
	soundStream.add_child(soundManager)
	add_child(backgroundStream)
	add_child(soundStream)
	
	add_child(ball)
	add_child(playerPaddle)
	add_child(aiPaddle)
	add_child(instructionText)
	add_child(playerScoreText)
	add_child(aiScoreText) 

func _physics_process(delta: float) -> void:
	
	deltaKeyPress += delta
	
	match currentGameState:
		GAME_STATE.MENU:
			checkChangeState(GAME_STATE.SERVE)
		
		GAME_STATE.SERVE:
			setStartingPosition()
			checkWinner()
			checkChangeState(GAME_STATE.PLAY)
			
		GAME_STATE.PLAY:
			instructionText.updateString("W = Move Up; S = Move Down")
			moveObjects(delta)
			checkCollisions()
			checkChangeState(GAME_STATE.SERVE) # debug, delete before submitting


func moveObjects(delta: float) -> void:
	playerPaddle.checkMovement(delta)
	aiPaddle.checkMovement(delta, ball.getPosition())
	ball.moveBall(delta)


func setStartingPosition():
	aiPaddle.resetPosition()
	playerPaddle.resetPosition()
	ball.resetBall(isPlayerServe)
	aiScoreText.updateString(aiScore as String)
	playerScoreText.updateString(playerScore as String)
	
	if isPlayerServe:
		instructionText.updateString("Player Serve: press spacebar to serve")
	else:
		instructionText.updateString("Ai Serve: press spacebar to serve")


func checkChangeState(newState: int) -> void:
	if spaceBarDelay():
		currentGameState = newState
		deltaKeyPress = RESET_DELTA_KEY

func spaceBarDelay() -> bool:
	return Input.is_key_pressed(KEY_SPACE) and deltaKeyPress > MAX_KEY_TIME


func gamePointPlayer(playerWin: bool) -> void:
	currentGameState = GAME_STATE.SERVE
	deltaKeyPress = RESET_DELTA_KEY
	
	isPlayerServe = !playerWin
	playerScore += 1 if playerWin else 0
	aiScore += 1 if !playerWin else 0
	aiScoreText.updateString(aiScore as String)
	playerScoreText.updateString(playerScore as String)

func checkWinner() -> void:
	match MAX_SCORE:
		playerScore:
			currentGameState = GAME_STATE.MENU
			playerScore = 0
			aiScore = 0
			isPlayerWin = true
			instructionText.updateString("Player wins! press spacebar to start a new game")
			soundManager.playWinRound()
		aiScore:
			currentGameState = GAME_STATE.MENU
			playerScore = 0
			aiScore = 0
			isPlayerWin = false
			instructionText.updateString("Ai wins! press spacebar to start a new game")
			soundManager.playLoseRound()

func checkCollisions() -> void:
	
	if screenBox.isPassLeftBound(ball.getPosition()):
		gamePointPlayer(false)
		soundManager.playLosePoint()
	
	if screenBox.isPassRightBound(ball.getPosition()):
		gamePointPlayer(true)
		soundManager.playWinPoint()
	
	if screenBox.isPassTopBound(ball.getTopPoint()) and ball.isMovingUp():
		ball.inverseYSpeed()
		soundManager.playBounce()
	if screenBox.isPassBottomBound(ball.getBottomPoint()) and ball.isMovingDown():
		ball.inverseYSpeed()
		soundManager.playBounce()
	
	if Collisions11.pointToRectangle(ball.getPosition(), playerPaddle.getRect()) and ball.isMovingLeft():
		playerPaddle.changeBallDirection(ball)
		soundManager.playBounce()
	
	if Collisions11.pointToRectangle(ball.getPosition(), aiPaddle.getRect()) and ball.isMovingRight():
		aiPaddle.changeBallDirection(ball)
		aiPaddle.changeChasePosition() # change chase position ep 9
		soundManager.playBounce()

