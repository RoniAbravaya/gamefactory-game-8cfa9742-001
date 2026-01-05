import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';

class GameScene extends Component with HasGameRef, TapDetector {
  late Player player;
  late TextComponent scoreDisplay;
  int score = 0;

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    _setupLevel();
    _spawnPlayer();
    _setupScoreDisplay();
  }

  /// Sets up the level with platforms, obstacles, and collectibles
  void _setupLevel() {
    // Example: Load level components like platforms and obstacles here
  }

  /// Spawns the player character in the game scene
  void _spawnPlayer() {
    player = Player()
      ..position = Vector2(100, 100) // Example starting position
      ..size = Vector2(50, 50); // Example size
    add(player);
  }

  /// Initializes and adds the score display to the game scene
  void _setupScoreDisplay() {
    scoreDisplay = TextComponent(text: 'Score: $score', position: Vector2(10, 10), anchor: Anchor.topLeft);
    add(scoreDisplay);
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Game loop logic such as checking win/lose conditions
  }

  /// Handles tap input to make the player jump
  @override
  void onTap() {
    player.jump();
  }

  /// Increments the score and updates the score display
  void incrementScore(int points) {
    score += points;
    scoreDisplay.text = 'Score: $score';
  }

  /// Pauses the game
  void pauseGame() {
    gameRef.pauseEngine();
  }

  /// Resumes the game
  void resumeGame() {
    gameRef.resumeEngine();
  }
}

class Player extends SpriteComponent with HasGameRef {
  /// Makes the player jump
  void jump() {
    // Implement jump logic here
  }
}