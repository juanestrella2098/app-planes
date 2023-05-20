import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:plan_app/models/plan_model.dart';

class PlanService {
  final url = 'http://192.168.0.108:3000/api/plans';

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
}
