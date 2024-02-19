
import 'package:flutter/material.dart';
import 'package:tugas_crud_unsia/list_member.dart';
import 'package:tugas_crud_unsia/list_instruktur.dart';

/**
 * Nama: Rulando Rahadiyan Rendragraha
 * NIM: 220101020026
 * Kelas: SI702
 * Mata Kuliah: Pemrograman Berbasis Perangkat Bergerak
 */

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Homepage", style: TextStyle(color: Colors.white)),
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(25),
        crossAxisCount: 2,
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(8),
            child: InkWell(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ListMemberPage()));
              },
              splashColor: Colors.green,
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.account_box, size: 70, color: Colors.green,),
                    Text("Member", style: TextStyle(fontSize: 17.0),)
                  ],
                ),
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.all(8),
            child: InkWell(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ListInstrukturPage()));
              },
              splashColor: Colors.green,
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.fitness_center, size: 70, color: Colors.green,),
                    Text("Instruktur", style: TextStyle(fontSize: 17.0),)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
