import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:plan_app/components/my_button_profile.dart';
import 'package:plan_app/pages/logged_pages/user_pages/plans_realized.dart';
import 'package:plan_app/pages/logged_pages/user_pages/show_user.dart';
import 'package:plan_app/pages/logged_pages/user_pages/update_user.dart';
import 'package:plan_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../components/my_button_accept_cancel.dart';
import 'createUser.dart';

class UserPage extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;
  void signUserOut() {
    if (FirebaseAuth.instance.currentUser!.providerData[0].providerId ==
        "google.com") {
      GoogleSignIn()
          .disconnect()
          .then((value) => FirebaseAuth.instance.signOut());
    } else {
      FirebaseAuth.instance.signOut();
    }
  }

  void deleteUser() {
    user.delete();
    GoogleSignIn()
        .disconnect()
        .then((value) => FirebaseAuth.instance.signOut());
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return SafeArea(
      child: Center(child: SingleChildScrollView(
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth < 600) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 25,
                ),
                MyButtonProfile(
                  backgroundColor: Colors.grey[700]!,
                  text: 'Ver planes realizados',
                  onTap: () async {
                    await userProvider.getPlanesRealizados();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PlansRealizedPage()));
                  },
                ),
                SizedBox(
                  height: 25,
                ),
                MyButtonProfile(
                  backgroundColor: Colors.grey[700]!,
                  text: 'Ver perfil',
                  onTap: () async {
                    await userProvider.usuarioRegistrado(user.uid)
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ShowUserPage())) //Lanzar el alert de los datos
                        : //lanzar el alert de los datos
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateUserPage()));
                  },
                ),
                SizedBox(
                  height: 25,
                ),
                MyButtonProfile(
                  backgroundColor: Colors.grey[700]!,
                  text: 'Actualizar perfil',
                  onTap: () async {
                    await userProvider.usuarioRegistrado(user.uid)
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    UpdateUserPage())) //Lanzar el alert de los datos
                        : //lanzar el alert de los datos
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateUserPage()));
                  },
                ),
                SizedBox(
                  height: 25,
                ),
                MyButtonProfile(
                  backgroundColor: Colors.grey[700]!,
                  text: 'Cerrar Sesión',
                  onTap: () => showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            title: Text('¿Quieres cerrar sesión?'),
                            content: Text('Vas a cerrar sesión'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: ButtonAcceptCancel(
                                    texto: "Cancelar",
                                    backgroundColor: Colors.grey,
                                    fontColor: Colors.black,
                                  )),
                              TextButton(
                                  onPressed: () async {
                                    await userProvider.reseteaProvider();
                                    await Future.delayed(Duration(seconds: 1));
                                    signUserOut();
                                    Navigator.pop(context);
                                  },
                                  child: ButtonAcceptCancel(
                                      texto: 'Cerrar sesión',
                                      backgroundColor: Colors.grey[700]!,
                                      fontColor: Colors.white))
                            ],
                          )),
                ),
                SizedBox(
                  height: 25,
                ),
                MyButtonProfile(
                  backgroundColor: Colors.red[700]!,
                  text: 'Eliminar perfil',
                  onTap: () => showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            title: Text('¿Borrar tu cuenta?'),
                            content: Text('Vas a borrar la cuenta'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: ButtonAcceptCancel(
                                    texto: "Cancelar",
                                    backgroundColor: Colors.grey,
                                    fontColor: Colors.black,
                                  )),
                              TextButton(
                                  onPressed: () {
                                    userProvider.eliminaUsuario(user.uid);
                                    userProvider.reseteaProvider();
                                    deleteUser();
                                    Navigator.pop(context);
                                  },
                                  child: ButtonAcceptCancel(
                                      texto: 'Borrar',
                                      backgroundColor: Colors.grey[700]!,
                                      fontColor: Colors.white))
                            ],
                          )),

                  //{userProvider.eliminaUsuario(user.uid), deleteUser()},
                ),
              ],
            );
          } else {
            return Container(
              width: 500,
              height: 650,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      MyButtonProfile(
                        backgroundColor: Colors.grey[700]!,
                        text: 'Ver planes realizados',
                        onTap: () async {
                          await userProvider.getPlanesRealizados();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PlansRealizedPage()));
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      MyButtonProfile(
                        backgroundColor: Colors.grey[700]!,
                        text: 'Ver perfil',
                        onTap: () async {
                          await userProvider.usuarioRegistrado(user.uid)
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ShowUserPage())) //Lanzar el alert de los datos
                              : //lanzar el alert de los datos
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CreateUserPage()));
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      MyButtonProfile(
                        backgroundColor: Colors.grey[700]!,
                        text: 'Actualizar perfil',
                        onTap: () async {
                          await userProvider.usuarioRegistrado(user.uid)
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          UpdateUserPage())) //Lanzar el alert de los datos
                              : //lanzar el alert de los datos
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CreateUserPage()));
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      MyButtonProfile(
                        backgroundColor: Colors.grey[700]!,
                        text: 'Cerrar Sesión',
                        onTap: () => showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  title: Text('¿Quieres cerrar sesión?'),
                                  content: Text('Vas a cerrar sesión'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: ButtonAcceptCancel(
                                          texto: "Cancelar",
                                          backgroundColor: Colors.grey,
                                          fontColor: Colors.black,
                                        )),
                                    TextButton(
                                        onPressed: () async {
                                          await userProvider.reseteaProvider();
                                          await Future.delayed(
                                              Duration(seconds: 1));
                                          signUserOut();
                                          Navigator.pop(context);
                                        },
                                        child: ButtonAcceptCancel(
                                            texto: 'Cerrar sesión',
                                            backgroundColor: Colors.grey[700]!,
                                            fontColor: Colors.white))
                                  ],
                                )),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      MyButtonProfile(
                        backgroundColor: Colors.red[700]!,
                        text: 'Eliminar perfil',
                        onTap: () => showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  title: Text('¿Borrar tu cuenta?'),
                                  content: Text('Vas a borrar la cuenta'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: ButtonAcceptCancel(
                                          texto: "Cancelar",
                                          backgroundColor: Colors.grey,
                                          fontColor: Colors.black,
                                        )),
                                    TextButton(
                                        onPressed: () {
                                          userProvider.eliminaUsuario(user.uid);
                                          userProvider.reseteaProvider();
                                          deleteUser();
                                          Navigator.pop(context);
                                        },
                                        child: ButtonAcceptCancel(
                                            texto: 'Borrar',
                                            backgroundColor: Colors.grey[700]!,
                                            fontColor: Colors.white))
                                  ],
                                )),

                        //{userProvider.eliminaUsuario(user.uid), deleteUser()},
                      ),
                    ],
                  )
                ],
              ),
            );
          }
        }),
      )),
    );
  }
}

class profile_photo extends StatelessWidget {
  const profile_photo({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
        child: (user.photoURL != null)
            ? Image.network(
                user.photoURL!,
                width: 100,
                height: 100,
              )
            : Image.asset(
                'lib/images/google.png',
                width: 100,
                height: 100,
              ));
  }
}
