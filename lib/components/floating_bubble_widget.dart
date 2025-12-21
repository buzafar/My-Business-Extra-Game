import 'package:flutter/material.dart';
import 'package:my_business_extra/my_material_app.dart';

class FloatingBubbleWidget extends StatefulWidget {
  final Offset startPosition;
  final Widget widget;

  const FloatingBubbleWidget({
    super.key,
    required this.startPosition,
    required this.widget,
  });

  @override
  State<FloatingBubbleWidget> createState() => _FloatingTextState();
}

class _FloatingTextState extends State<FloatingBubbleWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _offset;

  late Widget child;

  @override
  void initState() {
    super.initState();

    child = widget.widget;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );

    _opacity = Tween<double>(begin: 1, end: 0).animate(_controller);

    _offset = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -50), // float upward
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.startPosition.dx,
      top: widget.startPosition.dy,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          return Opacity(
            opacity: _opacity.value,
            child: Transform.translate(offset: _offset.value, child: child),
          );
        },
      ),
    );
  }
}

void showPopup(
  BuildContext context, {
  required Offset position,
  required Widget widget,
}) {
  final overlay = Overlay.of(context, rootOverlay: true);

  late OverlayEntry entry;

  entry = OverlayEntry(
    builder:
        (_) => FloatingBubbleWidget(startPosition: position, widget: widget),
  );

  overlay.insert(entry);

  Future.delayed(const Duration(milliseconds: 4000), () {
    entry.remove();
  });
}
