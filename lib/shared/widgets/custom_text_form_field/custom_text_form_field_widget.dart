import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String labelText;
  final String hintText;
  final IconData icon;
  final String? initialValue;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String value)? onChanged;

  const CustomTextFormField({
    Key? key,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    required this.labelText,
    required this.icon,
    this.hintText = '',
    this.initialValue,
    this.validator,
    this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          TextFormField(
            controller: controller,
            initialValue: initialValue,
            validator: validator,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            onChanged: onChanged,
            style: textTheme.caption,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: labelText,
              // labelStyle: textTheme.caption,
              hintText: hintText,
              hintStyle: textTheme.caption,
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(),
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: Icon(icon, color: AppColors.primary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
