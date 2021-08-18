import 'package:flutter/material.dart';

class CustomDropdownButton extends StatelessWidget {
  final String value;
  final List<DropdownItem> items;
  final Function(String value)? onChanged;
  const CustomDropdownButton(
      {Key? key, required this.value, this.onChanged, required this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButton<String>(
        value: value,
        onChanged: (value) => onChanged!(value!),
        items: items.map<DropdownMenuItem<String>>((item) {
          return DropdownMenuItem<String>(
            value: item.value,
            child: Text(item.text),
          );
        }).toList(),
      ),
    );
  }
}

class DropdownItem {
  late String text;
  late String value;

  DropdownItem({String? text, required String value}) {
    if (text == null) text = value;
    this.text = text;
    this.value = value;
  }
}
