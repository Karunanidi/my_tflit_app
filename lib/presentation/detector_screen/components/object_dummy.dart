import 'package:my_tflit_app/core/utils/constant.dart';

class ObjectDummy {
  final String object;
  final String emoji;
  final String imagePath;

  ObjectDummy({
    required this.object,
    required this.emoji,
    required this.imagePath,
  });
}

List<ObjectDummy> objectFruitsList = [
  ObjectDummy(
    object: 'Apple',
    emoji: '🍎',
    imagePath: '',
  ),
  ObjectDummy(
    object: 'Corn',
    emoji: '🌽',
    imagePath: '',
  ),
  ObjectDummy(
    object: 'Grape',
    emoji: '🍇',
    imagePath: '',
  ),
  ObjectDummy(
    object: 'Kiwi',
    emoji: '🥝',
    imagePath: '',
  ),
  ObjectDummy(
    object: 'Lemon',
    emoji: '🍋',
    imagePath: '',
  ),
  ObjectDummy(
    object: 'Orange',
    emoji: '🍊',
    imagePath: '',
  ),
  ObjectDummy(
    object: 'Pineapple',
    emoji: '🍍',
    imagePath: '',
  ),
  ObjectDummy(
    object: 'Potato',
    emoji: '🥔',
    imagePath: '',
  ),
];

List<ObjectDummy> objectDinosaursList = [
  ObjectDummy(
    object: 'Ankylosaurus',
    emoji: '🦕',
    imagePath: '$RESOURCE_URL/dinosaurs/ankylosaurus.png',
  ),
  ObjectDummy(
    object: 'Brachiosaurus',
    emoji: '🦕',
    imagePath: '$RESOURCE_URL/dinosaurs/brachiosaurus.png',
  ),
  ObjectDummy(
    object: 'Dilophosaurus',
    emoji: '🦖',
    imagePath: '$RESOURCE_URL/dinosaurs/dilophosaurus.png',
  ),
  ObjectDummy(
    object: 'T-Rex',
    emoji: '🦖',
    imagePath: '$RESOURCE_URL/dinosaurs/t-rex.png',
  ),
  ObjectDummy(
    object: 'Triceratops',
    emoji: '🦕',
    imagePath: '$RESOURCE_URL/dinosaurs/triceratops.png',
  ),
  ObjectDummy(
    object: 'Velociraptor',
    emoji: '🦖',
    imagePath: '$RESOURCE_URL/dinosaurs/velociraptor.png',
  ),
  ObjectDummy(
    object: 'Parasaurolophus',
    emoji: '🦕',
    imagePath: '$RESOURCE_URL/dinosaurs/parasaurolophus.png',
  ),
  ObjectDummy(
    object: 'Spinosaurus',
    emoji: '🦖',
    imagePath: '$RESOURCE_URL/dinosaurs/spinosaurus.png',
  ),
];

