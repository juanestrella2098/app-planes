import 'package:flutter/cupertino.dart';
import 'package:plan_app/models/user_model.dart';
import 'package:plan_app/services/plan_services.dart';
import 'package:plan_app/services/user_service.dart';

import '../models/plan_model.dart';

class UserProvider extends ChangeNotifier {
  PlanService planService = PlanService();
  UserService userService = UserService();
  List<PlanModel> planesFavs = [];
  List<PlanModel> planesRealizados = [];
  int votacion = 0;
  PlanModel plan = PlanModel(
      id: '',
      nombre: '',
      foto: '',
      desc: '',
      tipoPlan: [],
      cAutonoma: '',
      provincia: '',
      rating: 0,
      costePlan: 0,
      createdAt: '',
      updatedAt: '',
      contador: 0);
  bool registrado = false;

  UserModel user = UserModel(
      id: '',
      idFirebase: '',
      nombre: '',
      apellido: '',
      edad: 0,
      viajesFavoritos: [],
      viajesRealizados: []);

  actualizaRating(int _) {
    votacion = _;
    notifyListeners();
  }

  Future<bool> usuarioRegistrado(String idFirebase) async {
    UserModel usuario = await userService.getUsuario(idFirebase);
    if (usuario.idFirebase.isEmpty) {
      registrado = false;
      return false;
    } else {
      user = usuario;
      registrado = true;
      return true;
    }
  }

  void registrarUsuario(String id, String nombre, String apellido, int edad) {
    user = UserModel(
        idFirebase: id,
        nombre: nombre,
        apellido: apellido,
        edad: edad,
        viajesFavoritos: [],
        viajesRealizados: []);
    userService.postUsuario(user);
  }

  void actualizarUsuario(String id, String nombre, String apellido, int edad) {
    user = UserModel(
        idFirebase: id,
        nombre: nombre,
        apellido: apellido,
        edad: edad,
        viajesFavoritos: user.viajesFavoritos,
        viajesRealizados: user.viajesRealizados);
    userService.putUsuario(user);
  }

  void eliminaUsuario(String id) {
    userService.eliminaUsuario(user.idFirebase);
  }

  Future<void> agregaViajeFav(String id) async {
    if (user.viajesFavoritos.contains(id)) {
      user.viajesFavoritos.removeWhere((element) => element == id);
      planesFavs.removeWhere((plan) => plan.id == id);
    } else {
      user.viajesFavoritos.add(id);
    }
    userService.putUsuario(user);
    print(user.viajesFavoritos);
    notifyListeners();
  }

  bool estaEnFav(String id) {
    return user.viajesFavoritos.contains(id);
  }

  Future<List<PlanModel>> getPlanes() {
    return planService.getPlans();
  }

  Future<List<PlanModel>> getPlanesFavs() async {
    planesFavs = await getPlanes();

    planesFavs = planesFavs
        .where((plan) => user.viajesFavoritos.contains(plan.id))
        .toList();
    notifyListeners();
    return planesFavs;
  }

  agregaPlanARealizado(String id) {
    user.viajesRealizados.add(id);
    user.viajesFavoritos.removeWhere((idFav) => idFav == id);
    planesFavs.removeWhere((plan) => plan.id == id);
    userService.putUsuario(user);
    planService.getPlanUpdateItAndPlusOne(id);
    notifyListeners();
  }

  Future<List<PlanModel>> getPlanesRealizados() async {
    planesRealizados = await getPlanes();
    planesRealizados = planesRealizados
        .where((plan) => user.viajesRealizados.contains(plan.id))
        .toList();
    notifyListeners();
    return planesRealizados;
  }

  borraPlanFavs(String id) {
    planesFavs.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  actualizaRatingUserPlan(String id, int rate) {
    planService.getPlanAndUpdateRating(id, rate);
    notifyListeners();
  }

  void reseteaProvider() {
    user = UserModel(
        idFirebase: '',
        nombre: '',
        apellido: '',
        edad: 0,
        viajesFavoritos: [],
        viajesRealizados: []);
    votacion = 0;
    registrado = false;
    planesFavs = [];
    planesRealizados = [];
    notifyListeners();
  }
}
