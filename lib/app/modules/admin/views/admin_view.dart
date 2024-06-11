// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:uas_flutter/app/controllers/authcontroller.dart';
import 'package:uas_flutter/app/modules/admin/model/produk.model.dart';
import 'package:uas_flutter/app/routes/app_pages.dart';
import 'package:uas_flutter/color/color.dart';
import 'package:intl/intl.dart';
import '../controllers/admin_controller.dart';

String formatRupiah(double value) {
  final formatter =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
  return formatter.format(value);
}

String capitalize(String input) {
  if (input.isEmpty) {
    return input;
  }
  return input[0].toUpperCase() + input.substring(1);
}

class AdminView extends GetView<AdminController> {
  final auth = Get.put(AuthController());
  final srt = Get.put(AuthController());

  List<String> option = ['SOLD', 'BELUM SOLD', 'SEMUA'];
  String selectOption = 'SEMUA';
  bool showAllData = false;

  @override
  Widget build(BuildContext context) {
    final lebar = MediaQuery.of(context).size.width;
    controller.filterData(true);

    return Scaffold(
        appBar: AppBar(
          title: Text('Data Produk', style: TextStyle(color: Colors.white)),
          backgroundColor: CustomColors.ijoMuda,
          foregroundColor: Colors.white,
        ),
        drawer: Drawer(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: CustomColors.ijoMuda,
                ),
                child: Center(
                  child: Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              ListTile(
                title: Text('Tambah Produk'),
                onTap: () {
                  // Action when "Tambah Produk" is tapped
                  Get.toNamed(Routes.ADD_PROODUK);
                },
              ),
              Spacer(), // Spacer to push the next ListTile to the bottom
              ListTile(
                title: Row(
                  children: [
                    Text('${controller.user?.email} '),
                    Spacer(), // Spacer added here
                    InkWell(
                      child: Icon(Icons.logout_rounded),
                      onTap: () {
                        Get.defaultDialog(
                          title: 'Apakah anda yakin?',
                          middleText: 'Sign Out dari lelang online?',
                          confirm: ElevatedButton(
                            onPressed: () => auth.logout(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: CustomColors.ijoTua,
                            ),
                            child: Text(
                              'Ya!',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          cancel: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: CustomColors.kremTua,
                            ),
                            onPressed: () => Get.back(),
                            child: Text(
                              'Tidak!',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                SizedBox(height: 24),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Status',
                  ),
                  value: selectOption,
                  items: option.map((option) {
                    return DropdownMenuItem<String>(
                      value: option.toString(),
                      child: Text(option.toString()),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    if (newValue == 'BELUM SOLD') {
                      controller.filterData(true);
                    } else if (newValue == 'SEMUA') {
                      showAllData = false;
                      controller.filterData(null);
                    } else {
                      controller.filterData(false);
                    }
                  },
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(width: 2),
                        Text('BELUM SOLD')
                      ],
                    ),
                    SizedBox(width: 6),
                    Row(
                      children: [
                        Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(width: 2),
                        Text('SUDAH SOLD')
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Obx(() => controller.status.value
                    ? SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children:
                              List.generate(controller.data.length, (index) {
                            Produk dt = controller.data[index];

                            return GestureDetector(
                              onTap: () {
                                if (dt.status) {
                                  Get.toNamed(Routes.QR_VIEW, arguments: dt);
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 8),
                                padding: EdgeInsets.only(right: 8),
                                width: lebar,
                                height: 85,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    width: 1.5,
                                    color:
                                        dt.status ? Colors.green : Colors.grey,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 100,
                                          height: 85,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(
                                                  10.0), // Ubah angka sesuai keinginan Anda
                                              bottomLeft: Radius.circular(
                                                  10.0), // Ubah angka sesuai keinginan Anda
                                            ),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(
                                                  10.0), // Atur sesuai keinginan Anda
                                              bottomLeft: Radius.circular(
                                                  10.0), // Atur sesuai keinginan Anda
                                            ),
                                            child: Image.network(dt.img,
                                                fit: BoxFit.cover,
                                                loadingBuilder:
                                                    (BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              } else {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    value: loadingProgress
                                                                .expectedTotalBytes !=
                                                            null
                                                        ? loadingProgress
                                                                .cumulativeBytesLoaded /
                                                            loadingProgress
                                                                .expectedTotalBytes!
                                                        : null,
                                                  ),
                                                );
                                              }
                                            }),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                                'ID: ${dt.id} || KAT: ${dt.kategori}',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 10)),
                                            SizedBox(height: 4),
                                            Text(
                                                'PRODUK: ${capitalize(dt.nama)}'),
                                            Text(
                                                'HARGA: ${formatRupiah(dt.harga.toDouble())}'),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            Get.toNamed(Routes.EDIT_PRODUK,
                                                arguments: dt);
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Get.defaultDialog(
                                              title: 'Apakah anda yakin?',
                                              middleText:
                                                  'Akan Menghapus Data ini?',
                                              confirm: ElevatedButton(
                                                  onPressed: () {
                                                    controller.delete(dt.id);
                                                    Get.back();
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              CustomColors
                                                                  .ijoTua),
                                                  child: Text(
                                                    'Ya!',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                              cancel: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              CustomColors
                                                                  .kremTua),
                                                  onPressed: () => Get.back(),
                                                  child: Text('Tidak!',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.white))),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      )),
              ],
            ),
          ),
        ));
  }
}
