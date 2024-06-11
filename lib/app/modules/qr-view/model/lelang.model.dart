import 'dart:convert';

Lelang lelangFromJson(String str, String id) =>
    Lelang.fromJson(json.decode(str), id);

String lelangToJson(Lelang data) => json.encode(data.toJson());

class Lelang {
  String id;
  dynamic idPemenang;
  String idProduk;
  String keterangan;

  Lelang({
    required this.idPemenang,
    required this.idProduk,
    required this.id,
    required this.keterangan,
  });

  factory Lelang.fromJson(Map<String, dynamic> json, String id) => Lelang(
        id: id,
        idPemenang: json["id_pemenang"],
        idProduk: json["id_produk"],
        keterangan: json["keterangan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_pemenang": idPemenang,
        "id_produk": idProduk,
        "keterangan": keterangan,
      };
}
