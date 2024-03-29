import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plan_app/components/my_fluttertoast.dart';
import 'package:plan_app/pages/login_or_register_pages/reset_password.dart';

import '../../components/my_button.dart';
import '../../components/my_textfield.dart';
import '../../components/square_tile.dart';
import '../../services/auth_services.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  //sign in user method
  void signUserIn() async {
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
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      //field empty or not enter a email
      if (!emailController.text.contains("@") ||
          (emailController.text.isEmpty || passwordController.text.isEmpty)) {
        emailController.text = '';
        passwordController.text = '';
        FocusScope.of(context).unfocus();
        myCustomFlutterToast("Campos mal introducidos", Colors.red);
        // show error to user
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
              return pantallaMovil(context);
            } else {
              return pantallaOrdenador(context);
            }
          }),
        ),
      ),
    );
  }

  SingleChildScrollView pantallaOrdenador(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .10,
            ),
            Container(
              margin: EdgeInsets.only(bottom: 50),
              width: 500,
              height: 650,
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
                      'Bienvenido, ¡te hemos echado de menos!',
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
                    //olvidaste contraseña?
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: (() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ResetPage()));
                            }),
                            child: Text(
                              '¿Olvidaste la contraseña?',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    //boton login
                    MyButton(
                      onTap: signUserIn,
                      text: 'Iniciar Sesión',
                      margin: 15,
                      padding: 15,
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
                          '¿No te uniste?',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: Text(
                            'Regístrate ahora',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ]),
            )
          ],
        ),
      ),
    );
  }

  SingleChildScrollView pantallaMovil(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            height: 50,
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
            height: 50,
          ),
          //bienvenido, te hemos hechado de menos
          Text(
            'Bienvenido, ¡te hemos echado de menos!',
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
          //olvidaste contraseña?
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: (() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ResetPage()));
                  }),
                  child: Text(
                    '¿Olvidaste la contraseña?',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          //boton login
          MyButton(
            onTap: signUserIn,
            text: 'Iniciar Sesión',
            margin: 25,
            padding: 25,
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
                '¿No te uniste?',
                style: TextStyle(color: Colors.grey[700]),
              ),
              SizedBox(
                width: 4,
              ),
              GestureDetector(
                onTap: widget.onTap,
                child: Text(
                  'Regístrate ahora',
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}
