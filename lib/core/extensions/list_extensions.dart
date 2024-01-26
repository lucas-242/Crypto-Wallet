import 'dart:math';

extension ListExtensions<T> on List<T> {
  T getRandom() => _getRandomElement();

  T _getRandomElement() {
    final random = Random();
    final index = random.nextInt(length);
    return this[index];
  }
}
