import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/palette.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

/// Represents the main menu scene for the platformer game.
class MenuScene extends Component with HasGameRef, TapDetector {
  late TextComponent title;
  late SpriteComponent playButton;
  late SpriteComponent levelSelectButton;
  late SpriteComponent settingsButton;
  late RectComponent background;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await _loadBackground();
    await _loadTitle();
    await _loadPlayButton();
    await _loadLevelSelectButton();
    await _loadSettingsButton();
  }

  /// Loads and configures the background of the menu.
  Future<void> _loadBackground() async {
    background = RectComponent(
      paint: Paint()..color = Colors.blue.shade300,
      size: gameRef.size,
    );
    add(background);
  }

  /// Loads and configures the title of the game.
  Future<void> _loadTitle() async {
    title = TextComponent(
      text: 'Test Haiku Model-platformer-01',
      textRenderer: TextPaint(
        style: TextStyle(
          fontSize: 40,
          color: Colors.white,
          shadows: [
            Shadow(
              blurRadius: 7,
              color: Colors.black,
              offset: Offset(3, 3),
            ),
          ],
        ),
      ),
    )..anchor = Anchor.topCenter;
    title.position = Vector2(gameRef.size.x / 2, gameRef.size.y * 0.1);
    add(title);
  }

  /// Loads and configures the play button.
  Future<void> _loadPlayButton() async {
    playButton = SpriteComponent(
      sprite: await gameRef.loadSprite('play_button.png'),
      size: Vector2(100, 100),
      position: gameRef.size / 2 - Vector2(100, 50),
    )..anchor = Anchor.center;
    add(playButton);
  }

  /// Loads and configures the level select button.
  Future<void> _loadLevelSelectButton() async {
    levelSelectButton = SpriteComponent(
      sprite: await gameRef.loadSprite('level_select_button.png'),
      size: Vector2(100, 100),
      position: Vector2(gameRef.size.x / 2, gameRef.size.y / 2 + 60),
    )..anchor = Anchor.center;
    add(levelSelectButton);
  }

  /// Loads and configures the settings button.
  Future<void> _loadSettingsButton() async {
    settingsButton = SpriteComponent(
      sprite: await gameRef.loadSprite('settings_button.png'),
      size: Vector2(100, 100),
      position: Vector2(gameRef.size.x - 120, gameRef.size.y - 120),
    )..anchor = Anchor.center;
    add(settingsButton);
  }

  @override
  bool onTapDown(TapDownInfo info) {
    if (playButton.containsPoint(info.eventPosition.game)) {
      // Handle play button tap
      print('Play button tapped');
    } else if (levelSelectButton.containsPoint(info.eventPosition.game)) {
      // Handle level select button tap
      print('Level select button tapped');
    } else if (settingsButton.containsPoint(info.eventPosition.game)) {
      // Handle settings button tap
      print('Settings button tapped');
    }
    return super.onTapDown(info);
  }
}