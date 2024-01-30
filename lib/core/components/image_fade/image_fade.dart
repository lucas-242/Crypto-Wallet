import 'package:crypto_wallet/themes/themes.dart';
import 'package:flutter/material.dart';

class ImageFade extends StatelessWidget {
  const ImageFade({super.key, this.image});
  final String? image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppBorders.radiusCircle),
      child: Container(
        height: context.height * 0.065,
        width: context.height * 0.065,
        color: AppColors.white,
        padding: const EdgeInsets.all(AppInsets.xxSm),
        child: image != null ? Image.network(image!) : Container(),
      ),
    );
  }
}
