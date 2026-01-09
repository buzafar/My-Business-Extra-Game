import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:my_business_extra/components/floating_bubble_widget.dart';
import 'package:my_business_extra/global_state_providers/current_user_provider.dart';

import '../helpers/helper_functions.dart';

class BalanceChange {
  int secondsRemaining = 5;
  num change;

  BalanceChange(this.change);
}

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

    // every balance change is listed out but each of them get removed after 3 seconds
    Timer.periodic(Duration(seconds: 1), (_) {
      for (final bc in balanceChangesHistory) {
        bc.secondsRemaining -= 1;
      }

      balanceChangesHistory.removeWhere((bc) => bc.secondsRemaining <= 0);

      if (mounted) setState(() {});
    });
  }

  // final List<num> balanceChangesHistory = [];
  final List<BalanceChange> balanceChangesHistory = [];

  @override
  void didUpdateWidget(covariant BalanceCounter oldWidget) {
    super.didUpdateWidget(oldWidget);

    balanceChangesHistory.add(
      BalanceChange(widget.balance - oldWidget.balance),
    );

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
      fontWeight: FontWeight.w500,
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Text(formatPrice(_animation.value), style: textStyle),
          Gap(8),
          Row(
            children: [
              for (var balanceChange in balanceChangesHistory)
                Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Container(
                    padding: EdgeInsets.all(2),

                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryFixed,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "${formatPrice(balanceChange.change, addPlus: balanceChange.change > 0)}",
                      style: TextTheme.of(context).bodySmall!.copyWith(
                        color:
                            balanceChange.change < 0
                                ? Colors.red
                                : Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
