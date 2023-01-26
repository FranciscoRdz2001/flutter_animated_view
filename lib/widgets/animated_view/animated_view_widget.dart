import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animated_view/utils/responsive_util.dart';

class AnimatedViewWidget extends StatefulWidget {
  const AnimatedViewWidget({super.key});

  @override
  State<AnimatedViewWidget> createState() => _AnimatedViewWidgetState();
}

class _AnimatedViewWidgetState extends State<AnimatedViewWidget> {
  late final PageController _controller;
  late final Timer _timer;
  late int _currentPage = 0;
  late Color _color;
  late double _currentAngle;
  static const List<Color> _colors = [
    Color(0xff645CBB),
    Color(0xff1F8A70),
    Color(0xff7286D3),
    Color(0xff301E67),
    Color(0xff658864),
    Color(0xff6F1AB6),
  ];

  @override
  void initState() {
    super.initState();
    _currentAngle = -45;
    _color = _colors.first;
    _controller = PageController(initialPage: _currentPage);
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      _currentPage += 1;
      setState(() {
        _color = _colors[Random().nextInt(_colors.length)];
        _currentAngle -= 180;
        // if (_currentAngle > 360) _currentAngle = 1;
      });
      print(_currentAngle);

      _controller.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final resp = ResponsiveUtil.of(context);
    return SizedBox(
      height: resp.height,
      width: resp.width,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            top: -resp.hp(35),
            left: -resp.wp(30),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.fastOutSlowIn,
                  height: resp.hp(65),
                  width: resp.width,
                  transform: Matrix4.rotationZ(_currentAngle * pi / 180),
                  transformAlignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _color,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 70, bottom: 70),
                  child: Text(
                    'Hello',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: resp.hp(50),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              width: resp.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Test animation',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: resp.hp(2.5)),
                  Container(
                    height: resp.hp(30),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: PageView.builder(
                      controller: _controller,
                      itemCount: 100,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 350),
                            curve: Curves.fastOutSlowIn,
                            decoration: BoxDecoration(
                              color: _color,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                index.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
