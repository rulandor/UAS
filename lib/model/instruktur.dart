/**
 * Nama: Rulando Rahadiyan Rendragraha
 * NIM: 220101020026
 * Kelas: SI702
 * Mata Kuliah: Pemrograman Berbasis Perangkat Bergerak
 */

class Instruktur{
  int? id;
  String? nama;
  String? nohp;

  Instruktur({this.id, this.nama, this.nohp});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = id;
    }
    map['nama'] = nama;
    map['nohp'] = nohp;

    return map;
  }

  Instruktur.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.nama = map['nama'];
    this.nohp = map['nohp'];
  }
}