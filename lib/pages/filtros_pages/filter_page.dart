import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plan_app/pages/filtros_pages/plans_searched.dart';
import 'package:plan_app/providers/filtro_providers.dart';
import 'package:plan_app/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../providers/user_provider.dart';
import '../logged_pages/user_pages/createUser.dart';

class FilterPage extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;
  List<String> comunidades = comunidadesAutonomas.keys.toList();
  String comunidadSeleccionada = '-';
  String provinciaSeleccionada = '-';
  String tipo1 = 'uno';
  String tipo2 = 'dos';
  String tipo3 = 'tres';
  String tipo4 = 'cuatro';
  @override
  Widget build(BuildContext context) {
    final filtroProvider = Provider.of<FiltroProviders>(context);
    final userProvider = Provider.of<UserProvider>(context);

    return SingleChildScrollView(child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth > 600) {
        return pantallaOrdenador(
            comunidades: comunidades,
            filtroProvider: filtroProvider,
            tipo1: tipo1,
            tipo2: tipo2,
            tipo3: tipo3,
            tipo4: tipo4,
            userProvider: userProvider,
            user: user);
      } else {
        return pantallaMovil(
            comunidades: comunidades,
            filtroProvider: filtroProvider,
            tipo1: tipo1,
            tipo2: tipo2,
            tipo3: tipo3,
            tipo4: tipo4,
            userProvider: userProvider,
            user: user);
      }
    }));
  }
}

class pantallaMovil extends StatelessWidget {
  const pantallaMovil({
    Key? key,
    required this.comunidades,
    required this.filtroProvider,
    required this.tipo1,
    required this.tipo2,
    required this.tipo3,
    required this.tipo4,
    required this.userProvider,
    required this.user,
  }) : super(key: key);

  final List<String> comunidades;
  final FiltroProviders filtroProvider;
  final String tipo1;
  final String tipo2;
  final String tipo3;
  final String tipo4;
  final UserProvider userProvider;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 40,
        ),
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          width: MediaQuery.of(context).size.width,
          height: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.grey[300],
          ),
          child: Stack(alignment: AlignmentDirectional.topCenter, children: [
            Container(
              width: MediaQuery.of(context).size.width / 2,
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    print('juas');
                  },
                  child: Text(
                    'Comunidad y Provincia',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 65,
              child: Column(
                children: [
                  Text(
                    'Comunidad',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      hint: const Text('Comunidad'),
                      items: comunidades
                          .map((comunidad) => DropdownMenuItem<String>(
                                value: comunidad,
                                child: Text(
                                  comunidad,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                          .toList(),
                      value: filtroProvider.comunidadSeleccionada,
                      onChanged: (value) {
                        filtroProvider.actualizaComunidadSeleccionada(value);
                        filtroProvider.actualizaProvinciaSeleccinada("-");
                      },
                      buttonStyleData: ButtonStyleData(
                        height: 50,
                        width: 175,
                        padding: const EdgeInsets.only(
                          left: 14,
                          right: 14,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.black26,
                          ),
                          color: Colors.grey[700],
                        ),
                        elevation: 2,
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_forward_ios_outlined,
                        ),
                        iconSize: 14,
                        iconEnabledColor: Colors.white,
                        iconDisabledColor: Colors.grey,
                      ),
                      dropdownStyleData: DropdownStyleData(
                          openInterval: const Interval(0.5, 1),
                          maxHeight: 200,
                          width: 225,
                          padding: EdgeInsets.all(25),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.grey[700],
                          ),
                          elevation: 15,
                          offset: const Offset(-20, 0),
                          scrollbarTheme: ScrollbarThemeData(
                            radius: const Radius.circular(40),
                            thickness: MaterialStateProperty.all(6),
                            thumbVisibility: MaterialStateProperty.all(true),
                          )),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                        padding: EdgeInsets.only(left: 14, right: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 155,
              child: Column(
                children: [
                  Text(
                    'Provincia',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      hint: const Text('Provincia'),
                      items: comunidadesAutonomas[
                              filtroProvider.comunidadSeleccionada]
                          ?.map((provincia) => DropdownMenuItem<String>(
                                value: provincia,
                                child: Text(
                                  provincia,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                          .toList(),
                      value: filtroProvider.provinciaSeleccionada,
                      onChanged: (value) {
                        filtroProvider.actualizaProvinciaSeleccinada(value);
                      },
                      buttonStyleData: ButtonStyleData(
                        height: 50,
                        width: 175,
                        padding: const EdgeInsets.only(
                          left: 14,
                          right: 14,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.black26,
                          ),
                          color: Colors.grey[700],
                        ),
                        elevation: 2,
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_forward_ios_outlined,
                        ),
                        iconSize: 14,
                        iconEnabledColor: Colors.white,
                        iconDisabledColor: Colors.grey,
                      ),
                      dropdownStyleData: DropdownStyleData(
                          openInterval: const Interval(0.5, 1),
                          maxHeight: 200,
                          width: 225,
                          padding: EdgeInsets.all(25),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.grey[700],
                          ),
                          elevation: 15,
                          offset: const Offset(-20, 0),
                          scrollbarTheme: ScrollbarThemeData(
                            radius: const Radius.circular(40),
                            thickness: MaterialStateProperty.all(6),
                            thumbVisibility: MaterialStateProperty.all(true),
                          )),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                        padding: EdgeInsets.only(left: 14, right: 14),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
        SizedBox(
          height: 25,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2.25,
              height: 325,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20)),
              child: Stack(children: [
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.grey[700],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: Center(
                      child: Text(
                    'Tipo de plan',
                    style: TextStyle(color: Colors.white),
                  )),
                ),
                Positioned(
                    child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      ChoiceChip(
                        label: Container(
                          width: 80,
                          child: Center(
                            child: Text(
                              'Tipo 1',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: (filtroProvider.flagTipo1)
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ),
                        avatar: Icon(
                          (filtroProvider.flagTipo1)
                              ? Icons.check
                              : Icons.clear,
                          color: (filtroProvider.flagTipo1)
                              ? Colors.white
                              : Colors.black,
                        ),
                        backgroundColor: Colors.grey,
                        selectedColor: Colors.grey[700],
                        selected: filtroProvider.flagTipo1,
                        onSelected: (_) => {
                          filtroProvider.booleanTipo1(_),
                          filtroProvider.actualizaTipoPlan(tipo1)
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ChoiceChip(
                        label: Container(
                          width: 80,
                          child: Center(
                            child: Text(
                              'Tipo 2',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: (filtroProvider.flagTipo2)
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ),
                        avatar: Icon(
                          (filtroProvider.flagTipo2)
                              ? Icons.check
                              : Icons.clear,
                          color: (filtroProvider.flagTipo2)
                              ? Colors.white
                              : Colors.black,
                        ),
                        backgroundColor: Colors.grey,
                        selectedColor: Colors.grey[700],
                        selected: filtroProvider.flagTipo2,
                        onSelected: (_) => {
                          filtroProvider.booleanTipo2(_),
                          filtroProvider.actualizaTipoPlan(tipo2)
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ChoiceChip(
                        label: Container(
                          width: 80,
                          child: Center(
                            child: Text(
                              'Tipo 3',
                              style: TextStyle(
                                  color: (filtroProvider.flagTipo3)
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                        avatar: Icon(
                          (filtroProvider.flagTipo3)
                              ? Icons.check
                              : Icons.clear,
                          color: (filtroProvider.flagTipo3)
                              ? Colors.white
                              : Colors.black,
                        ),
                        backgroundColor: Colors.grey,
                        selectedColor: Colors.grey[700],
                        selected: filtroProvider.flagTipo3,
                        onSelected: (_) => {
                          filtroProvider.booleanTipo3(_),
                          filtroProvider.actualizaTipoPlan(tipo3)
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ChoiceChip(
                        label: Container(
                          width: 80,
                          child: Center(
                            child: Text(
                              'Tipo 4',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: (filtroProvider.flagTipo4)
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ),
                        avatar: Icon(
                          (filtroProvider.flagTipo4)
                              ? Icons.check
                              : Icons.clear,
                          color: (filtroProvider.flagTipo4)
                              ? Colors.white
                              : Colors.black,
                        ),
                        backgroundColor: Colors.grey,
                        selectedColor: Colors.grey[700],
                        selected: filtroProvider.flagTipo4,
                        onSelected: (_) => {
                          filtroProvider.booleanTipo4(_),
                          filtroProvider.actualizaTipoPlan(tipo4)
                        },
                      ),
                    ],
                  ),
                ))
              ]),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2.25,
              height: 325,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20)),
              child: Stack(alignment: Alignment.topRight, children: [
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.grey[700],
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Center(
                      child: Text(
                    'Coste y rating',
                    style: TextStyle(color: Colors.white),
                  )),
                ),
                Positioned(
                    child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Coste',
                              style: TextStyle(fontSize: 18),
                            ),
                            Container(
                              width: 50,
                              height: 200,
                              child: RatingBar(
                                  glowColor: Colors.grey[700],
                                  tapOnlyMode: true,
                                  initialRating: 0,
                                  direction: Axis.horizontal,
                                  allowHalfRating: false,
                                  itemCount: 5,
                                  ratingWidget: RatingWidget(
                                      full: Icon(Icons.circle,
                                          color: Colors.grey[700]),
                                      half: Icon(
                                        Icons.star_half,
                                        color: Colors.grey[700],
                                      ),
                                      empty: Icon(
                                        Icons.circle_outlined,
                                        color: Colors.grey[700],
                                      )),
                                  onRatingUpdate: (value) {
                                    filtroProvider.actualizaValorCoste(value);
                                  }),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Rating',
                              style: TextStyle(fontSize: 18),
                            ),
                            Container(
                              width: 50,
                              height: 200,
                              child: RatingBar(
                                  glowColor: Colors.grey[700],
                                  tapOnlyMode: true,
                                  initialRating: 0,
                                  direction: Axis.horizontal,
                                  allowHalfRating: false,
                                  itemCount: 5,
                                  ratingWidget: RatingWidget(
                                      full: Icon(Icons.star,
                                          color: Colors.grey[700]),
                                      half: Icon(
                                        Icons.star_half,
                                        color: Colors.grey[700],
                                      ),
                                      empty: Icon(
                                        Icons.star_outline,
                                        color: Colors.grey[700],
                                      )),
                                  onRatingUpdate: (value) {
                                    filtroProvider.actualizaNumCoches(value);
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ))
              ]),
            ),
          ],
        ),
        SizedBox(
          height: 25,
        ),
        GestureDetector(
          onTap: () async {
            await userProvider.usuarioRegistrado(user.uid)
                ? {
                    await filtroProvider.traePlanes(context),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PlanSearchedPage()))
                  } //Lanzar el alert de los datos
                : //lanzar el alert de los datos
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateUserPage()));
          },
          child: Container(
            width: MediaQuery.of(context).size.width / 2,
            height: 45,
            decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(50)),
            child: Center(
              child: Text(
                'Buscar',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class pantallaOrdenador extends StatelessWidget {
  const pantallaOrdenador({
    Key? key,
    required this.comunidades,
    required this.filtroProvider,
    required this.tipo1,
    required this.tipo2,
    required this.tipo3,
    required this.tipo4,
    required this.userProvider,
    required this.user,
  }) : super(key: key);

  final List<String> comunidades;
  final FiltroProviders filtroProvider;
  final String tipo1;
  final String tipo2;
  final String tipo3;
  final String tipo4;
  final UserProvider userProvider;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 4,
              height: 400,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.all(Radius.circular(35))),
              child: Column(children: [
                Container(
                  width: MediaQuery.of(context).size.width / 6,
                  height: 75,
                  decoration: BoxDecoration(
                      color: Colors.grey[700],
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  child: Center(
                    child: Text(
                      'Comunidad y Provincia',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Column(children: [
                  Text(
                    'Comunidad',
                    style: TextStyle(fontSize: 18),
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      hint: const Text('Comunidad'),
                      items: comunidades
                          .map((comunidad) => DropdownMenuItem<String>(
                                value: comunidad,
                                child: Text(
                                  comunidad,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                          .toList(),
                      value: filtroProvider.comunidadSeleccionada,
                      onChanged: (value) {
                        filtroProvider.actualizaComunidadSeleccionada(value);
                        filtroProvider.actualizaProvinciaSeleccinada("-");
                      },
                      buttonStyleData: ButtonStyleData(
                        height: 50,
                        width: 175,
                        padding: const EdgeInsets.only(
                          left: 14,
                          right: 14,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.black26,
                          ),
                          color: Colors.grey[700],
                        ),
                        elevation: 2,
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_forward_ios_outlined,
                        ),
                        iconSize: 14,
                        iconEnabledColor: Colors.white,
                        iconDisabledColor: Colors.grey,
                      ),
                      dropdownStyleData: DropdownStyleData(
                          openInterval: const Interval(0.5, 1),
                          maxHeight: 200,
                          width: 225,
                          padding: EdgeInsets.all(25),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.grey[700],
                          ),
                          elevation: 15,
                          offset: const Offset(-20, 0),
                          scrollbarTheme: ScrollbarThemeData(
                            radius: const Radius.circular(40),
                            thickness: MaterialStateProperty.all(6),
                            thumbVisibility: MaterialStateProperty.all(true),
                          )),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                        padding: EdgeInsets.only(left: 14, right: 14),
                      ),
                    ),
                  ),
                ]),
                SizedBox(
                  height: 25,
                ),
                Column(
                  children: [
                    Text(
                      'Provincia',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        isExpanded: true,
                        hint: const Text('Provincia'),
                        items: comunidadesAutonomas[
                                filtroProvider.comunidadSeleccionada]
                            ?.map((provincia) => DropdownMenuItem<String>(
                                  value: provincia,
                                  child: Text(
                                    provincia,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                            .toList(),
                        value: filtroProvider.provinciaSeleccionada,
                        onChanged: (value) {
                          filtroProvider.actualizaProvinciaSeleccinada(value);
                        },
                        buttonStyleData: ButtonStyleData(
                          height: 50,
                          width: 175,
                          padding: const EdgeInsets.only(
                            left: 14,
                            right: 14,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: Colors.black26,
                            ),
                            color: Colors.grey[700],
                          ),
                          elevation: 2,
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_forward_ios_outlined,
                          ),
                          iconSize: 14,
                          iconEnabledColor: Colors.white,
                          iconDisabledColor: Colors.grey,
                        ),
                        dropdownStyleData: DropdownStyleData(
                            openInterval: const Interval(0.5, 1),
                            maxHeight: 200,
                            width: 225,
                            padding: EdgeInsets.all(25),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.grey[700],
                            ),
                            elevation: 15,
                            offset: const Offset(-20, 0),
                            scrollbarTheme: ScrollbarThemeData(
                              radius: const Radius.circular(40),
                              thickness: MaterialStateProperty.all(6),
                              thumbVisibility: MaterialStateProperty.all(true),
                            )),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                          padding: EdgeInsets.only(left: 14, right: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 4,
              height: 400,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.all(Radius.circular(35))),
              child: Column(children: [
                Container(
                  width: MediaQuery.of(context).size.width / 6,
                  height: 75,
                  decoration: BoxDecoration(
                      color: Colors.grey[700],
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  child: Center(
                    child: Text(
                      'Tipo de plan',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    ChoiceChip(
                      label: Container(
                        width: 80,
                        child: Center(
                          child: Text(
                            'Tipo 1',
                            style: TextStyle(
                                fontSize: 20,
                                color: (filtroProvider.flagTipo1)
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                      ),
                      avatar: Icon(
                        (filtroProvider.flagTipo1) ? Icons.check : Icons.clear,
                        color: (filtroProvider.flagTipo1)
                            ? Colors.white
                            : Colors.black,
                      ),
                      backgroundColor: Colors.grey,
                      selectedColor: Colors.grey[700],
                      selected: filtroProvider.flagTipo1,
                      onSelected: (_) => {
                        filtroProvider.booleanTipo1(_),
                        filtroProvider.actualizaTipoPlan(tipo1)
                      },
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    ChoiceChip(
                      label: Container(
                        width: 80,
                        child: Center(
                          child: Text(
                            'Tipo 2',
                            style: TextStyle(
                                fontSize: 20,
                                color: (filtroProvider.flagTipo2)
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                      ),
                      avatar: Icon(
                        (filtroProvider.flagTipo2) ? Icons.check : Icons.clear,
                        color: (filtroProvider.flagTipo2)
                            ? Colors.white
                            : Colors.black,
                      ),
                      backgroundColor: Colors.grey,
                      selectedColor: Colors.grey[700],
                      selected: filtroProvider.flagTipo2,
                      onSelected: (_) => {
                        filtroProvider.booleanTipo2(_),
                        filtroProvider.actualizaTipoPlan(tipo2)
                      },
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    ChoiceChip(
                      label: Container(
                        width: 80,
                        child: Center(
                          child: Text(
                            'Tipo 3',
                            style: TextStyle(
                                color: (filtroProvider.flagTipo3)
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 20),
                          ),
                        ),
                      ),
                      avatar: Icon(
                        (filtroProvider.flagTipo3) ? Icons.check : Icons.clear,
                        color: (filtroProvider.flagTipo3)
                            ? Colors.white
                            : Colors.black,
                      ),
                      backgroundColor: Colors.grey,
                      selectedColor: Colors.grey[700],
                      selected: filtroProvider.flagTipo3,
                      onSelected: (_) => {
                        filtroProvider.booleanTipo3(_),
                        filtroProvider.actualizaTipoPlan(tipo3)
                      },
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    ChoiceChip(
                      label: Container(
                        width: 80,
                        child: Center(
                          child: Text(
                            'Tipo 4',
                            style: TextStyle(
                                fontSize: 20,
                                color: (filtroProvider.flagTipo4)
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                      ),
                      avatar: Icon(
                        (filtroProvider.flagTipo4) ? Icons.check : Icons.clear,
                        color: (filtroProvider.flagTipo4)
                            ? Colors.white
                            : Colors.black,
                      ),
                      backgroundColor: Colors.grey,
                      selectedColor: Colors.grey[700],
                      selected: filtroProvider.flagTipo4,
                      onSelected: (_) => {
                        filtroProvider.booleanTipo4(_),
                        filtroProvider.actualizaTipoPlan(tipo4)
                      },
                    ),
                  ],
                ),
              ]),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 4,
              height: 400,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.all(Radius.circular(35))),
              child: Column(children: [
                Container(
                  width: MediaQuery.of(context).size.width / 6,
                  height: 75,
                  decoration: BoxDecoration(
                      color: Colors.grey[700],
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  child: Center(
                    child: Text(
                      'Coste y Rating',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Coste',
                            style: TextStyle(fontSize: 18),
                          ),
                          Container(
                            width: 50,
                            height: 200,
                            child: RatingBar(
                                glowColor: Colors.grey[700],
                                tapOnlyMode: true,
                                initialRating: 0,
                                direction: Axis.horizontal,
                                allowHalfRating: false,
                                itemCount: 5,
                                ratingWidget: RatingWidget(
                                    full: Icon(Icons.circle,
                                        color: Colors.grey[700]),
                                    half: Icon(
                                      Icons.star_half,
                                      color: Colors.grey[700],
                                    ),
                                    empty: Icon(
                                      Icons.circle_outlined,
                                      color: Colors.grey[700],
                                    )),
                                onRatingUpdate: (value) {
                                  filtroProvider.actualizaValorCoste(value);
                                }),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Rating',
                            style: TextStyle(fontSize: 18),
                          ),
                          Container(
                            width: 50,
                            height: 200,
                            child: RatingBar(
                                glowColor: Colors.grey[700],
                                tapOnlyMode: true,
                                initialRating: 0,
                                direction: Axis.horizontal,
                                allowHalfRating: false,
                                itemCount: 5,
                                ratingWidget: RatingWidget(
                                    full: Icon(Icons.star,
                                        color: Colors.grey[700]),
                                    half: Icon(
                                      Icons.star_half,
                                      color: Colors.grey[700],
                                    ),
                                    empty: Icon(
                                      Icons.star_outline,
                                      color: Colors.grey[700],
                                    )),
                                onRatingUpdate: (value) {
                                  filtroProvider.actualizaNumCoches(value);
                                }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        GestureDetector(
          onTap: () async {
            await userProvider.usuarioRegistrado(user.uid)
                ? {
                    await filtroProvider.traePlanes(context),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PlanSearchedPage()))
                  } //Lanzar el alert de los datos
                : //lanzar el alert de los datos
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateUserPage()));
          },
          child: Container(
            width: MediaQuery.of(context).size.width / 2,
            height: 45,
            decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(50)),
            child: Center(
              child: Text(
                'Buscar',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
