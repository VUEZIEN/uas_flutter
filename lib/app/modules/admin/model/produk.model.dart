import 'dart:convert';

Produk produkFromJson(String str, String id) =>
    Produk.fromJson(json.decode(str), id);

String produkToJson(Produk data) => json.encode(data.toJson());

class Produk {
  int harga;
  String img;
  String kategori;
  String nama;
  bool status;

  Produk({
    required this.harga,
    required this.img,
    required this.kategori,
    required this.nama,
    required this.status,
  });

  factory Produk.fromJson(Map<String, dynamic> json, String id) => Produk(
        harga: json["harga"],
        img: json["img"],
        kategori: json["kategori"],
        nama: json["nama"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "harga": harga,
        "img": img,
        "kategori": kategori,
        "nama": nama,
        "status": status,
      };
}
