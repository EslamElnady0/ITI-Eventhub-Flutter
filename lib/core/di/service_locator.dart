import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../features/auth/data/data_sources/auth_local_data_source.dart';
import '../../features/auth/data/repos/auth_repository.dart';
import '../../features/auth/ui/cubit/auth_cubit.dart';
import '../../features/events/data/data_sources/events_remote_data_source.dart';
import '../../features/events/data/data_sources/events_local_data_source.dart';
import '../../features/events/data/entities/event_query.dart';
import '../../features/events/data/repos/events_repository.dart';
import '../../features/events/ui/cubit/details/event_details_cubit.dart';
import '../../features/events/ui/cubit/events_list/events_list_cubit.dart';
import '../../features/events/ui/cubit/favorites/favorites_cubit.dart';
import '../../features/events/ui/cubit/search/search_cubit.dart';
import '../../features/home/data/data_sources/home_remote_data_source.dart';
import '../../features/home/data/repos/home_repository.dart';
import '../../features/home/ui/cubit/home_cubit.dart';
import '../../features/profile/ui/cubit/profile_cubit.dart';
import '../helpers/local_db_helper.dart';
import '../helpers/local_storage_helper.dart';
import '../networking/dio_helper.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  getIt
    ..registerLazySingleton<Dio>(DioHelper.createDio)
    ..registerLazySingleton<Uuid>(Uuid.new)
    ..registerLazySingleton<LocalDbHelper>(LocalDbHelper.new)
    ..registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage(),
    )
    ..registerLazySingleton<SharedPreferences>(() => sharedPreferences)
    ..registerLazySingleton<LocalStorageHelper>(
      () => LocalStorageHelper(getIt(), getIt()),
    )
    ..registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(getIt()),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(getIt(), getIt(), getIt()),
    )
    ..registerLazySingleton(() => AuthCubit(getIt()))
    ..registerFactory(() => ProfileCubit(getIt()))
    ..registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(getIt()),
    )
    ..registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(getIt()))
    ..registerFactory(() => HomeCubit(getIt()))
    ..registerLazySingleton<EventsRemoteDataSource>(
      () => EventsRemoteDataSourceImpl(getIt()),
    )
    ..registerLazySingleton<EventsLocalDataSource>(
      () => EventsLocalDataSourceImpl(getIt()),
    )
    ..registerLazySingleton<EventsRepository>(
      () => EventsRepositoryImpl(getIt(), getIt()),
    )
    ..registerFactory(() => SearchCubit(getIt()))
    ..registerFactory(() => EventDetailsCubit(getIt()))
    ..registerLazySingleton(() => FavoritesCubit(getIt(), getIt()))
    ..registerFactoryParam<EventsListCubit, EventListMode, void>(
      (mode, _) => EventsListCubit(getIt(), mode: mode),
    );
}
