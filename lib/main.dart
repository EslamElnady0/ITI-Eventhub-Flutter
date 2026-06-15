import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_flutter_proj/app.dart';

import 'core/di/service_locator.dart';
import 'core/observers/app_bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await setupDependencies();
  runApp(const EventHubApp());
}
