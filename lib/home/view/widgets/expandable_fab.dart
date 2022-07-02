import 'dart:math';

import 'package:flutter/material.dart';

class ExpandableFab extends StatefulWidget {
  final List<Widget> children;
  ExpandableFab({
    required this.children,
    Key? key,
  }) : super(key: key);

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  bool _open = false;

  late AnimationController _controller;
  late final Tween<double> _tween;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _tween = Tween(begin: 0.0, end: pi / 4);
    _animation = _tween.animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      mini: true,
      elevation: 0,
      child: Transform.rotate(
        angle: _animation.value,
        child: const Icon(Icons.add),
      ),
      onPressed: () {
        toggle();
      },
    );
  }
}
