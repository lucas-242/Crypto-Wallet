/// Represent an item in the dropdown lists
class DropdownItem {
  /// Label Text
  late String text;
  // Value of item
  late String value;
  /// Auxilar value 
  late String? auxValue;

  DropdownItem({String? text, String? auxValue, required String value}) {
    if (text == null) text = value;
    this.text = text;
    this.value = value;
    this.auxValue = auxValue;
  }

  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is DropdownItem &&
      other.text == text &&
      other.value == value &&
      other.auxValue == auxValue;
  }

  @override
  int get hashCode => text.hashCode ^ value.hashCode ^ auxValue.hashCode;
}
