import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:plan_app/components/my_button.dart';
import 'package:plan_app/components/my_button_profile.dart';
import 'package:plan_app/pages/logged_pages/user_pages/show_user.dart';
import 'package:plan_app/pages/logged_pages/user_pages/update_user.dart';
import 'package:plan_app/pages/login_or_register_pages/register_page.dart';
import 'package:plan_app/providers/user_provider.dart';
import 'package:plan_app/services/plan_services.dart';
import 'package:plan_app/services/user_service.dart';
import 'package:provider/provider.dart';

import '../../favs_pages/details_page.dart';
import 'createUser.dart';

class UserPage extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;
  void signUserOut() {
    FirebaseAuth.instance.signOut();
    GoogleSignIn()
        .disconnect()
        .then((value) => FirebaseAuth.instance.signOut());
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
      child: Center(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
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
                      )),
            SizedBox(
              height: 25,
            ),
            MyButtonProfile(
              text: 'Ver planes realizados',
              onTap: () async {
                PlanService planService = PlanService();
                planService.getPlans();
                //await userProvider.usuarioRegistrado(user.uid)
                //    ? print('Registrado')
                //    : //lanzar la pantalla de los planes realizados
                //    Navigator.push(
                //        context,
                //        MaterialPageRoute(
                //            builder: (context) => CreateUserPage()));
              },
            ),
            SizedBox(
              height: 25,
            ),
            MyButtonProfile(
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
                text: 'Cerrar Sesión',
                onTap: () => {userProvider.reseteaProvider(), signUserOut()}),
            SizedBox(
              height: 25,
            ),
            MyButtonProfile(
              text: 'Eliminar perfil',
              onTap: () =>
                  {userProvider.eliminaUsuario(user.uid), deleteUser()},
            ),
          ],
        ),
      )),
    );
  }
}
