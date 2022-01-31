import 'package:tvseries_app/core/utils/store_manager.dart';

abstract class AuthLocalData {
  Future<bool> setPin(String pin);
  Future<String> getPin();
  Future<List<String>> getFavorites();
  Future<bool> saveFavorite(String id);
  Future<bool> deleteFavorite(String id);
  Future<bool> existFavorite(String id);
}

class AuthLocalDataImple implements AuthLocalData {
  AuthLocalDataImple();

  @override
  Future<List<String>> getFavorites() async {
    //StorageManager.deleteData("favorites");
    String? favorites = await StorageManager.readData("favorites");
    List<String> list = [];
    if (favorites != null && favorites != '') {
      list = favorites.split(',').map((o) => o).toSet().toList();
    }
    final favoritesNew = list.isEmpty ? '' : list.join(',');
    await StorageManager.saveData("favorites", favoritesNew);
    return list;
  }

  @override
  Future<bool> saveFavorite(String id) async {
    deleteFavorite(id);
    String? favorites = await StorageManager.readData("favorites");
    favorites = favorites == null || favorites == '' ? id : favorites + ',$id';
    return await StorageManager.saveData("favorites", favorites);
  }

  @override
  Future<bool> deleteFavorite(String id) async {
    String? favorites = await StorageManager.readData("favorites");
    if (favorites != null) {
      final list = favorites.split(',');
      list.removeWhere((element) => element == id);
      final favoritesNew = list.isEmpty ? '' : list.join(',');
      return await StorageManager.saveData("favorites", favoritesNew);
    } else {
      return false;
    }
  }

  @override
  Future<bool> existFavorite(String id) async {
    String? favorites = await StorageManager.readData("favorites");
    if (favorites != null) {
      final exist = favorites.split(',').any((element) => element == id);
      return exist;
    } else {
      return false;
    }
  }

  @override
  Future<String> getPin() async {
    String? pin = await StorageManager.readData("pin");
    return pin ?? '';
  }

  @override
  Future<bool> setPin(String pin) async {
    return await StorageManager.saveData("pin", pin);
  }
}
