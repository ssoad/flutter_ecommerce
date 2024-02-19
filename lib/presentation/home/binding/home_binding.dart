import 'package:ecommerce_app/core/services/local_storage_service.dart';
import 'package:ecommerce_app/presentation/home/controller/home_screen_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.putAsync(() => LocalStorageService().init(), permanent: true);
    Get.lazyPut<HomeScreenController>(() => HomeScreenController());
  }
}
