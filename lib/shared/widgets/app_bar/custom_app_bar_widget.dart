import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  const CustomAppBar({Key? key, required this.title, this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(SizeConfig.width, SizeConfig.height * 0.07),
      child: Container(
        child: Padding(
          padding: EdgeInsets.only(top: 35),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(width: 50),
              Text(title,
                  style: AppTextStyles.titleRegular
                      .copyWith(color: AppColors.primary)),
              actions != null ? Row(children: actions!) : Container(width: 50),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(SizeConfig.height * 0.07);
}
