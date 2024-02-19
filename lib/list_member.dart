import 'package:flutter/material.dart';
import 'form_member.dart';
import 'database/db_helper_member.dart';
import 'model/member.dart';

/**
 * Nama: Rulando Rahadiyan Rendragraha
 * NIM: 220101020026
 * Kelas: SI702
 * Mata Kuliah: Pemrograman Berbasis Perangkat Bergerak
 */

class ListMemberPage extends StatefulWidget {
  const ListMemberPage({ Key? key }) : super(key: key);

  @override
  _ListMemberPageState createState() => _ListMemberPageState();
}

class _ListMemberPageState extends State<ListMemberPage> {
  List<Member> listMember = [];
  DbHelperMember db = DbHelperMember();

  @override
  void initState() {
    _getAllMember();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.green,

        title: Center(
          child: Text("List Member", style: TextStyle(color: Colors.white)),
        ),
      ),
      body: ListView.builder(
          itemCount: listMember.length,
          itemBuilder: (context, index) {
            Member member = listMember[index];
            return Padding(
              padding: const EdgeInsets.only(
                  top: 10
              ),
              child: ListTile(
                title: Text(
                    '${member.nama}'
                ),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Nohp: ${member.nohp}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Alamat: ${member.alamat}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Umur: ${member.umur}"),
                    )
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
                            _openFormEdit(member);
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
                                      "Yakin ingin Menghapus Data ${member.nama}"
                                  )
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: (){
                                    _deleteMember(member, index);
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
  Future<void> _getAllMember() async {
    var list = await db.getAllMember();
    setState(() {
      listMember.clear();
      list!.forEach((member) {
        listMember.add(Member.fromMap(member));
      });
    });
  }

  //hapus data
  Future<void> _deleteMember(Member member, int position) async {
    await db.deleteMember(member.id!);
    setState(() {
      listMember.removeAt(position);
    });
  }

  // halaman tambah
  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => FormMember()));
    if (result == 'save') {
      await _getAllMember();
    }
  }

  //halaman edit
  Future<void> _openFormEdit(Member member) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => FormMember(member: member)));
    if (result == 'update') {
      await _getAllMember();
    }
  }
}