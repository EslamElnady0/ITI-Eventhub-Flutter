import 'package:flutter/material.dart';
import 'widgets/explore view/explore_view_header.dart';

class ExploreView extends StatelessWidget {
  static const String routeName = '/explore';

  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [ExploreViewHeader()]);
  }
}
