import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/constant.dart';
import 'app/di.dart';

final numProvider = StateProvider((ref) => 0);

final favProvider = StateProvider((ref) =>
    instance<SharedPreferences>()
        .getStringList(Constant.PREF_KEY_SET_FAVORITE) ??
    []);
