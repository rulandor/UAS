
import 'package:flutter/material.dart';
import 'database/db_helper_instruktur.dart';
import 'model/instruktur.dart';

/**
 * Nama: Rulando Rahadiyan Rendragraha
 * NIM: 220101020026
 * Kelas: SI702
 * Mata Kuliah: Pemrograman Berbasis Perangkat Bergerak
 */

class FormInstruktur extends StatefulWidget {
  final Instruktur? instruktur;

  FormInstruktur({this.instruktur});

  @override
  _FormInstrukturState createState() => _FormInstrukturState();
}

class _FormInstrukturState extends State<FormInstruktur> {
  DbHelperInstruktur db = DbHelperInstruktur();

  TextEditingController? nama;
  TextEditingController? nohp;

  @override
  void initState() {
    nama = TextEditingController(
        text: widget.instruktur == null ? '' : widget.instruktur!.nama);

    nohp = TextEditingController(
        text: widget.instruktur == null ? '' : widget.instruktur!.nohp);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Form Instruktur', style: TextStyle(color: Colors.white)),
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
                top: 20
            ),
            child: ElevatedButton(
              child: (widget.instruktur == null)
                  ? Text(
                'Add',
                style: TextStyle(color: Colors.green),
              )
                  : Text(
                'Update',
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () {
                upsertInstruktur();
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> upsertInstruktur() async {
    if (widget.instruktur != null) {
      //update
      await db.updateInstruktur(Instruktur.fromMap({
        'id' : widget.instruktur!.id,
        'nama' : nama!.text,
        'nohp' : nohp!.text,
      }));
      Navigator.pop(context, 'update');
    } else {
      //insert
      await db.saveInstruktur(Instruktur(
        nama: nama!.text,
        nohp: nohp!.text,
      ));
      Navigator.pop(context, 'save');
    }
  }
}