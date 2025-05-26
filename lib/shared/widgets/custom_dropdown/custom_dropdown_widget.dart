import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:crypto_wallet/shared/models/dropdown_item_model.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
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
    required this.searchLabel,
    required this.noResultsLabel,
  });
  final String label;
  final String hint;
  final DropdownItem? selectedItem;
  final List<DropdownItem> items;
  final String? Function(DropdownItem?)? validator;
  final Function(DropdownItem?)? onChanged;
  final bool showSeach;
  final String? searchHint;
  final String searchLabel;
  final String noResultsLabel;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<DropdownItem>(
      selectedItem: selectedItem,
      items: items,
      itemAsString: (DropdownItem? u) => u!.text,
      onChanged: onChanged,
      validator: validator,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      popupProps: PopupProps.menu(
        showSearchBox: showSeach,
        fit: FlexFit.loose,
        constraints: const BoxConstraints.tightFor(),
        emptyBuilder: (context, searchEntry) =>
            DropdownEmpty(noResultsLabel: noResultsLabel),
        //! IsSelected is not working
        itemBuilder: (context, item, isSelected) =>
            PopupItem(item: item, isSelected: isSelected),
        searchFieldProps: SearchFieldProps(
          searchHint,
          searchLabel,
        ).build(context),
      ),
      dropdownBuilder: (_, item) => DropdownInput(item: item, hint: hint),
      dropdownDecoratorProps: DropdownInputDecorator(
        labelText: label,
      ).build(context),
      dropdownButtonProps: DropdownButtonProps(
        padding: EdgeInsets.symmetric(horizontal: 18),
        color: AppColors.stroke,
        icon: Icon(Icons.keyboard_arrow_down_outlined),
      ),
    );
  }
}

class DropdownInput extends StatelessWidget {
  const DropdownInput({super.key, this.item, required this.hint});
  final DropdownItem? item;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Text(
      item == null || item!.text == '' ? hint : item!.text,
      style: AppTextStyles.input,
    );
  }
}

class DropdownInputDecorator extends DropDownDecoratorProps {
  const DropdownInputDecorator({required this.labelText});
  final String labelText;

  DropDownDecoratorProps build(BuildContext context) {
    return DropDownDecoratorProps(
      dropdownSearchDecoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: labelText,
        hintStyle: AppTextStyles.input,
        labelStyle: AppTextStyles.input,
        contentPadding: const EdgeInsets.only(left: 12),
        border: const OutlineInputBorder(),
      ),
    );
  }
}

class PopupItem extends StatelessWidget {
  const PopupItem({super.key, required this.item, required this.isSelected});
  final DropdownItem item;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final activeTheme = AdaptiveTheme.of(context).mode;

    return ColoredBox(
      color: isSelected
          ? AppColors.primary
          : AppColors.primary.withOpacity(0.08),
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 12, right: 18),
        title: Text(
          item.text,
          style: activeTheme == AdaptiveThemeMode.dark
              ? textTheme.bodySmall
              : textTheme.bodyMedium,
        ),
      ),
    );
  }
}

class DropdownEmpty extends StatelessWidget {
  const DropdownEmpty({super.key, required this.noResultsLabel});
  final String noResultsLabel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      child: Text(noResultsLabel, style: AppTextStyles.title),
    );
  }
}

class SearchFieldProps extends TextFieldProps {
  const SearchFieldProps(this.searchHint, this.searchLabel);
  final String? searchHint;
  final String searchLabel;

  TextFieldProps build(BuildContext context) {
    return TextFieldProps(
      style: AppTextStyles.input,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: searchLabel,
        hintText: searchHint,
        hintStyle: AppTextStyles.input,
        contentPadding: EdgeInsets.zero,
        border: const OutlineInputBorder(),
        prefixIcon: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Icon(Icons.search),
        ),
      ),
    );
  }
}
