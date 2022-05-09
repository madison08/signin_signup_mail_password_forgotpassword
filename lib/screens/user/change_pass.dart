import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:signin_mail_password_forgotpassword/screens/login_screen.dart';

class ChangePassScreen extends StatefulWidget {
  const ChangePassScreen({Key? key}) : super(key: key);

  @override
  State<ChangePassScreen> createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {
  final _formKey = GlobalKey<FormState>();

  var newPassword = "";

  final newPasswordController = TextEditingController();

  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  void dispose() {
    newPasswordController.dispose();

    super.dispose();
  }

  changePassword() async {
    try {
      await currentUser!.updatePassword(newPassword.trim());
      FirebaseAuth.instance.signOut();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return LoginScreen();
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('votre mot de passe a bien ete changer'),
        ),
      );
    } on FirebaseAuthException catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            FlutterLogo(
              size: 100.0,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 10.0,
              ),
              child: TextFormField(
                autofocus: false,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Nouveau mot de passe',
                  hintText: 'Entrer votre nouveau mot de passe',
                  border: OutlineInputBorder(),
                ),
                controller: newPasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'S\'il vous plait entrer le nouveau mot de passe';
                  }
                  return null;
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    newPassword = newPasswordController.text;
                  });
                  changePassword();
                }
              },
              child: Text('Changer mot de passe '),
            )
          ],
        ),
      ),
    );
  }
}
