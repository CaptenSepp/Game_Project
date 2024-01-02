import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';

class MyAnimatedBackground extends StatefulWidget {
  final Widget child;
  const MyAnimatedBackground({
    super.key,
    required this.child,
  });

  @override
  State<MyAnimatedBackground> createState() => _MyAnimatedBackgroundState();
}

class _MyAnimatedBackgroundState extends State<MyAnimatedBackground> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
      behaviour: RandomParticleBehaviour(
        options: const ParticleOptions(
          spawnMaxRadius: 80,
          spawnMinRadius: 40,
          spawnMaxSpeed: 250,
          spawnMinSpeed: 100,
          particleCount: 0, // must have amount to start working
          maxOpacity: .8,
          minOpacity: .5,

          ///// spawnOpacity: 0.6,
          //// baseColor: Colors.red,
          // image: Image(image: AssetImage('assets/q.png')),
        ),
      ),
      vsync: this,
      child: widget.child, // TODO, i tried to make AnimatedBackground also a extra widget but because of vsync i couldn't
    );
  }
}
