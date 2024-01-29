extension StringExtensions on String {
  String replaceCharAt(String newChar, int position) {
    if (position < 0 || position >= length) {
      throw ArgumentError('Position outside string boundaries');
    }

    final List<String> characters = split('');
    characters[position] = newChar;

    return characters.join();
  }

  String capitalize() {
    if (length <= 1) {
      return toUpperCase();
    }

    final List<String> words = split(' ');
    final capitalizedWords = _capitalizeWords(words);
    return capitalizedWords.join(' ');
  }

  Iterable<String> _capitalizeWords(List<String> words) {
    return words.map((word) {
      if (word.trim().isNotEmpty) {
        final String firstLetter = word.trim().substring(0, 1).toUpperCase();
        final String remainingLetters = word.trim().substring(1);

        return '$firstLetter$remainingLetters';
      }
      return '';
    });
  }
}
