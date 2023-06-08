import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:plan_app/models/plan_model.dart';
import 'package:plan_app/models/plan_model_only.dart';

class PlanService {
  final url = 'http://46.183.118.239:3000/api/plans';
// deploy 46.183.118.239 dev:192.168.0.103
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
    await http.put(uri,
        body: planModel.toJson(),
        headers: {"Content-Type": "application/json"});
  }

  void getPlanAndUpdateRating(
      String id, int rate, int cantVotadaAnterior, bool votado) async {
    final uri = Uri.parse("$url/$id");
    final response = await http.get(uri);
    PlanModelOnly planModelOnly = PlanModelOnly.fromJson(response.body);
    if (votado == false) {
      planModelOnly.contador++;
    }
    planModelOnly.cantSumada =
        ((planModelOnly.cantSumada - cantVotadaAnterior) + rate);
    planModelOnly.rating = planModelOnly.cantSumada ~/ planModelOnly.contador;

    await http.put(uri,
        body: planModelOnly.toJson(),
        headers: {"Content-Type": "application/json"});
  }
}
