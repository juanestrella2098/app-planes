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
  PageController pageControllerFavs = PageController();

  int votacion = 0;
  int pos = 0;

  int getPosicion() {
    return pos;
  }

  void sumaPosicion(int num) {
    pos = num;
    notifyListeners();
  }

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
      //if (planesFavs.isEmpty) {
      //  pageControllerFavs.jumpToPage(0);
      //}
    } else {
      user.viajesFavoritos.add(id);
    }
    userService.putUsuario(user);
    notifyListeners();
  }

  bool estaEnFav(String id) {
    if (user.viajesFavoritos.contains(id)) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<PlanModel>> getPlanes() {
    return planService.getPlans();
  }

  Future<List<PlanModel>> getPlanesFavs() async {
    planesFavs = await getPlanes();

    planesFavs = planesFavs
        .where((plan) => user.viajesFavoritos.contains(plan.id))
        .toList();

    return planesFavs;
  }

  agregaPlanARealizado(String id) async {
    user.viajesRealizados
        .add(Viaje(idMongo: id, cantidadVotada: 0, votado: false));
    user.viajesFavoritos.removeWhere((idFav) => idFav == id);
    planesFavs.removeWhere((plan) => plan.id == id);
    user = await userService.putUsuario(user);
    planService.updatePlan(id);
    notifyListeners();
  }

  Future<List<PlanModel>> getPlanesRealizados() async {
    planesRealizados = await getPlanes();
    List<String?> idPlanes =
        user.viajesRealizados.map((viaje) => viaje.idMongo).toList();

    planesRealizados =
        planesRealizados.where((plan) => idPlanes.contains(plan.id)).toList();
    notifyListeners();
    return planesRealizados;
  }

  borraPlanFavs(String id) {
    planesFavs.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void actualizaRatingUserPlan(String id, int rate) {
    Viaje viajeEncontrado =
        user.viajesRealizados.firstWhere((element) => element.idMongo == id);
    bool? votado = user
        .viajesRealizados[user.viajesRealizados.indexOf(viajeEncontrado)]
        .votado;
    int cantVotadaAnterior = user
        .viajesRealizados[user.viajesRealizados.indexOf(viajeEncontrado)]
        .cantidadVotada;

    user.viajesRealizados[user.viajesRealizados.indexOf(viajeEncontrado)]
        .cantidadVotada = rate;

    if (votado == false) {
      user.viajesRealizados[user.viajesRealizados.indexOf(viajeEncontrado)]
          .votado = true;
    }

    planService.getPlanAndUpdateRating(id, rate, cantVotadaAnterior, votado!);

    actualizarUsuario(user.idFirebase, user.nombre, user.apellido, user.edad);
    notifyListeners();
  }

  reseteaProvider() async {
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
    await Future<void>.microtask(
      () {
        notifyListeners();
      },
    );
  }
}
