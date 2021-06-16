import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasetopicos/operation.dart';
import 'package:firebasetopicos/persona.dart';
import 'package:flutter/material.dart';

class SavePage extends StatelessWidget {
  static const String ROUTE = "/save";

  final _formKey = GlobalKey<FormState>();
  final nombreController = TextEditingController();
  final correoController = TextEditingController();
  final celularController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Persona persona = ModalRoute.of(context).settings.arguments;
    _init(persona);

    return Scaffold(
      appBar: AppBar(
        title: Text("Guardar"),
      ),
      body: Container(
        child: _buildForm(persona),
      ),
    );
  }

  _init(Persona persona) {
    nombreController.text = persona.nombre;
    correoController.text = persona.correo;
    celularController.text = persona.celular;
  }

  Widget _buildForm(Persona persona) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: nombreController,
              validator: (value) {
                if (value.isEmpty) {
                  return "Tiene que colocar data";
                }
                return null;
              },
              decoration: InputDecoration(
                  labelText: "Nombre",
                  border:
                      OutlineInputBorder() //borderRadius: BorderRadius.all(Radius.circular(50))
                  ),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: correoController,
              validator: (value) {
                if (value.isEmpty) {
                  return "Tiene que colocar data";
                }
                return null;
              },
              decoration: InputDecoration(
                  labelText: "Correo",
                  border:
                  OutlineInputBorder() //borderRadius: BorderRadius.all(Radius.circular(50))
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: celularController,
              validator: (value) {
                if (value.isEmpty) {
                  return "Tiene que colocar data";
                }
                return null;
              },
              decoration: InputDecoration(
                  labelText: "Celular",
                  border:
                      OutlineInputBorder() //borderRadius: BorderRadius.all(Radius.circular(50))
                  ),
            ),
            // ignore: deprecated_member_use
            RaisedButton(
              child: Text("Guardar"),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  /*if (persona.id > 0) {
                    // actualizacion
                    persona.nombre = nombreController.text;
                    persona.correo = correoController.text;
                    persona.celular = celularController.text;
                    Operation.update(persona);
                  } else {*/
                    // insercion
                  //busqueda si no existe el correo
                  FirebaseFirestore.instance
                      .collection('personas')
                      .where('correo', isEqualTo: correoController.text)
                      .get()
                      .then((documentSnapshot) {
                           if (documentSnapshot.size>0) {
                          print('-----------------------');
                          print('El Correo ya fue registrado');
                          //_showDialog(context);
                        } else {
                //insercion
                        FirebaseFirestore.instance.collection("personas").add({
                          'nombre': nombreController.text,
                          'correo': correoController.text,
                          'celular': celularController.text
                        }
                       );
                //

                      }
                  });
                   /* Operation.insert(Persona(
                        id: 1,
                        nombre: nombreController.text,
                        correo : correoController.text,
                        celular : celularController.text));*/
                 // }
                }
              },
            )
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Alert!!"),
          content: new Text("Persona no agregada existe correo !"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
