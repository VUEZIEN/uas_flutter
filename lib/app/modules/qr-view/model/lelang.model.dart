// To parse this JSON data, do
//
//     final lelang = lelangFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Lelang lelangFromJson(String str, String id) => Lelang.fromJson(json.decode(str), id);

String lelangToJson(Lelang data) => json.encode(data.toJson());

class Lelang {
    String id;
    Timestamp end;
    Timestamp start;
    dynamic idPemenang;
    String idProduk;

    Lelang({
        required this.end,
        required this.start,
        required this.idPemenang,
        required this.idProduk,
      required this.id,
    });

    factory Lelang.fromJson(Map<String, dynamic> json, String id) => Lelang(
        id: id,
        end: json["end"],
        start: json["start"],
        idPemenang: json["id_pemenang"],
        idProduk: json["id_produk"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "end": end,
        "start": start,
        "id_pemenang": idPemenang,
        "id_produk": idProduk,
    };
}
