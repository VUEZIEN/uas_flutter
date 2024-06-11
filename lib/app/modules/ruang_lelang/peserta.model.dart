// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

Peserta pesertaFromJson(String str, String id) => Peserta.fromJson(json.decode(str), id);

String pesertaToJson(Peserta data) => json.encode(data.toJson());

class Peserta {
    String id;
    String nama;
    String nik;
    String alamat;
    String id_peserta;
    String id_lelang;

    Peserta({
        required this.nama,
        required this.nik,
        required this.alamat,
        required this.id_peserta,
        required this.id_lelang,
        required this.id,
    });

    factory Peserta.fromJson(Map<String, dynamic> json, String id) => Peserta(
        id: json["id"],
        nama: json["nama"],
        nik: json["nik"],
        alamat: json["alamat"],
        id_peserta: json["id_peserta"],
        id_lelang: json["id_lelang"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "nik": nik,
        "alamat": alamat,
        "id_peserta": id_peserta,
        "id_lelang": id_lelang,
    };
}
