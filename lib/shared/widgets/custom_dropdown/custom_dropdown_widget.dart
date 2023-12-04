import 'package:adaptive_theme/adaptive_theme.dart';
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
    final textTheme = Theme.of(context).textTheme;
    final maxHeight =
        items.length <= 3 ? SizeConfig.height * 0.22 : SizeConfig.height * 0.28;
    final activeTheme = AdaptiveTheme.of(context).mode;

    return DropdownSearch<DropdownItem>(
      label: label,
      // * Breaking layout when trying use dropdownSearchDecoration, so I keeping label in use
      // dropdownSearchDecoration: InputDecoration(
      //   labelText: label,
      // ),
      mode: Mode.BOTTOM_SHEET,
      maxHeight: maxHeight,
      selectedItem: selectedItem,
      items: items,
      itemAsString: (DropdownItem? u) => u!.text,
      onChanged: onChanged,
      validator: validator,
      showSearchBox: showSeach,
      searchFieldProps: TextFieldProps(
        style: textTheme.bodySmall,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: appLocalizations.search,
          hintText: searchHint,
          hintStyle: textTheme.bodySmall,
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(),
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Icon(Icons.search, color: AppColors.primary),
          ),
        ),
      ),
      popupItemBuilder: (_, item, isSelected) => _popupItemBuilder(
        item: item,
        textTheme: textTheme,
        activeTheme: activeTheme,
      ),
      dropdownBuilder: (_, item) => _dropdownBuilder(
        item: item,
        hint: hint,
        textTheme: textTheme,
      ),
      dropdownButtonBuilder: (_) => _dropdownButtonBuilder(),
      emptyBuilder: (_, message) =>
          _dropdownEmptyBuilder(appLocalizations, textTheme),
    );
  }

  Widget _popupItemBuilder({
    required DropdownItem item,
    required TextTheme textTheme,
    required AdaptiveThemeMode activeTheme,
  }) =>
      ListTile(
        title: Text(item.text,
            style: activeTheme == AdaptiveThemeMode.dark
                ? textTheme.bodySmall
                : textTheme.bodyMedium),
      );

  Widget _dropdownBuilder(
          {DropdownItem? item, String hint = '', required TextTheme textTheme}) =>
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Container(
          child: Text(
            item == null || item.text == '' ? hint : item.text,
            style: textTheme.bodySmall,
          ),
        ),
      );

  // !There is a bug that put a yellow undeline on message
  Widget _dropdownEmptyBuilder(
          AppLocalizations appLocalizations, TextTheme textTheme) =>
      Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Container(
          child: Text(
            appLocalizations.noResults,
            style: textTheme.bodyMedium!.copyWith(fontSize: 18),
          ),
        ),
      );

  Widget _dropdownButtonBuilder() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Icon(Icons.arrow_drop_down, size: 24),
      );
}
