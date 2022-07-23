import 'package:flutter/material.dart';

class LikeAnimation extends StatefulWidget {
  final Widget child;
  final bool isAnimating;
  final Duration duration;
  final VoidCallback? onEnd;
  final bool isLiked; 
  const LikeAnimation({super.key, required this.child, this.isAnimating = false, this.duration = const Duration(milliseconds: 500), this.onEnd, this.isLiked = false});

  @override
  State<LikeAnimation> createState() => _LikeAnimationState();
}

class _LikeAnimationState extends State<LikeAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}