import 'package:get/get.dart';

import '../controllers/add_prooduk_controller.dart';

class AddProodukBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddProodukController>(
      () => AddProodukController(),
    );
  }
}
