import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {
  Future<void> saveUrl(String value);

  Future<String?> getSavedUrl();
}

const _urlKey = 'url_key';

@Injectable(as: LocalDataSource)
class LocalDataSourceStore extends LocalDataSource {
  LocalDataSourceStore(this._sharedPreferences);

  final SharedPreferencesAsync _sharedPreferences;

  @override
  Future<void> saveUrl(String value) async {
    await _sharedPreferences.setString(_urlKey, value);
  }

  @override
  Future<String?> getSavedUrl() async {
    return _sharedPreferences.getString(_urlKey);
  }
}
