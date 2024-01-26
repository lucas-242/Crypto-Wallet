import 'package:crypto_wallet/themes/themes.dart';
import 'package:flutter/material.dart';

import 'components/sliding_gradient_transform.dart';

class Shimmer extends StatefulWidget {
  const Shimmer({
    super.key,
    this.child,
  });

  static ShimmerState? of(BuildContext context) {
    return context.findAncestorStateOfType<ShimmerState>();
  }

  final Widget? child;

  @override
  ShimmerState createState() => ShimmerState();
}

class ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;

  Listenable get shimmerChanges => _shimmerController;

  LinearGradient get gradient => LinearGradient(
        colors: AppColors.shimmerGradient.colors,
        stops: AppColors.shimmerGradient.stops,
        begin: AppColors.shimmerGradient.begin,
        end: AppColors.shimmerGradient.end,
        transform: SlidingGradientTransform(
          slidePercent: _shimmerController.value,
        ),
      );

  bool get isSized =>
      (context.findRenderObject() as RenderBox?)?.hasSize ?? false;

  Size get size => (context.findRenderObject() as RenderBox).size;

  Offset getDescendantOffset({
    required RenderBox descendant,
    Offset offset = Offset.zero,
  }) {
    final shimmerBox = context.findRenderObject() as RenderBox;
    return descendant.localToGlobal(offset, ancestor: shimmerBox);
  }

  @override
  void initState() {
    super.initState();

    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -0.5, max: 1.5, period: const Duration(milliseconds: 1000));
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child ?? const SizedBox.shrink();
  }
}
