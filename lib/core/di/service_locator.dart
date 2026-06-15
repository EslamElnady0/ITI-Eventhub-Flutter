import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/events/data/data_sources/events_remote_data_source.dart';
import '../../features/events/data/entities/event_query.dart';
import '../../features/events/data/repos/events_repository.dart';
import '../../features/events/ui/cubit/event_details_cubit.dart';
import '../../features/events/ui/cubit/events_list_cubit.dart';
import '../../features/events/ui/cubit/search_cubit.dart';
import '../../features/home/data/data_sources/home_remote_data_source.dart';
import '../../features/home/data/repos/home_repository.dart';
import '../../features/home/ui/cubit/home_cubit.dart';
import '../networking/dio_helper.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  getIt
    ..registerLazySingleton<Dio>(DioHelper.createDio)
    ..registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(getIt()),
    )
    ..registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(getIt()))
    ..registerFactory(() => HomeCubit(getIt()))
    ..registerLazySingleton<EventsRemoteDataSource>(
      () => EventsRemoteDataSourceImpl(getIt()),
    )
    ..registerLazySingleton<EventsRepository>(
      () => EventsRepositoryImpl(getIt()),
    )
    ..registerFactory(() => SearchCubit(getIt()))
    ..registerFactory(() => EventDetailsCubit(getIt()))
    ..registerFactoryParam<EventsListCubit, EventListMode, void>(
      (mode, _) => EventsListCubit(getIt(), mode: mode),
    );
}
