import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:shortest_path_searcher/features/search_path/data/models/data_for_processing_response.dart';

part 'data_api_service.g.dart';

@RestApi()
abstract class DataApiService {
  factory DataApiService(Dio dio, {String? baseUrl, ParseErrorLogger? errorLogger}) =
      _DataApiService;

  @GET('{url}')
  Future<DataForProcessingResponse> getFieldsList(@Path() String url) ;

  // @POST('/achievements/user/last-request/')
  // Future<void> setAchievementsLastRequest(@Body() SetAchievementsLastRequest data);


}
