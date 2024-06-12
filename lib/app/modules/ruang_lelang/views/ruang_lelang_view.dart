import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uas_flutter/app/modules/admin/views/admin_view.dart';
import 'package:uas_flutter/color/color.dart';
import '../controllers/ruang_lelang_controller.dart';

class RuangLelangView extends GetView<RuangLelangController> {
  final RuangLelangController co = Get.put(RuangLelangController());
  final data = Get.arguments as Map;

  @override
  Widget build(BuildContext context) {
    print(data['id_lelang']);
    co.setIdLelang(data["id_lelang"]);
    final produk = data['produk'];
    print(produk);

    return Scaffold(
      appBar: AppBar(
        title: Text('Ruang Lelang', style: TextStyle(color: Colors.white)),
        backgroundColor: CustomColors.ijoMuda,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Obx(() => !controller.loading.value
              ? controller.isIkut.value
                  ? Column(
                      children: [
                        Obx(() => controller.status.value
                            ? data['is'] == 'BERLANGSUNG'
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 8),
                                        width: MediaQuery.of(context).size.width,
                                        height: 300,
                                        child: Image.network(
                                          produk['img'],
                                          errorBuilder: (BuildContext context,
                                              Object error,
                                              StackTrace? stackTrace) {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          },
                                        ),
                                      ),
                                      Text('NAMA PRODUK: ${produk['nama']}'),
                                      Text('KATEGORI: ${produk['kategori']}'),
                                      Text(
                                          'START HARGA: ${formatRupiah(produk['harga'])}'),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 350,
                                        child: StreamBuilder<QuerySnapshot>(
                                          stream: controller
                                              .detailLelangStream(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            }

                                            if (snapshot.hasError) {
                                              return Center(
                                                  child: Text(
                                                      'Something went wrong'));
                                            }

                                            if (snapshot.hasData) {
                                              var detailList = snapshot
                                                  .data!.docs
                                                  .map((doc) =>
                                                      doc.data() as Map)
                                                  .toList();

                                              detailList.sort((a, b) =>
                                                  b['bid'].compareTo(a['bid']));

                                              return DataTable(
                                                  columns: [
                                                    DataColumn(
                                                        label: Text('Nama')),
                                                    DataColumn(
                                                        label: Text('Penawaran')),
                                                  ],
                                                  rows: List.generate(
                                                      detailList.length, (i) {
                                                    final dt = detailList[i];
                                                    return DataRow(cells: [
                                                      DataCell(
                                                        FutureBuilder<
                                                            DocumentSnapshot>(
                                                          future: co.fs
                                                              .collection(
                                                                  'peserta')
                                                              .doc(dt['id_peserta'])
                                                              .get(),
                                                          builder: (context,
                                                              snapshot) {
                                                            if (snapshot
                                                                    .connectionState ==
                                                                ConnectionState
                                                                    .waiting) {
                                                              return Text(
                                                                  'Loading...');
                                                            }
                                                            if (snapshot
                                                                .hasError) {
                                                              return Text(
                                                                  'Error');
                                                            }
                                                            if (!snapshot
                                                                .hasData) {
                                                              return Text(
                                                                  'No Data');
                                                            }

                                                            final pesertaData =
                                                                snapshot
                                                                        .data!
                                                                        .data()
                                                                    as Map<
                                                                        String,
                                                                        dynamic>;
                                                            return Text(
                                                                '${pesertaData["nama"]} ${dt["id_peserta"] == controller.idUser ? '(Anda)' : ''}');
                                                          },
                                                        ),
                                                      ),
                                                      DataCell(Text(
                                                          '${formatRupiah(dt["bid"])}')),
                                                    ]);
                                                  }));
                                            }

                                            return Center(
                                                child: Text(
                                                    'No bid data available'));
                                          },
                                        ),
                                      ),
                                      TextField(
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        controller: co.harga,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'BID',
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Obx(
                                        () => ElevatedButton(
                                          onPressed: () {
                                            if (!controller.loading.value) {
                                              controller.bid(produk['harga']);
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                              minimumSize:
                                                  Size(double.infinity, 50),
                                              backgroundColor:
                                                  CustomColors.ijoTua,
                                              elevation: 0),
                                          child: Text(
                                            controller.loading.value
                                                ? 'Loading...'
                                                : 'BID',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: CustomColors.kremMuda),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                    ],
                                  )
                                : Container(
                                    margin: EdgeInsets.only(top: 24),
                                    width: 500,
                                    height: 500,
                                    color: Colors.grey,
                                    child: Center(
                                        child: Text('BELUM BERLANGSUNG',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600))),
                                  )
                            : CircularProgressIndicator())
                      ],
                    )
                  : Column(
                      children: [
                        SizedBox(height: 24),
                        Text('Data Diri', style: TextStyle(fontSize: 34)),
                        SizedBox(height: 18),
                        TextField(
                          controller: controller.nama,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Nama',
                          ),
                        ),
                        SizedBox(height: 16),
                        TextField(
                          controller: controller.nik,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'NIK',
                          ),
                        ),
                        SizedBox(height: 16),
                        TextField(
                          controller: controller.alamat,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Alamat',
                          ),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            controller.savePeserta();
                          },
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.infinity, 50),
                              backgroundColor: CustomColors.ijoTua,
                              elevation: 0),
                          child: Text(
                            'Submit',
                            style: TextStyle(
                                fontSize: 18, color: CustomColors.kremMuda),
                          ),
                        )
                      ],
                    )
              : CircularProgressIndicator()),
        ),
      ),
    );
  }
}
