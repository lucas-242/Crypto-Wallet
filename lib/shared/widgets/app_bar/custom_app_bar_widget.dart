import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  const CustomAppBar(
      {Key? key, required this.title, this.leading, this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(SizeConfig.width, SizeConfig.height * 0.07),
      child: Container(
        height: SizeConfig.height * 0.1,
        child: Padding(
          padding: EdgeInsets.only(top: 35),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              leading != null ? leading! : Container(width: 50),
              Text(title,
                  style: AppTextStyles.titleRegular
                      .copyWith(color: AppColors.primary)),
              Row(children: actions != null ? actions! : [Container(width: 50)])
              // actions != null ? Row(children: actions!) : Container(width: 50),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(SizeConfig.height * 0.07);
}
