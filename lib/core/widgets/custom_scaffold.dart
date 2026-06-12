import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final bool ignoreTopSafeArea;
  const CustomScaffold({
    super.key,
    required this.body,
    this.ignoreTopSafeArea = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(top: !ignoreTopSafeArea, bottom: false, child: body),
    );
  }
}
