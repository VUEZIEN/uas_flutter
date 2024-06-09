import 'package:get/get.dart';

import '../controllers/qr_view_controller.dart';

class QrViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QrViewController>(
      () => QrViewController(),
    );
  }
}
