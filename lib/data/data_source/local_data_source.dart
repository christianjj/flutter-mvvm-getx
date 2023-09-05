import 'package:flutter_restapi/data/network/error_handler.dart';

import '../responses/responses.dart';

const CACHE_HOME_KEY = "CACHE_HOME_KEY";
const CACHE_HOME_INTERVAL = 60 * 1000;


const CACHE_STORE_DETAILS_KEY = "CACHE_STORE_DETAILS_KEY";
const CACHE_STORE_DETAILS_INTERVAL = 60 * 1000;

abstract class LocalDataSource {
  Future<HomeResponse> getHome();


  Future<void> saveHomeToCache(HomeResponse homeResponse);

  void clearCache();

  void removeFromCache(String key);

  Future<StoreDetailsResponse> getStoreDetails();

  Future<void> saveStoreDetailsCache(StoreDetailsResponse response);


}

class LocalRemoteDataSourceImplementer implements LocalDataSource {
  Map<String, CachedItem> cacheMap = Map();

  @override
  Future<HomeResponse> getHome() async {
    CachedItem? cachedItem = cacheMap[CACHE_HOME_KEY];

    if (cachedItem != null && cachedItem.isValid(CACHE_HOME_INTERVAL)) {

      return cachedItem.data;
      //return the response from cache
    } else {
      //return error that cache is not valid
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveHomeToCache(HomeResponse homeResponse) async {
    cacheMap[CACHE_HOME_KEY] = CachedItem(homeResponse);

  }

  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
  cacheMap.remove(key);
  }

  @override
  Future<StoreDetailsResponse> getStoreDetails() async {
    CachedItem? cachedItem = cacheMap[CACHE_STORE_DETAILS_KEY];

    if (cachedItem != null && cachedItem.isValid(CACHE_STORE_DETAILS_INTERVAL)) {
      return cachedItem.data;
      //return the response from cache


    } else {
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveStoreDetailsCache(StoreDetailsResponse response) async {
    cacheMap[CACHE_STORE_DETAILS_KEY] = CachedItem(response);

  }
}

class CachedItem {
  dynamic data;

  int cacheTime = DateTime.now().millisecondsSinceEpoch;

  CachedItem(this.data);
}

extension CachedItemExtension on CachedItem {
  bool isValid(int expirationTime) {
    int currentTimeinMillis =
        DateTime.now().millisecondsSinceEpoch; // time now is 1:00 pm
    bool isCacheValid = currentTimeinMillis - expirationTime <
        cacheTime; // cache time was in 12:59:30
    // false if current time > 1:00:30
    //true if current time  < 1:00:30
    return isCacheValid;
  }
}
