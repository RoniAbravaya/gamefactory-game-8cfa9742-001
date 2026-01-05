import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame_audio/flame_audio.dart';

/// A component for collectible items in a platformer game.
///
/// It includes collision detection, a score value, optional animation,
/// and a sound effect upon collection.
class Collectible extends SpriteComponent with Hitbox, Collidable {
  final int scoreValue;
  final String collectionSound;
  bool _collected = false;

  /// Creates a new Collectible item.
  ///
  /// [scoreValue] specifies the score the player receives upon collecting this item.
  /// [collectionSound] is the path to the sound effect that plays upon collection.
  Collectible({
    required Sprite sprite,
    required Vector2 position,
    required Vector2 size,
    this.scoreValue = 100,
    this.collectionSound = 'collectible_pickup.mp3',
  }) : super(sprite: sprite, position: position, size: size) {
    addShape(HitboxRectangle());
  }

  @override
  Future<void>? onLoad() async {
    try {
      await super.onLoad();
      // Optionally, load and prepare animations here if needed.
    } catch (e) {
      print('Error loading Collectible: $e');
    }
  }

  /// Handles the logic when this collectible is collected by the player.
  void collect() {
    if (!_collected) {
      _collected = true;
      FlameAudio.play(collectionSound);
      removeFromParent();
      // Additional logic for updating the game state (e.g., increment score) goes here.
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    // Assuming the player is the only other collidable entity.
    collect();
  }
}