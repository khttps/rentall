import 'package:flutter/material.dart';

class FloatingItem {
  const FloatingItem({
    required this.title,
    this.color,
    required this.icon,
    required this.onPressed,
  });

  final Widget icon;
  final Color? color;
  final void Function() onPressed;
  final Widget title;
}

class _FloatingMenuItem extends StatelessWidget {
  const _FloatingMenuItem(this.item, {Key? key}) : super(key: key);

  final FloatingItem item;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: const StadiumBorder(),
      padding: const EdgeInsetsDirectional.fromSTEB(12.0, 10.0, 16.0, 10.0),
      color: item.color ?? Colors.blueGrey,
      splashColor: Colors.grey.withOpacity(0.1),
      highlightColor: Colors.grey.withOpacity(0.1),
      elevation: 2,
      highlightElevation: 2,
      disabledColor: item.color,
      onPressed: item.onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          item.icon,
          const SizedBox(width: 10.0),
          item.title,
        ],
      ),
    );
  }
}

class FloatingActionMenu extends AnimatedWidget {
  const FloatingActionMenu({
    Key? key,
    required this.items,
    this.backgroundColor,
    this.iconColor,
    required Animation animation,
  }) : super(listenable: animation, key: key);

  final List<FloatingItem> items;

  final Color? backgroundColor;
  final Color? iconColor;

  get _animation => listenable;

  Widget buildItem(BuildContext context, int index) {
    final screenWidth = MediaQuery.of(context).size.width;

    TextDirection textDirection = Directionality.of(context);

    double animationDirection = textDirection == TextDirection.ltr ? -1 : 1;

    final transform = Matrix4.translationValues(
      animationDirection *
          (screenWidth - _animation.value * screenWidth) *
          ((items.length - index) / 4),
      0.0,
      0.0,
    );

    return Align(
      alignment: AlignmentDirectional.bottomEnd,
      child: Transform(
        transform: transform,
        child: Opacity(
          opacity: _animation.value,
          child: _FloatingMenuItem(items[index]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.bottomEnd,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IgnorePointer(
            ignoring: _animation.value == 0,
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (_, __) => const SizedBox(height: 8.0),
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemCount: items.length,
              itemBuilder: buildItem,
            ),
          ),
        ],
      ),
    );
  }
}
