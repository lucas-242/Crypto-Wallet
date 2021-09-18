import 'package:crypto_wallet/shared/models/dropdown_item_model.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String label;
  final String hint;
  final DropdownItem? selectedItem;
  final List<DropdownItem> items;
  final String? Function(DropdownItem?)? validator;
  final Function(DropdownItem?)? onChanged;
  final bool showSeach;
  final String? searchHint;
  const CustomDropdown({
    Key? key,
    required this.label,
    required this.hint,
    this.selectedItem,
    required this.items,
    this.validator,
    this.onChanged,
    this.showSeach = false,
    this.searchHint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final maxHeight = items.length <= 3 ?  SizeConfig.height * 0.22 : SizeConfig.height * 0.28;

    return DropdownSearch<DropdownItem>(
      label: label,
      mode: Mode.BOTTOM_SHEET,
      maxHeight: maxHeight,
      selectedItem: selectedItem,
      items: items,
      itemAsString: (DropdownItem u) => u.text,
      onChanged: onChanged,
      validator: validator,
      showSearchBox: showSeach,
      searchFieldProps: TextFieldProps(
        style: AppTextStyles.input,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: appLocalizations.search,
          hintText: searchHint,
          hintStyle: AppTextStyles.input,
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(),
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Icon(Icons.search, color: AppColors.primary),
          ),
        ),
      ),
      dropdownBuilder: (_, item, value) => _dropdownBuilder(
        value: value,
        hint: value.isEmpty ? hint : value,
      ),
      dropdownButtonBuilder: (_) => _dropdownButtonBuilder(),
      emptyBuilder: (_, message) => _dropdownEmptyBuilder(appLocalizations),
    );
  }

  Widget _dropdownBuilder({String? value, String hint = ''}) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Container(
          child: Text(
            value == null || value == '' ? hint : value,
            style: AppTextStyles.input,
          ),
        ),
      );

  // !There is a bug that put a yellow undeline on message
  Widget _dropdownEmptyBuilder(AppLocalizations appLocalizations) => Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Container(
          child: Text(
            appLocalizations.noResults,
            style: AppTextStyles.body.copyWith(fontSize: 20),
          ),
        ),
      );

  Widget _dropdownButtonBuilder() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Icon(
          Icons.arrow_drop_down,
          size: 24,
          color: AppColors.text,
        ),
      );
}
