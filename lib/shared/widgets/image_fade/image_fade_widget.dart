import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:flutter/material.dart';

class ImageFade extends StatelessWidget {
  final String? image;
  const ImageFade({Key? key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Container(
        height: SizeConfig.height * 0.065,
        width: SizeConfig.width * 0.13,
        color: Colors.white54,
        child: Padding(
            padding: EdgeInsets.all(5),
            child: image != null ? Image.network(image!) : Container()),
      ),
    );
  }
}
