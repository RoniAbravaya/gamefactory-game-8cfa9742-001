import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/sprite.dart';

/// Represents an obstacle in the platformer game.
/// It includes a visual representation, collision detection, and damage dealing capability.
class Obstacle extends PositionComponent with HasHitboxes, Collidable {
  // The damage this obstacle deals upon collision.
  final int damage;
  // The speed at which the obstacle moves across the screen.
  final Vector2 movementSpeed;
  // Path to the sprite image.
  final String spritePath;

  Obstacle({
    required this.damage,
    required this.movementSpeed,
    required this.spritePath,
    required Vector2 position,
    required Vector2 size,
  }) : super(
          position: position,
          size: size,
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    // Load and set the sprite for the obstacle.
    sprite = await Sprite.load(spritePath);
    // Add a hitbox for collision detection.
    addHitbox(HitboxRectangle());
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Move the obstacle according to its speed.
    position.add(movementSpeed * dt);
    // Remove the obstacle if it moves off-screen.
    if (position.x < 0 || position.x > size.x || position.y < 0 || position.y > size.y) {
      removeFromParent();
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    // Implement damage dealing or other effects upon collision.
  }
}