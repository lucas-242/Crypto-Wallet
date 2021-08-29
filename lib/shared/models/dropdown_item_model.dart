/// Represent an item in the dropdown lists
class DropdownItem {
  late String text;
  late String value;

  DropdownItem({String? text, required String value}) {
    if (text == null) text = value;
    this.text = text;
    this.value = value;
  }
}
