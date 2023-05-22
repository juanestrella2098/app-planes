import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:plan_app/components/my_fluttertoast.dart';

import '../../components/my_button.dart';
import '../../components/my_textfield.dart';
import '../../components/square_tile.dart';
import '../../services/auth_services.dart';

class ResetPage extends StatefulWidget {
  @override
  State<ResetPage> createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  final emailController = TextEditingController();

  //sign in user method
  void resetPassword() async {
    //show loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.black,
          ));
        });

    //pop the loading circle
    Navigator.pop(context);

    //try sign in
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text);
      myCustomFlutterToast(
          "Se ha enviado un correo con tu nueva contraseña", Colors.green);
    } on FirebaseAuthException catch (e) {
      //Wrong email
      if (e.code == 'user-not-found') {
        emailController.text = '';
        FocusScope.of(context).unfocus();
        myCustomFlutterToast("Email no encontrado", Colors.red);
        // show error to user
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  'Vamos a enviarte una nueva contraseña',
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                ),
                SizedBox(
                  height: 25,
                ),
                //textfield email
                MyTextField(
                  textInputType: TextInputType.text,
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                SizedBox(
                  height: 25,
                ),
                MyButton(
                  onTap: resetPassword,
                  text: 'Recuperar Contraseña',
                ),
                SizedBox(
                  height: 25,
                ),
                MyButton(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  text: 'Volver atrás',
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
