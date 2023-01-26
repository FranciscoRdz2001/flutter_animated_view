import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animated_view/utils/responsive_util.dart';

class BlurredBackgroundWidget extends StatelessWidget {
  const BlurredBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = ResponsiveUtil.of(context);

    return Container(
      height: resp.height,
      width: resp.width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
          ),
          Positioned(
            top: 50,
            left: 50,
            child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: Container(
                height: resp.height,
                width: resp.width,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
