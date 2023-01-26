import 'package:flutter/material.dart';
import 'package:flutter_animated_view/widgets/blurred_background/blurred_background_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: const [
          BlurredBackgroundWidget(),
        ],
      ),
    );
  }
}
