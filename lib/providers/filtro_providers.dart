import 'package:flutter/cupertino.dart';
import 'package:plan_app/models/user_model.dart';
import 'package:plan_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../models/plan_model.dart';
import '../services/plan_services.dart';

class FiltroProviders extends ChangeNotifier {
  PlanService planService = PlanService();
  List<PlanModel> planes = [];
  List<PlanModel> planesAux = [];
  PageController pageControllerFilter = PageController(keepPage: false);

  String comunidadSeleccionada = '-';
  String provinciaSeleccionada = '-';
  bool flagTipo1 = false,
      flagTipo2 = false,
      flagTipo3 = false,
      flagTipo4 = false;
  List<String> tipoPlan = [];
  double valorCoste = 0, numCoches = 0;

  void actualizaComunidadSeleccionada(_) {
    comunidadSeleccionada = _;
    notifyListeners();
  }

  void actualizaProvinciaSeleccinada(_) {
    provinciaSeleccionada = _;
    notifyListeners();
  }

  void booleanTipo1(_) {
    flagTipo1 = _;
    notifyListeners();
  }

  void booleanTipo2(_) {
    flagTipo2 = _;
    notifyListeners();
  }

  void booleanTipo3(_) {
    flagTipo3 = _;
    notifyListeners();
  }

  void booleanTipo4(_) {
    flagTipo4 = _;
    notifyListeners();
  }

  void actualizaTipoPlan(_) {
    (tipoPlan.contains(_))
        ? tipoPlan.removeWhere((tipo) => tipo == _)
        : tipoPlan.add(_);
    notifyListeners();
  }

  void actualizaValorCoste(_) {
    valorCoste = _;
    print(valorCoste);
    notifyListeners();
  }

  void actualizaNumCoches(_) {
    numCoches = _;
    notifyListeners();
  }

  void reseteProvider() {
    comunidadSeleccionada = '-';
    provinciaSeleccionada = '-';
    flagTipo1 = false;
    flagTipo2 = false;
    flagTipo3 = false;
    flagTipo4 = false;
    tipoPlan = [];
    valorCoste = 0;
    numCoches = 0;
    notifyListeners();
  }

  void reseteaArrPlanes() {
    planes = [];
    planesAux = [];
    notifyListeners();
  }

  Future<List<PlanModel>> getPlanes() {
    return planService.getPlans();
  }

  Future<List<PlanModel>> traePlanes(BuildContext context) async {
    final List<Viaje> viajesRealizados =
        Provider.of<UserProvider>(context, listen: false).user.viajesRealizados;
    if (planes.isEmpty) {
      planes = await getPlanes();
      planesAux = [...planes];
    } else {
      planesAux = [...planes];
    }

    //quitar los resultados de los viajes que se hayan realizado
    for (var viaje in viajesRealizados) {
      planesAux.removeWhere((planAux) => planAux.id == viaje.idMongo);
    }

    if (comunidadSeleccionada != '-') {
      planesAux = planesAux
          .where((element) => element.cAutonoma == comunidadSeleccionada)
          .toList();
    }

    if (provinciaSeleccionada != '-') {
      planesAux = planesAux
          .where((element) => element.provincia == provinciaSeleccionada)
          .toList();
    }

    if (tipoPlan.isNotEmpty) {
      planesAux = planesAux
          .where((element) =>
              element.tipoPlan.any((tipo) => tipoPlan.contains(tipo)))
          .toList();
    }

    if (valorCoste > 0) {
      planesAux = planesAux
          .where((element) => element.costePlan <= valorCoste)
          .toList();
    }

    if (numCoches > 0) {
      planesAux =
          planesAux.where((element) => element.rating >= numCoches).toList();
    }
    notifyListeners();
    return planesAux;
  }

  borraPlanes(String id) {
    planesAux.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
