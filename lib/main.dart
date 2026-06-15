import 'package:flutter/material.dart';
import 'package:iti_flutter_proj/app.dart';

import 'core/di/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(const EventHubApp());
}
