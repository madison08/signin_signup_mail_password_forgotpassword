// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:signin_mail_password_forgotpassword/screens/forgot_password.dart';
import 'package:signin_mail_password_forgotpassword/screens/signup_screen.dart';

import 'user_main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  var email = "";
  var password = "";

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => UserMainScreen(),
          ));
    } on FirebaseAuthException catch (err) {
      if (err.code == "user-not-found") {
        print("Pas d'utilisateur avec cette adresse mail");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "Pas d'utilisateur avec cette adresse mail",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        );
      } else if (err.code == "wrong-password") {
        print("Mot de passe incorrecte");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "Mot de passe incorrecte",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose

    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FlutterLogo(
                    size: 100.0,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 20.0,
                  ),
                  child: TextFormField(
                    autofocus: false,
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Svp entrer votre email';
                      } else if (!value.contains('@')) {
                        return 'Entrer une addresse mail valide';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: TextFormField(
                    autofocus: false,
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Mot de passe',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Svp entrer votre mot de passe';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              email = emailController.text;
                              password = passwordController.text;
                            });
                            userLogin();
                          }
                        },
                        child: Text("Se connecter"),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgotPasswordScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Mot de passe oublier",
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Text("Vous n'avez pas de compte"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(
                            builder: (context) {
                              return SignupScreen();
                            },
                          ), (route) => false);
                        },
                        child: Text(
                          "Inscrivez-vous",
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
