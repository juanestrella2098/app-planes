import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../components/my_button.dart';
import '../../../components/my_textfield.dart';
import '../../../components/square_tile.dart';
import '../../../providers/user_provider.dart';
import '../../../services/auth_services.dart';

class UpdateUserPage extends StatelessWidget {
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final edadController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.grey[300],
          body: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  //Pantalla Movil
                  if (constraints.maxWidth < 600) {
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          //logo
                          Icon(
                            Icons.lock,
                            size: 100,
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            'Vamos a cambiar los datos',
                            style: TextStyle(
                                color: Colors.grey[700], fontSize: 16),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          //textfield email
                          MyTextField(
                            textInputType: TextInputType.text,
                            controller: nameController,
                            hintText: 'Nombre',
                            obscureText: false,
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          //textfield contraseña
                          MyTextField(
                            textInputType: TextInputType.text,
                            controller: surnameController,
                            hintText: 'Apellido',
                            obscureText: false,
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          //textfield contraseña
                          MyTextField(
                            textInputType: TextInputType.number,
                            controller: edadController,
                            hintText: 'Edad',
                            obscureText: false,
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          MyButton(
                            onTap: () {
                              if (nameController.text == '') {
                                nameController.text = userProvider.user.nombre;
                              }
                              if (surnameController.text == '') {
                                surnameController.text =
                                    userProvider.user.apellido;
                              }
                              if (edadController.text == '') {
                                edadController.text =
                                    userProvider.user.edad.toString();
                              }
                              userProvider.actualizarUsuario(
                                  userProvider.user.idFirebase,
                                  nameController.text,
                                  surnameController.text,
                                  int.parse(edadController.text));
                              Navigator.pop(context);
                            },
                            text: 'Cambiar datos',
                            margin: 25,
                            padding: 25,
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Divider(
                                thickness: 0.5,
                                color: Colors.grey[400],
                              )),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0),
                                child: Text(
                                  'O vuelve al perfil',
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                              ),
                              Expanded(
                                  child: Divider(
                                thickness: 0.5,
                                color: Colors.grey[400],
                              )),
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          MyButton(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            text: 'Volver para atrás',
                            margin: 25,
                            padding: 25,
                          ),
                        ]);
                  } else {
                    return Container(
                      width: 500,
                      height: 700,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.lock,
                            size: 75,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Vamos a cambiar los datos',
                            style: TextStyle(
                                color: Colors.grey[700], fontSize: 16),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          //textfield email
                          MyTextField(
                            textInputType: TextInputType.text,
                            controller: nameController,
                            hintText: 'Nombre',
                            obscureText: false,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          //textfield contraseña
                          MyTextField(
                            textInputType: TextInputType.text,
                            controller: surnameController,
                            hintText: 'Apellido',
                            obscureText: false,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          //textfield contraseña
                          MyTextField(
                            textInputType: TextInputType.number,
                            controller: edadController,
                            hintText: 'Edad',
                            obscureText: false,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          MyButton(
                            onTap: () {
                              if (nameController.text == '') {
                                nameController.text = userProvider.user.nombre;
                              }
                              if (surnameController.text == '') {
                                surnameController.text =
                                    userProvider.user.apellido;
                              }
                              if (edadController.text == '') {
                                edadController.text =
                                    userProvider.user.edad.toString();
                              }
                              userProvider.actualizarUsuario(
                                  userProvider.user.idFirebase,
                                  nameController.text,
                                  surnameController.text,
                                  int.parse(edadController.text));
                              Navigator.pop(context);
                            },
                            text: 'Cambiar datos',
                            margin: 15,
                            padding: 15,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Divider(
                                thickness: 0.5,
                                color: Colors.grey[400],
                              )),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0),
                                child: Text(
                                  'O vuelve al perfil',
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                              ),
                              Expanded(
                                  child: Divider(
                                thickness: 0.5,
                                color: Colors.grey[400],
                              )),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          MyButton(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            text: 'Volver para atrás',
                            margin: 15,
                            padding: 15,
                          ),
                        ],
                      ),
                    );
                  }
                }),
              ),
            ),
          ),
        ));
  }
}
