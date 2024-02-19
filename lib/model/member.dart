/**
 * Nama: Rulando Rahadiyan Rendragraha
 * NIM: 220101020026
 * Kelas: SI702
 * Mata Kuliah: Pemrograman Berbasis Perangkat Bergerak
 */

class Member{
  int? id;
  String? nama;
  String? nohp;
  String? alamat;
  String? umur;

  Member({this.id, this.nama, this.nohp, this.alamat, this.umur});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = id;
    }
    map['nama'] = nama;
    map['nohp'] = nohp;
    map['alamat'] = alamat;
    map['umur'] = umur;

    return map;
  }

  Member.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.nama = map['nama'];
    this.nohp = map['nohp'];
    this.alamat = map['alamat'];
    this.umur = map['umur'];
  }
}