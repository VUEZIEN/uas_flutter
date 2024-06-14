import 'package:get/get.dart';

import '../modules/add-prooduk/bindings/add_prooduk_binding.dart';
import '../modules/add-prooduk/views/add_prooduk_view.dart';
import '../modules/admin/bindings/admin_binding.dart';
import '../modules/admin/views/admin_view.dart';
import '../modules/detail-lelang/bindings/detail_lelang_binding.dart';
import '../modules/detail-lelang/views/detail_lelang_view.dart';
import '../modules/detail-peserta/bindings/detail_peserta_binding.dart';
import '../modules/detail-peserta/views/detail_peserta_view.dart';
import '../modules/edit-produk/bindings/edit_produk_binding.dart';
import '../modules/edit-produk/views/edit_produk_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/lupapassword/bindings/lupapassword_binding.dart';
import '../modules/lupapassword/views/lupapassword_view.dart';
import '../modules/otp/bindings/otp_binding.dart';
import '../modules/otp/views/otp_view.dart';
import '../modules/phone/bindings/phone_binding.dart';
import '../modules/phone/views/phone_view.dart';
import '../modules/qr-view/bindings/qr_view_binding.dart';
import '../modules/qr-view/views/qr_view_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/ruang_lelang/bindings/ruang_lelang_binding.dart';
import '../modules/ruang_lelang/views/ruang_lelang_view.dart';
import '../modules/scan/bindings/scan_binding.dart';
import '../modules/scan/views/scan_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN_USER;

  static final routes = [
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: _Paths.PHONE,
      page: () => PhoneView(),
      binding: PhoneBinding(),
    ),
    GetPage(
      name: _Paths.LUPAPASSWORD,
      page: () => LupapasswordView(),
      binding: LupapasswordBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN,
      page: () => AdminView(),
      binding: AdminBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PROODUK,
      page: () => AddProodukView(),
      binding: AddProodukBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PRODUK,
      page: () => EditProdukView(),
      binding: EditProdukBinding(),
    ),
    // GetPage(
    //   name: _Paths.QR_VIEW,
    //   page: () => QrViewView(),
    //   binding: QrViewBinding(),
    // ),
    GetPage(
      name: _Paths.DETAIL_LELANG,
      page: () => DetailLelangView(),
      binding: DetailLelangBinding(),
    ),
    // GetPage(
    //   name: _Paths.SCAN,
    //   page: () => ScanView(),
    //   binding: ScanBinding(),
    // ),
    GetPage(
      name: _Paths.RUANG_LELANG,
      page: () => RuangLelangView(),
      binding: RuangLelangBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PESERTA,
      page: () => DetailPesertaView(),
      binding: DetailPesertaBinding(),
    ),
  ];
}
