/// Represent an item in the dropdown lists
class DropdownItem {
  late String text;
  late String? other;
  late String value;

  DropdownItem({String? text, String? other, required String value}) {
    if (text == null) text = value;
    this.text = text;
    this.other = other;
    this.value = value;
  }
}
