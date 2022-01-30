import 'package:tvseries_app/core/utils/store_manager.dart';

abstract class AuthLocalData {
  Future<List<String>> getFavorites();
  Future<bool> saveFavorite(String id);
  Future<bool> deleteFavorite(String id);
}

class AuthLocalDataImple implements AuthLocalData {
  AuthLocalDataImple();

  @override
  Future<List<String>> getFavorites() async {
    String? favorites = await StorageManager.readData("favorites");
    return favorites == null ? [] : favorites.split(',');
  }

  @override
  Future<bool> saveFavorite(String id) async {
    String? favorites = await StorageManager.readData("favorites");
    favorites = favorites == null ? id : favorites + ',$id';
    return await StorageManager.saveData("favorites", favorites);
  }

  @override
  Future<bool> deleteFavorite(String id) async {
    String? favorites = await StorageManager.readData("favorites");
    if (favorites != null) {
      favorites.split(',').removeWhere((element) => element == id);
      final newList = favorites.allMatches(',').toList();
      return await StorageManager.saveData("favorites", newList);
    } else {
      return false;
    }
  }
}
