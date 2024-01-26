extension StringExtensions on String {
  String replaceCharAt(String newChar, int position) {
    if (position < 0 || position >= length) {
      throw ArgumentError('Position outside string boundaries');
    }

    final List<String> characters = split('');
    characters[position] = newChar;

    return characters.join();
  }
}
