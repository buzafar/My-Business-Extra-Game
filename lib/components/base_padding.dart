import 'package:flutter/material.dart';
import 'package:my_business_extra/designs/values.dart';

// THIS IS A COMMON PADDING THAT AVOIDS THE TOP INFO BAR WHERE BALANCE AND OTHER INFO ARE CONSTANTLY SHOWN IN ALL PAGES.
// IT WORKS PROPERLY ONLY IF THIS BASEPADDING IS A CHILD OF SAFE AREA WHO IS A BODY OF A SCAFFOLD
class BasePadding extends StatelessWidget {
  const BasePadding({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(
        top: DesignValues.topPadding,
        left: DesignValues.screenPadding,
        right: DesignValues.screenPadding,
      ),
      child: child,
    );
  }
}
