import 'package:flutter/material.dart';
import 'package:tic_tac_toe/src/common/constants/app_constant.dart';


/// A simple animation that 'bounces in' its [child].
class BounceInAnimation extends StatefulWidget {
  const BounceInAnimation({
    Key? key,
    required this.child,
    this.duration = DURATION_SHORT,
    this.delay = Duration.zero,
  }) : super(key: key);

  final Widget child;
  final Duration duration;
  final Duration delay;

  @override
  _BounceInAnimationState createState() => _BounceInAnimationState();
}

class _BounceInAnimationState extends State<BounceInAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..addListener(() {
        if (mounted) {
          setState(() {});
        }
      });

    _animation = CurveTween(curve: Curves.elasticOut).animate(_controller);

    Future<void>.delayed(widget.delay).then((_) {
      if (mounted) {
        _controller.forward();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext _, Widget? child) => Transform.scale(
        scale: _animation.value,
        child: widget.child,
      ),
      child: widget.child,
    );
  }
}