import 'dart:math';

import 'package:flutter/material.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({
    super.key,
    required this.child,
    required this.drawer,
  });

  final Widget child;
  final Widget drawer;

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> with TickerProviderStateMixin {
  late AnimationController _xChildController;
  late Animation<double> _yChildRotation;

  late AnimationController _xDrawerController;
  late Animation<double> _yDrawerRotation;

  @override
  void initState() {
    super.initState();
    _xChildController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _yChildRotation = Tween<double>(
      begin: 0,
      end: -pi / 2,
    ).animate(_xChildController);

    _xDrawerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _yDrawerRotation = Tween<double>(
      begin: pi / 2.7,
      end: 0,
    ).animate(_xDrawerController);
  }

  @override
  void dispose() {
    _xChildController.dispose();
    _xDrawerController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final maxDrag = width * 0.8;

    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        final delta = details.delta.dx / maxDrag;
        _xChildController.value += delta;
        _xDrawerController.value += delta;
      },
      onHorizontalDragEnd: (details) {
        if (_xChildController.value < 0.5) {
          _xChildController.reverse();
          _xDrawerController.reverse();
        } else {
          _xChildController.forward();
          _xDrawerController.forward();
        }
      },
      child: AnimatedBuilder(
          animation: Listenable.merge([
            _xChildController,
            _xDrawerController,
          ]),
          builder: (context, child) {
            return Stack(
              children: [
                Container(color: const Color(0xff1a1b26)),
                Transform(
                  alignment: Alignment.centerLeft,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..translate(_xChildController.value * maxDrag)
                    ..rotateY(_yChildRotation.value),
                  child: widget.child,
                ),
                Transform(
                  alignment: Alignment.centerRight,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..translate(-width + _xDrawerController.value * maxDrag)
                    ..rotateY(_yDrawerRotation.value),
                  child: widget.drawer,
                ),
              ],
            );
          }),
    );
  }
}
