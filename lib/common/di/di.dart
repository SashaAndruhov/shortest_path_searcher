import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shortest_path_searcher/features/search_path/data/services/data_api_service.dart';

import 'di.config.dart';

final getIt = GetIt.instance;


@InjectableInit(initializerName: 'setupDependencies', preferRelativeImports: true, asExtension: false)
GetIt configureDependencies() => setupDependencies(getIt);

@module
abstract class AppModule {

  @injectable
  SharedPreferencesAsync get flutterSharedPreferences => SharedPreferencesAsync();

}

@module
abstract class NetworkModule {

  @injectable
  Dio provideDio() {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(milliseconds: 30000),
        receiveTimeout: const Duration(milliseconds: 60000),
      ),
    );
    return dio;
  }

  @injectable
  DataApiService dataApiService(Dio dio) => DataApiService(dio);

}
