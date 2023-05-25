import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:plan_app/models/plan_model.dart';
import 'package:plan_app/models/plan_model_only.dart';

import '../models/user_model.dart';

class PlanService {
  final url = 'http://192.168.1.101:3000/api/plans';

  Future<List<PlanModel>> getPlans() async {
    final uri = Uri.parse("$url");
    final response = await http.get(uri);
    List<PlanModel> planes = [];
    List<dynamic> datos = jsonDecode(response.body);

    for (var dato in datos) {
      if (dato is Map<String, dynamic>) {
        PlanModel planModel = PlanModel.fromJson(dato);
        planes.add(planModel);
      }
    }

    return planes;
  }

  void getPlanUpdateItAndPlusOne(String id) async {
    final uri = Uri.parse("$url/$id");
    final response = await http.get(uri);
    PlanModelOnly planModel = PlanModelOnly.fromJson(response.body);
    planModel.contador++;
    await http.put(uri,
        body: planModel.toJson(),
        headers: {"Content-Type": "application/json"});
  }

  void getPlanAndUpdateRating(String id, int rate) async {
    final uri = Uri.parse("$url/$id");
    final response = await http.get(uri);
    PlanModelOnly planModelOnly = PlanModelOnly.fromJson(response.body);
    planModelOnly.rating = rate ~/ planModelOnly.contador;
    await http.put(uri,
        body: planModelOnly.toJson(),
        headers: {"Content-Type": "application/json"});
  }
}
