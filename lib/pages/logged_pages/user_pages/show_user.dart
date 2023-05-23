import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../components/my_button.dart';
import '../../../components/my_textfield.dart';
import '../../../providers/user_provider.dart';

class ShowUserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                height: 25,
              ),
              //logo
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[700],
                child: Text(
                  userProvider.user.nombre[0],
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              //bienvenido, te hemos hechado de menos
              Text(
                'Tus datos',
                style: TextStyle(color: Colors.grey[700], fontSize: 16),
              ),
              SizedBox(
                height: 25,
              ),
              //textfield email
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .125,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(50)),
                  child: Stack(children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50)),
                          color: Colors.grey[700],
                        ),
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 40,
                        child: Center(
                            child: Text(
                          'Nombre y Apellidos',
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            '${userProvider.user.nombre} ${userProvider.user.apellido}',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    )
                  ]),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              //textfield contraseña
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .125,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(50)),
                  child: Stack(children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50)),
                          color: Colors.grey[700],
                        ),
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 40,
                        child: Center(
                            child: Text(
                          'Edad',
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            userProvider.user.edad.toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    )
                  ]),
                ),
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
                  Navigator.pop(context);
                },
                text: 'Volver para atrás',
              ),
              SizedBox(
                height: 50,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
