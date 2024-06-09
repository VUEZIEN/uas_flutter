import 'package:get/get.dart';

import '../controllers/detail_lelang_controller.dart';

class DetailLelangBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailLelangController>(
      () => DetailLelangController(),
    );
  }
}
