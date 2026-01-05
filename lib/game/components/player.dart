import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/sprite.dart';

class Player extends SpriteAnimationComponent with HasGameRef, Hitbox, Collidable {
  Vector2 velocity = Vector2.zero();
  final double speed = 200;
  final double jumpStrength = 300;
  bool isJumping = false;
  int health = 3;
  bool isInvulnerable = false;
  final double invulnerabilityTime = 2.0;
  double currentInvulnerabilityTime = 0;

  Player() {
    addShape(HitboxRectangle());
  }

  @override
  Future<void> onLoad() async {
    animation = await gameRef.loadSpriteAnimation(
      'player.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.1,
        textureSize: Vector2(48, 48),
      ),
    );
    size = Vector2(48, 48);
  }

  @override
  void update(double dt) {
    super.update(dt);
    handleMovement(dt);
    handleInvulnerability(dt);
    checkBounds();
  }

  void handleMovement(double dt) {
    position.add(velocity * dt);
    if (isJumping) {
      velocity.y += 500 * dt; // Gravity effect
    }
  }

  void jump() {
    if (!isJumping) {
      velocity.y = -jumpStrength;
      isJumping = true;
    }
  }

  void moveLeft() {
    velocity.x = -speed;
  }

  void moveRight() {
    velocity.x = speed;
  }

  void stop() {
    velocity.x = 0;
  }

  void takeDamage() {
    if (!isInvulnerable) {
      health -= 1;
      isInvulnerable = true;
      currentInvulnerabilityTime = invulnerabilityTime;
      if (health <= 0) {
        // Handle player death
      }
    }
  }

  void handleInvulnerability(double dt) {
    if (isInvulnerable) {
      currentInvulnerabilityTime -= dt;
      if (currentInvulnerabilityTime <= 0) {
        isInvulnerable = false;
      }
    }
  }

  void checkBounds() {
    if (position.y > gameRef.size.y) {
      // Handle fall off screen
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    if (other is Obstacle) {
      takeDamage();
    } else if (other is Collectible) {
      // Handle collectible
    }
  }

  void land() {
    isJumping = false;
    velocity.y = 0;
  }
}

class Obstacle extends SpriteComponent with Collidable {
  Obstacle() {
    addShape(HitboxRectangle());
  }
}

class Collectible extends SpriteComponent with Collidable {
  Collectible() {
    addShape(HitboxCircle());
  }
}