import 'package:flutter/material.dart';
import 'package:tabler_icons/tabler_icons.dart';

class BoxLoader extends StatefulWidget {
  final Color color;

  const BoxLoader({Key? key, required this.color}) : super(key: key);

  @override
  State<BoxLoader> createState() => _BoxLoaderState();
}

class _BoxLoaderState extends State<BoxLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.5).animate(_controller),
      child: Icon(
        TablerIcons.loader,
        color: widget.color,
        size: 24,
      ),
    );
  }
}
