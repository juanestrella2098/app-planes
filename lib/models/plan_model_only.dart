// To parse this JSON data, do
//
//     final planModelOnly = planModelOnlyFromMap(jsonString);

import 'dart:convert';

class PlanModelOnly {
  String id;
  String nombre;
  String foto;
  String desc;
  List<String> tipoPlan;
  String cAutonoma;
  String provincia;
  int rating;
  int costePlan;
  int contador;
  int cantSumada;
  DateTime createdAt;
  DateTime updatedAt;

  PlanModelOnly({
    required this.id,
    required this.nombre,
    required this.foto,
    required this.desc,
    required this.tipoPlan,
    required this.cAutonoma,
    required this.provincia,
    required this.rating,
    required this.costePlan,
    required this.contador,
    required this.cantSumada,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PlanModelOnly.fromJson(String str) =>
      PlanModelOnly.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlanModelOnly.fromMap(Map<String, dynamic> json) => PlanModelOnly(
        id: json["_id"],
        nombre: json["nombre"],
        foto: json["foto"],
        desc: json["desc"],
        tipoPlan: List<String>.from(json["tipoPlan"].map((x) => x)),
        cAutonoma: json["cAutonoma"],
        provincia: json["provincia"],
        rating: json["rating"],
        costePlan: json["costePlan"],
        contador: json["contador"],
        cantSumada: json["cantSumada"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "nombre": nombre,
        "foto": foto,
        "desc": desc,
        "tipoPlan": List<dynamic>.from(tipoPlan.map((x) => x)),
        "cAutonoma": cAutonoma,
        "provincia": provincia,
        "rating": rating,
        "costePlan": costePlan,
        "contador": contador,
        "cantSumada": cantSumada,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
