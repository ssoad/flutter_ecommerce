import 'package:ecommerce_app/data/datasources/local/db_helper.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocalStorageService extends GetxService {
  GetStorage? _getStorage;
  DBHelper? _dbHelper;
  Rx<List<Map<String, dynamic>>> cartItems = Rx<List<Map<String, dynamic>>>([]);

  LocalStorageService() {
    init();
  }

  Future<LocalStorageService> init() async {
    _getStorage = GetStorage();
    _dbHelper = DBHelper();
    cartItems.value = await getItems();
    return this;
  }

  Future<void> saveData(String key, String value) async {
    await _getStorage?.write(key, value);
  }

  Future<dynamic> getData(String key) async {
    return await _getStorage?.read(key);
  }

  // Save to DB
  Future<int> insertItem(Map<String, dynamic> product) async {
    return await _dbHelper!.insertItem(product).whenComplete(() async => cartItems.value = await getItems());
  }

  // Get from DB
  Future<List<Map<String, dynamic>>> getItems() async {
    return await _dbHelper!.getItems();
  }

  // Update DB
  Future<int> updateItem(Map<String, dynamic> product) async {
    // return await _dbHelper!.updateItem(item);
    return 0;
  }

  void clearAll() {
    _getStorage?.erase();
  }
}
