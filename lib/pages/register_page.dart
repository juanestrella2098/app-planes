import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../components/square_tile.dart';
import '../services/auth_services.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  //sign up user method
  void signUserUp() async {
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

    //try sign up
    try {
      //check if password and confirm password are the same
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
      } else {
        //show error message, passwords don't match
        emailController.text = '';
        passwordController.text = '';
        confirmPasswordController.text = '';
        FocusScope.of(context).unfocus();
        Fluttertoast.showToast(
            msg: "Las contraseñas no coinciden",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } on FirebaseAuthException catch (e) {
      //Wrong email
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        emailController.text = '';
        passwordController.text = '';
        FocusScope.of(context).unfocus();
        Fluttertoast.showToast(
            msg: "Email o Contraseña incorrecta",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
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
                      height: 25,
                    ),
                    //logo
                    Icon(
                      Icons.lock,
                      size: 50,
                    ),
                    SizedBox(
                      height: 25,
                    ),

                    //bienvenido, te hemos hechado de menos
                    Text(
                      '¡Vamos a crear una cuenta!',
                      style: TextStyle(color: Colors.grey[700], fontSize: 16),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    //textfield email
                    MyTextField(
                      controller: emailController,
                      hintText: 'Email',
                      obscureText: false,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //textfield contraseña
                    MyTextField(
                      controller: passwordController,
                      hintText: 'Contraseña',
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    MyTextField(
                      controller: confirmPasswordController,
                      hintText: 'Confirmar contraseña',
                      obscureText: true,
                    ),

                    SizedBox(
                      height: 25,
                    ),
                    //boton login
                    MyButton(
                      onTap: signUserUp,
                      text: 'Registrarse',
                    ),
                    SizedBox(
                      height: 50,
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
                            'O continua con',
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
                    //o continua con (google boton)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SquareTile(
                          imagePath: 'lib/images/google.png',
                          onTap: () => AuthService().signInWithGoogle(),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    //no eres miembro?registrate
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '¿Tienes una cuenta?',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: Text(
                            'Logueate ahora',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
