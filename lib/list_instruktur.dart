import 'package:flutter/material.dart';
import 'form_instruktur.dart';
import 'database/db_helper_instruktur.dart';
import 'model/instruktur.dart';

/**
 * Nama: Rulando Rahadiyan Rendragraha
 * NIM: 220101020026
 * Kelas: SI702
 * Mata Kuliah: Pemrograman Berbasis Perangkat Bergerak
 */
class ListInstrukturPage extends StatefulWidget {
  const ListInstrukturPage({ Key? key }) : super(key: key);

  @override
  _ListInstrukturPageState createState() => _ListInstrukturPageState();
}

class _ListInstrukturPageState extends State<ListInstrukturPage> {
  List<Instruktur> listInstruktur = [];
  DbHelperInstruktur db = DbHelperInstruktur();

  @override
  void initState() {
    _getAllInstruktur();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Center(
          child: Text("List Instruktur", style: TextStyle(color: Colors.white)),
        ),
      ),
      body: ListView.builder(
          itemCount: listInstruktur.length,
          itemBuilder: (context, index) {
            Instruktur instruktur = listInstruktur[index];
            return Padding(
              padding: const EdgeInsets.only(
                  top: 10
              ),
              child: ListTile(
                title: Text(
                    '${instruktur.nama}'
                ),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Nohp: ${instruktur.nohp}"),
                    ),
                  ],
                ),
                trailing:
                FittedBox(
                  fit: BoxFit.fill,
                  child: Row(
                    children: [
                      // button edit
                      IconButton(
                          onPressed: () {
                            _openFormEdit(instruktur);
                          },
                          icon: Icon(Icons.edit)
                      ),
                      // button hapus
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: (){
                          AlertDialog hapus = AlertDialog(
                            title: Text("Information"),
                            content: Container(
                              height: 100,
                              child: Column(
                                children: [
                                  Text(
                                      "Yakin ingin Menghapus Data ${instruktur.nama}"
                                  )
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: (){
                                    _deleteInstruktur(instruktur, index);
                                    Navigator.pop(context);
                                  },
                                  child: Text("Ya")
                              ),
                              TextButton(
                                child: Text('Tidak'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                          showDialog(context: context, builder: (context) => hapus);
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
      //membuat button mengapung di bagian bawah kanan layar
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          _openFormCreate();
        },
      ),

    );
  }

  //mengambil semua data
  Future<void> _getAllInstruktur() async {
    var list = await db.getAllInstruktur();
    setState(() {
      listInstruktur.clear();
      list!.forEach((instruktur) {
        listInstruktur.add(Instruktur.fromMap(instruktur));
      });
    });
  }

  //hapus data
  Future<void> _deleteInstruktur(Instruktur instruktur, int position) async {
    await db.deleteInstruktur(instruktur.id!);
    setState(() {
      listInstruktur.removeAt(position);
    });
  }

  // halaman tambah
  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => FormInstruktur()));
    if (result == 'save') {
      await _getAllInstruktur();
    }
  }

  //halaman edit
  Future<void> _openFormEdit(Instruktur instruktur) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => FormInstruktur(instruktur: instruktur)));
    if (result == 'update') {
      await _getAllInstruktur();
    }
  }
}