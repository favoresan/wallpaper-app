import 'package:shared_preferences/shared_preferences.dart';

import 'constant.dart';

class AppPreferences {
  SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<void> setFavorite(List<String> fav) async {
    _sharedPreferences.setStringList(Constant.PREF_KEY_SET_FAVORITE, fav);
  }
}
