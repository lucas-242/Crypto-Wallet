import 'package:crypto_wallet/domain/models/dropdown_item.dart';
import 'package:crypto_wallet/themes/themes.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  const CustomDropdown({
    super.key,
    required this.label,
    required this.hint,
    this.selectedItem,
    required this.items,
    this.validator,
    this.onChanged,
    this.showSeach = false,
    this.searchHint,
  });

  final String label;
  final String hint;
  final DropdownItem? selectedItem;
  final List<DropdownItem> items;
  final String? Function(DropdownItem?)? validator;
  final Function(DropdownItem?)? onChanged;
  final bool showSeach;
  final String? searchHint;

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String _searchTerm = '';

  List<DropdownItem> getFilteredItems() => widget.items
      .where((item) =>
          item.label.toLowerCase().contains(_searchTerm.toLowerCase()) ||
          item.value.toLowerCase().contains(_searchTerm.toLowerCase()))
      .toList();

  @override
  Widget build(BuildContext context) {
    final List<DropdownItem> filteredItems = getFilteredItems();

    return Padding(
      padding: const EdgeInsets.all(AppInsets.md),
      child: Column(
        children: [
          if (widget.showSeach)
            TextFormField(
              decoration: InputDecoration(
                labelText: widget.searchHint,
              ),
              onChanged: (value) {
                setState(() {
                  _searchTerm = value;
                });
              },
            ),
          AppSpacings.verticalMd,
          DropdownButtonFormField<DropdownItem>(
            value: widget.selectedItem,
            hint: Text(widget.label),
            icon: const Icon(Icons.arrow_drop_down),
            elevation: 16,
            style: const TextStyle(color: AppColors.black),
            onChanged: widget.onChanged,
            validator: widget.validator,
            items: filteredItems
                .map<DropdownMenuItem<DropdownItem>>(
                    (value) => DropdownMenuItem<DropdownItem>(
                          value: value,
                          child: Text(value.label),
                        ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
