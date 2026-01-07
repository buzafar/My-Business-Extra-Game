import 'package:flutter/material.dart';

class BalanceChange extends StatefulWidget {
  const BalanceChange({super.key, required this.change});

  final num change;

  @override
  State<BalanceChange> createState() => _BalanceChangeState();
}

class _BalanceChangeState extends State<BalanceChange> {
  bool _visible = true;

  @override
  void initState() {
    super.initState();

    // make balance change disappear after 3 seconds because the balance changes, overall, appear and disappear
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      setState(() {
        _visible = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_visible) return const SizedBox.shrink();
    return Text("${widget.change}", style: TextTheme.of(context).bodySmall);
  }
}
