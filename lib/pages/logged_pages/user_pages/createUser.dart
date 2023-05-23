import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../components/my_button.dart';
import '../../../components/my_textfield.dart';
import '../../../providers/user_provider.dart';

class CreateUserPage extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;
  final nombreController = TextEditingController();
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
              child: Column(
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

                    //bienvenido, te hemos hechado de menos
                    Text(
                      'Para poder utilzar esta función, rellena tus datos',
                      style: TextStyle(color: Colors.grey[700], fontSize: 16),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    //textfield email
                    MyTextField(
                      textInputType: TextInputType.text,
                      controller: nombreController,
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
                      height: 10,
                    ),
                    //olvidaste contraseña?

                    SizedBox(
                      height: 25,
                    ),
                    //boton login
                    MyButton(
                      onTap: () {
                        (userProvider.registrarUsuario(
                            user.uid,
                            nombreController.text,
                            surnameController.text,
                            int.parse(edadController.text)));
                        Navigator.pop(context);
                      },
                      text: 'Registrar Datos',
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
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}