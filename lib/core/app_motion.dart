import 'package:flutter/material.dart';

class AppMotion {
  static const Duration micro = Duration(milliseconds: 280);
  static const Duration medium = Duration(milliseconds: 360);
  static const Duration page = Duration(milliseconds: 500);

  static const Curve curve = Curves.easeOutCubic;

  static String productHeroTag(String id) => 'product-image-$id';

  static const double pressScale = 0.96;
  static const double carouselIdleScale = 0.95;
  static const Duration stagger = Duration(milliseconds: 70);
  static const Offset listSlideBegin = Offset(0, 0.12);
}

/// Fades and slides a list item in once, staggered by [index].
class StaggeredFadeSlide extends StatefulWidget {
  final int index;
  final Widget child;
  final Duration duration;
  final Duration staggerDelay;
  final Offset beginOffset;

  const StaggeredFadeSlide({
    super.key,
    required this.index,
    required this.child,
    this.duration = AppMotion.medium,
    this.staggerDelay = AppMotion.stagger,
    this.beginOffset = AppMotion.listSlideBegin,
  });

  @override
  State<StaggeredFadeSlide> createState() => _StaggeredFadeSlideState();
}

class _StaggeredFadeSlideState extends State<StaggeredFadeSlide>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    final curved = CurvedAnimation(parent: _controller, curve: AppMotion.curve);
    _fade = curved;
    _slide = Tween<Offset>(begin: widget.beginOffset, end: Offset.zero).animate(curved);

    final delay = widget.staggerDelay * widget.index;
    if (delay == Duration.zero) {
      _controller.forward();
    } else {
      Future<void>.delayed(delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}

/// Soft press feedback for tappable rows and cards.
class ScaleOnTap extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double pressedScale;
  final Duration duration;

  const ScaleOnTap({
    super.key,
    required this.child,
    this.onTap,
    this.pressedScale = AppMotion.pressScale,
    this.duration = AppMotion.micro,
  });

  @override
  State<ScaleOnTap> createState() => _ScaleOnTapState();
}

class _ScaleOnTapState extends State<ScaleOnTap> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (_pressed == value || widget.onTap == null) return;
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: .opaque,
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? widget.pressedScale : 1,
        duration: widget.duration,
        curve: AppMotion.curve,
        child: widget.child,
      ),
    );
  }
}
