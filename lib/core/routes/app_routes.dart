import 'package:get/get.dart';

import '../../main.dart';

class AppRoutes {
  static const String home = '/';

  static List<GetPage> routes = [
    GetPage(name: home, page: () => const MyApp()),
  ];
}
