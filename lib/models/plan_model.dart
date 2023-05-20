import 'dart:convert';

class PlanModel {
  final String id;
  final String nombre;
  final String foto;
  final String desc;
  final List<String> tipoPlan;
  final String cAutonoma;
  final String provincia;
  final int rating;
  final int costePlan;
  final String createdAt;
  final String updatedAt;

  PlanModel({
    required this.id,
    required this.nombre,
    required this.foto,
    required this.desc,
    required this.tipoPlan,
    required this.cAutonoma,
    required this.provincia,
    required this.rating,
    required this.costePlan,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PlanModel.fromJson(Map<String, dynamic> json) {
    return PlanModel(
      id: json['_id'] ?? '',
      nombre: json['nombre'] ?? '',
      foto: json['foto'] ?? '',
      desc: json['desc'] ?? '',
      tipoPlan: List<String>.from(json['tipoPlan'] ?? []),
      cAutonoma: json['cAutonoma'] ?? '',
      provincia: json['provincia'] ?? '',
      rating: json['rating'] ?? 0,
      costePlan: json['costePlan'] ?? 0,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}
