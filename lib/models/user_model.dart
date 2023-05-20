import 'dart:convert';

class UserModel {
  final String? id;
  final String idFirebase;
  final String nombre;
  final String apellido;
  final int edad;
  final List<String> viajesFavoritos;
  final List<String> viajesRealizados;

  UserModel({
    this.id,
    required this.idFirebase,
    required this.nombre,
    required this.apellido,
    required this.edad,
    required this.viajesFavoritos,
    required this.viajesRealizados,
  });

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        idFirebase: json["idFirebase"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        edad: json["edad"],
        viajesFavoritos:
            List<String>.from(json["viajesFavoritos"].map((x) => x)),
        viajesRealizados:
            List<String>.from(json["viajesRealizados"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "idFirebase": idFirebase,
        "nombre": nombre,
        "apellido": apellido,
        "edad": edad,
        "viajesFavoritos": List<dynamic>.from(viajesFavoritos.map((x) => x)),
        "viajesRealizados": List<dynamic>.from(viajesRealizados.map((x) => x)),
      };
}
