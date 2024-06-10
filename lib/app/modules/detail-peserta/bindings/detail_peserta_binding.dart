import 'package:get/get.dart';

import '../controllers/detail_peserta_controller.dart';

class DetailPesertaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailPesertaController>(
      () => DetailPesertaController(),
    );
  }
}
