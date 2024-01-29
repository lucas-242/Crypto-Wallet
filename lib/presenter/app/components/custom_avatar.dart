import 'package:crypto_wallet/themes/themes.dart';
import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {
  const CustomAvatar({super.key, this.image});

  final String? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      padding: const EdgeInsets.all(AppInsets.xxSm),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.contain,
          image: (image != null
              ? NetworkImage(image!)
              : const AssetImage(AppImages.logo)) as ImageProvider,
        ),
      ),
    );
  }
}
