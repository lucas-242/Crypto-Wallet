import 'package:flutter/material.dart';

import 'models/dropdown_option_model.dart';

class CustomDropdownButton extends StatelessWidget {
  final String value;
  final List<DropdownOption> items;
  final Function(String value)? onChanged;
  const CustomDropdownButton(
      {Key? key, required this.value, this.onChanged, required this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButton<String>(
        value: value,
        onChanged: (String? value) => onChanged!(value!),
        items: items.map<DropdownMenuItem<String>>((DropdownOption value) {
          return DropdownMenuItem<String>(
            value: value.value ?? value.name,
            child: Text(value.name),
          );
        }).toList(),
      ),
    );
  }
}