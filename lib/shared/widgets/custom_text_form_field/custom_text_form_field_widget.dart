import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String labelText;
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
    this.initialValue,
    this.validator,
    this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          TextFormField(
            controller: controller,
            initialValue: initialValue,
            validator: validator,
            onChanged: onChanged,
            style: AppTextStyles.input,
            decoration: InputDecoration(
                labelText: labelText,
                labelStyle: AppTextStyles.input,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                icon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      child: Icon(icon, color: AppColors.primary),
                    ),
                    Container(
                      width: 1,
                      height: 48,
                      color: AppColors.stroke,
                    )
                  ],
                )),
          ),
          Divider(
            color: AppColors.stroke,
            height: 1,
            thickness: 1,
          ),
        ],
      ),
    );
    return Container(
        child: TextFormField(
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
      ),
    ));
  }
}
