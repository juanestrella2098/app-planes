import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../components/my_button.dart';
import '../../components/my_fluttertoast.dart';
import '../../components/my_textfield.dart';
import '../../components/square_tile.dart';
import '../../services/auth_services.dart';

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
      if (passwordController.text.length < 6 ||
          confirmPasswordController.text.length < 6) {
        emailController.text = '';
        passwordController.text = '';
        confirmPasswordController.text = '';
        FocusScope.of(context).unfocus();
        myCustomFlutterToast(
            "Las contraseñas tienen que tener mas de 6 caracteres", Colors.red);
      } else
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
        myCustomFlutterToast("Las contraseñas no coinciden", Colors.red);
      }
    } on FirebaseAuthException catch (e) {
      if (!emailController.text.contains("@") ||
          (emailController.text.isEmpty ||
              passwordController.text.isEmpty ||
              confirmPasswordController.text.isEmpty)) {
        emailController.text = '';
        passwordController.text = '';
        confirmPasswordController.text = '';
        FocusScope.of(context).unfocus();
        myCustomFlutterToast("Campos mal introducidos", Colors.red);
        // show error to user
      }
      if (e.code == 'email-already-in-use') {
        emailController.text = '';
        passwordController.text = '';
        confirmPasswordController.text = '';
        FocusScope.of(context).unfocus();
        myCustomFlutterToast(
            "Usuario registrado con otro uso de sesión o ya existe",
            Colors.red);
      }
      //Wrong email
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        emailController.text = '';
        passwordController.text = '';
        FocusScope.of(context).unfocus();
        myCustomFlutterToast("Email o Contraseña incorrecta", Colors.red);
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
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              if (constraints.maxWidth < 600) {
                return SingleChildScrollView(
                  child: pantallaMovil(),
                );
              } else {
                return Center(
                  child: SingleChildScrollView(
                    child: pantallaOrdenador(context),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Column pantallaOrdenador(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      SizedBox(
        height: MediaQuery.of(context).size.height * .10,
      ),
      Container(
        width: 500,
        height: 700,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 100,
              child: Image.asset(
                'lib/images/PlanApp-logos_transparent.png',
                fit: BoxFit.fitWidth,
              ),
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
              textInputType: TextInputType.text,
              controller: emailController,
              hintText: 'Email',
              obscureText: false,
            ),
            SizedBox(
              height: 10,
            ),
            //textfield contraseña
            MyTextField(
              textInputType: TextInputType.text,
              controller: passwordController,
              hintText: 'Contraseña',
              obscureText: true,
            ),
            SizedBox(
              height: 10,
            ),

            MyTextField(
              textInputType: TextInputType.text,
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
              margin: 15,
              padding: 15,
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
              height: 25,
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
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      )
    ]);
  }

  Center pantallaMovil() {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          height: 25,
        ),
        //logo
        Container(
          width: 300,
          height: 100,
          child: Image.asset(
            'lib/images/PlanApp-logos_transparent.png',
            fit: BoxFit.fitWidth,
          ),
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
          textInputType: TextInputType.text,
          controller: emailController,
          hintText: 'Email',
          obscureText: false,
        ),
        SizedBox(
          height: 10,
        ),
        //textfield contraseña
        MyTextField(
          textInputType: TextInputType.text,
          controller: passwordController,
          hintText: 'Contraseña',
          obscureText: true,
        ),
        SizedBox(
          height: 10,
        ),

        MyTextField(
          textInputType: TextInputType.text,
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
          margin: 15,
          padding: 15,
        ),
        SizedBox(
          height: 60,
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
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            )
          ],
        )
      ]),
    );
  }
}
