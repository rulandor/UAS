
import 'package:flutter/material.dart';
import 'database/db_helper_member.dart';
import 'model/member.dart';

/**
 * Nama: Rulando Rahadiyan Rendragraha
 * NIM: 220101020026
 * Kelas: SI702
 * Mata Kuliah: Pemrograman Berbasis Perangkat Bergerak
 */

class FormMember extends StatefulWidget {
  final Member? member;

  FormMember({this.member});

  @override
  _FormMemberState createState() => _FormMemberState();
}

class _FormMemberState extends State<FormMember> {
  DbHelperMember db = DbHelperMember();

  TextEditingController? nama;
  TextEditingController? nohp;
  TextEditingController? alamat;
  TextEditingController? umur;

  @override
  void initState() {
    nama = TextEditingController(
        text: widget.member == null ? '' : widget.member!.nama);

    nohp = TextEditingController(
        text: widget.member == null ? '' : widget.member!.nohp);

    alamat = TextEditingController(
        text: widget.member == null ? '' : widget.member!.alamat);

    umur = TextEditingController(
        text: widget.member == null ? '' : widget.member!.umur);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Form Member', style: TextStyle(color: Colors.white)),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: nama,
              decoration: InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: nohp,
              decoration: InputDecoration(
                  labelText: 'Nohp',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: alamat,
              decoration: InputDecoration(
                  labelText: 'Alamat',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: umur,
              decoration: InputDecoration(
                  labelText: 'Umur',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 20
            ),
            child: ElevatedButton(
              child: (widget.member == null)
                  ? Text(
                'Add',
                style: TextStyle(color: Colors.green),
              )
                  : Text(
                'Update',
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () {
                upsertMember();
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> upsertMember() async {
    if (widget.member != null) {
      //update
      await db.updateMember(Member.fromMap({
        'id' : widget.member!.id,
        'nama' : nama!.text,
        'nohp' : nohp!.text,
        'alamat' : alamat!.text,
        'umur' : umur!.text
      }));
      Navigator.pop(context, 'update');
    } else {
      //insert
      await db.saveMember(Member(
        nama: nama!.text,
        nohp: nohp!.text,
        alamat: alamat!.text,
        umur: umur!.text,
      ));
      Navigator.pop(context, 'save');
    }
  }
}