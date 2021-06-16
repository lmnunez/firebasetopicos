import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasetopicos/operation.dart';
import 'package:firebasetopicos/persona.dart';
import 'package:firebasetopicos/save_page.dart';
import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {
  static const String ROUTE = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, SavePage.ROUTE,arguments: Persona.empty());
        },
      ),
      appBar: AppBar(
        title: Text("Listado"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("personas").snapshots(),
        builder: (context, snapshots){
          if(!snapshots.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );

          }
          List<DocumentSnapshot> docs= snapshots.data.docs;
          return Container(child: ListView.builder(
              itemCount: docs.length,
              itemBuilder: (_,i){
                Map<String, dynamic> data = docs[i].data();
                print("_________________");
                print(data);
                return ListTile(title: Text(data['nombre']+' -*- '+data['correo']+' -*- '+data['celular']),);
              }),
          );
         },
      )

        /*
        Container(
        child: _MyList(),
      ),
         */
    );
  }
}

class _MyList extends StatefulWidget {
  @override
  __MyListState createState() => __MyListState();
}

class __MyListState extends State<_MyList> {
  List<Persona> personas = [];

  @override
  void initState() {
    _loadData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: personas.length,
      itemBuilder: (_, i) => _createItem(i),
    );
  }

  _loadData() async {
    List<Persona> auxPersona = await Operation.personas();

    setState(() {
      personas = auxPersona;
    });
  }

  _createItem(int i) {
    return Dismissible(
      key: Key(i.toString()),
      direction: DismissDirection.startToEnd,
      background: Container(
        color: Colors.red,
        padding: EdgeInsets.only(left: 5),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Icon(Icons.delete, color: Colors.white),
        ),
      ),
      onDismissed: (direction) {
        print(direction);
        Operation.delete(personas[i]);
      },
      child: ListTile(
        title: Text(personas[i].nombre),
        trailing: MaterialButton(
          onPressed: (){
            Navigator.pushNamed(context, SavePage.ROUTE,arguments: personas[i]);
          },
          child: Icon(Icons.edit)),
      ),
    );
  }
}
