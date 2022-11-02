import 'package:wallpaper_demo/data/responses/responses.dart';

import '../error_handler.dart';

const CACHE_HOME_KEY = 'CACHE_HOME_KEY';
const CACHE_INTERVAL = 60 * 1000; //1 min

abstract class LocalDataSource {
  Future<ImageResponse> getGrid();
  Future<void> saveHomeToCache(ImageResponse homeResponse);
  void clearCache();
  void removeFromCache(String key);
}

class LocalDataSourceImplementer implements LocalDataSource {
//runtime cache
  Map<String, CachedItem> cacheMap = Map();
  @override
  Future<ImageResponse> getGrid() async {
    CachedItem? cachedItem = cacheMap[CACHE_HOME_KEY];
    if (cachedItem != null && cachedItem.isValid(CACHE_INTERVAL)) {
      //return response from cache
      return cachedItem.data;
    } else {
      //return error that cache is not valid
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveHomeToCache(ImageResponse imageResponse) async {
    cacheMap[CACHE_HOME_KEY] = CachedItem(imageResponse);
  }

  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }
}

class CachedItem {
  dynamic data;
  int cacheTime = DateTime.now().millisecondsSinceEpoch;
  CachedItem(this.data);
}

extension CachedItemExtension on CachedItem {
  bool isValid(int expirationTime) {
    int currentTimeInMillis = DateTime.now().millisecondsSinceEpoch;
    bool isCacheValid = currentTimeInMillis - expirationTime < cacheTime;
    return isCacheValid;
  }
}
