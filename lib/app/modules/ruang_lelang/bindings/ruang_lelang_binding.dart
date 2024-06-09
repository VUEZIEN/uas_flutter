import 'package:get/get.dart';

import '../controllers/ruang_lelang_controller.dart';

class RuangLelangBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RuangLelangController>(
      () => RuangLelangController(),
    );
  }
}
