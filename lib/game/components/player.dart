import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flutter/services.dart';

/// Represents the player character in the platformer game.
class Player extends SpriteAnimationComponent
    with HasGameRef, Hitbox, Collidable, KeyboardHandler {
  // Player states
  bool isJumping = false;
  bool isMoving = false;

  // Player properties
  double speed = 200.0;
  final double jumpStrength = 300.0;
  final double gravity = 1000.0;
  double ySpeed = 0.0;

  // Health and score
  int health = 3;
  int score = 0;

  Player()
      : super(size: Vector2(50.0, 50.0), position: Vector2(100.0, 300.0)) {
    addHitbox(HitboxRectangle());
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    // Load and set animations for different states
    final idleAnimation = await gameRef.loadSpriteAnimation(
      'player_idle.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.1,
        textureSize: Vector2(50, 50),
      ),
    );
    animation = idleAnimation; // Default state
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Gravity effect
    ySpeed += gravity * dt;
    position.y += ySpeed * dt;

    // Ground check
    if (position.y > gameRef.size.y - size.y) {
      position.y = gameRef.size.y - size.y;
      isJumping = false;
      ySpeed = 0.0;
    }

    // Movement
    if (isMoving) {
      position.x += speed * dt;
    }
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    // Handle jump input
    if (keysPressed.contains(LogicalKeyboardKey.space) && !isJumping) {
      isJumping = true;
      ySpeed = -jumpStrength;
    }

    // Handle movement input
    isMoving = keysPressed.contains(LogicalKeyboardKey.arrowRight) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      speed = -200.0;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      speed = 200.0;
    }

    return super.onKeyEvent(event, keysPressed);
  }

  /// Damages the player and updates health.
  void takeDamage(int damage) {
    health -= damage;
    if (health <= 0) {
      // Handle player death
      print('Player has died');
    }
  }

  /// Increases the player's score.
  void increaseScore(int points) {
    score += points;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    // Handle collision with enemies or obstacles
    if (other is Enemy) {
      takeDamage(1);
    }
  }
}