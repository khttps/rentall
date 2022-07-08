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

class FloatingMenu extends StatelessWidget {
  const FloatingMenu(this.item, {Key? key}) : super(key: key);

  final FloatingItem item;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: const StadiumBorder(),
      padding: const EdgeInsets.fromLTRB(32.0, 10.0, 32.0, 12.0),
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

class _DefaultHeroTag {
  const _DefaultHeroTag();
  @override
  String toString() => '<default FloatingActionBubble tag>';
}

class FloatingActionMenu extends AnimatedWidget {
  const FloatingActionMenu({
    Key? key,
    required this.items,
    this.backgroundColor,
    this.iconColor,
    required Animation animation,
    this.heroTag,
  }) : super(listenable: animation, key: key);

  final List<FloatingItem> items;
  final Object? heroTag;
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
          child: FloatingMenu(items[index]),
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
              separatorBuilder: (_, __) => const SizedBox(height: 12.0),
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemCount: items.length,
              itemBuilder: buildItem,
            ),
          ),
          // FloatingActionButton(
          //   mini: true,
          //   elevation: 0.0,
          //   heroTag: heroTag ?? const _DefaultHeroTag(),
          //   backgroundColor: backgroundColor,
          //   onPressed: onPressed,
          //   child: AnimatedIcon(
          //     icon: animatedIconData,
          //     progress: _animation,
          //     color: iconColor,
          //   ),
          // ),
        ],
      ),
    );
  }
}
