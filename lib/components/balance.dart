import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:my_business_extra/components/floating_bubble_widget.dart';
import 'package:my_business_extra/global_state_providers/current_user_provider.dart';

import '../helpers/helper_functions.dart';

class BalanceCounter extends ConsumerStatefulWidget {
  const BalanceCounter({super.key, required this.balance});

  final num balance;

  @override
  ConsumerState<BalanceCounter> createState() => _BalanceCounterState();
}

class _BalanceCounterState extends ConsumerState<BalanceCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<Color?> _colorAnimation;

  num _previousBalance = 0;
  num _displayBalance = 0;

  @override
  void initState() {
    super.initState();
    _previousBalance = widget.balance;
    _displayBalance = widget.balance;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animation = Tween<double>(
        begin: _previousBalance.toDouble(),
        end: _displayBalance.toDouble(),
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {});
      });

    _colorAnimation = ColorTween(
      begin: Colors.white,
      end: Colors.white,
    ).animate(_controller);
  }

  final List<num> balanceChangesHistory = [];

  @override
  void didUpdateWidget(covariant BalanceCounter oldWidget) {
    super.didUpdateWidget(oldWidget);

    balanceChangesHistory.add(widget.balance - oldWidget.balance);

    if (oldWidget.balance != widget.balance) {
      final gain = widget.balance > oldWidget.balance;

      _previousBalance = _displayBalance;
      _displayBalance = widget.balance;

      // Animate balance value
      _animation = Tween<double>(
        begin: _previousBalance.toDouble(),
        end: _displayBalance.toDouble(),
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

      // Animate color flash
      _colorAnimation = ColorTween(
        begin: gain ? Colors.green : Colors.red,
        end: Colors.white,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

      _controller
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleMedium!.copyWith(
      color: _colorAnimation.value,
      fontWeight: FontWeight.bold,
    );

    return Row(
      children: [
        Text(formatPrice(_animation.value), style: textStyle),
        Container(
          child: Row(
            children: [
              for (var change in balanceChangesHistory)
                Padding(
                  padding: EdgeInsets.only(right: 4),
                  child: Text(
                    "$change",
                    style: TextTheme.of(context).bodySmall,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
