import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final bool ignoreTopSafeArea;
  final Widget? bottomNavigationBar;
  const CustomScaffold({
    super.key,
    required this.body,
    this.ignoreTopSafeArea = false,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigationBar,
      body: SafeArea(top: !ignoreTopSafeArea, bottom: false, child: body),
    );
  }
}
