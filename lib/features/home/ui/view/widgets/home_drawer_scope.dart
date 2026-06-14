import 'package:flutter/widgets.dart';

class HomeDrawerScope extends InheritedWidget {
  final VoidCallback openDrawer;

  const HomeDrawerScope({
    super.key,
    required this.openDrawer,
    required super.child,
  });

  static HomeDrawerScope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<HomeDrawerScope>();
    assert(scope != null, 'HomeDrawerScope was not found in the widget tree.');
    return scope!;
  }

  @override
  bool updateShouldNotify(HomeDrawerScope oldWidget) {
    return openDrawer != oldWidget.openDrawer;
  }
}
