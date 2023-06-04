import 'dart:convert';

class Viaje {
  final String idMongo;
  int cantidadVotada;
  final String? id;
  bool? votado;

  Viaje(
      {this.votado,
      required this.idMongo,
      required this.cantidadVotada,
      this.id});

  Map<String, dynamic> toMap() => {
        'id': idMongo,
        'cantVotada': cantidadVotada,
        '_id': id,
        'votado': votado
      };

  factory Viaje.fromMap(Map<String, dynamic> map) => Viaje(
        idMongo: map['id'],
        cantidadVotada: map['cantVotada'],
        id: map['_id'],
        votado: map['votado'],
      );

  String toJson() => json.encode(toMap());

  factory Viaje.fromJson(String source) => Viaje.fromMap(json.decode(source));
}

class UserModel {
  final String? id;
  final String idFirebase;
  final String nombre;
  final String apellido;
  final int edad;
  final List<String> viajesFavoritos;
  final List<Viaje> viajesRealizados;

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
        viajesRealizados: List<Viaje>.from(
            json["viajesRealizados"].map((x) => Viaje.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "idFirebase": idFirebase,
        "nombre": nombre,
        "apellido": apellido,
        "edad": edad,
        "viajesFavoritos": List<dynamic>.from(viajesFavoritos.map((x) => x)),
        "viajesRealizados":
            List<dynamic>.from(viajesRealizados.map((x) => x.toMap())),
      };
}
