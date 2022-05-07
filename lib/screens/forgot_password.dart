// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:signin_mail_password_forgotpassword/screens/login_screen.dart';
import 'package:signin_mail_password_forgotpassword/screens/signup_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  var email = "";

  final emailController = TextEditingController();

  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Le mot de de renitialisation a ete envoyer',
          ),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return LoginScreen();
          },
        ),
      );
    } on FirebaseAuthException catch (err) {
      if (err.code == 'user-not-found') {
        print('utilisateur non trouver');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'l\'utilisateur n\'existe pas',
            ),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Renitialiser mot de passe',
        ),
        actions: [],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20.0),
            child: FlutterLogo(
              size: 150.0,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 15.0,
            ),
            child: Text(
              'Un lien de renitialisation seras envoyer sur votre email',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
          Expanded(
              child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 15.0,
              ),
              child: ListView(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      autofocus: false,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer votre mail';
                        } else if (!value.contains('@')) {
                          return 'Entrer une adresse mail correcte';
                        }

                        return null;
                      },
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                email = emailController.text;
                              });
                              resetPassword();
                            }
                          },
                          child: Text('Envoyer mail'),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return LoginScreen();
                                },
                              ),
                            );
                          },
                          child: Text('Se connecter'),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Text('Vous n\'avez pas de compte ?'),
                        TextButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(context,
                                  PageRouteBuilder(
                                      pageBuilder: (context, a, b) {
                                return SignupScreen();
                              }), (route) => false);
                            },
                            child: Text('Inscrivez-vous'))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}
