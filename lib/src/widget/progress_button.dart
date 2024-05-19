import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ProgressButton extends HookWidget {
  final Widget child;
  final Function(AnimationController)? onPressed;

  const ProgressButton({super.key, required this.child, this.onPressed});

  Widget _selectChild(AnimationController controller) {
    if (controller.isAnimating) {
      return Container();
    } else if (controller.isCompleted) {
      return const OverflowBox(
          maxWidth: 23.0, maxHeight: 23.0, child: CircularProgressIndicator());
    }
    return child;
  }

  @override
  Widget build(BuildContext context) {
    final controller =
        useAnimationController(duration: const Duration(milliseconds: 300));

    return Center(child: LayoutBuilder(builder: (context, constraints) {
      final height = (constraints.maxHeight != double.infinity)
          ? constraints.maxHeight
          : 46.0;
      final widthAnimation = Tween<double>(
        begin: constraints.maxWidth,
        end: height,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));

      return AnimatedBuilder(
          animation: controller,
          builder: (context, child) => SizedBox(
                height: height,
                width: widthAnimation.value,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(height / 2.0)),
                  ),
                  onPressed: onPressed != null &&
                          !controller.isAnimating &&
                          !controller.isCompleted
                      ? () {
                          onPressed!(controller);
                        }
                      : null,
                  child: _selectChild(controller),
                ),
              ));
    }));
  }
}
