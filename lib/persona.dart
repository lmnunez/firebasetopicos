class Persona {
  int id;
  String nombre;
  String correo;
  String celular;

  Persona({this.id, this.nombre, this.correo, this.celular});

  Persona.empty();

  Map<String, dynamic> toMap() {
    return {'id': id, 'nombre': nombre, 'correo': correo, 'celular': celular};
  }
}