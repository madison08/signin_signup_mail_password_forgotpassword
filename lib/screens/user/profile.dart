import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:signin_mail_password_forgotpassword/screens/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final email = FirebaseAuth.instance.currentUser!.email;
  final creationTime = FirebaseAuth.instance.currentUser!.metadata.creationTime;

  User? user = FirebaseAuth.instance.currentUser;

  verifyEmail() async {
    if (user != null && !user!.emailVerified) {
      await user!.sendEmailVerification();

      print('la verification d\'email a ete envoyer ');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('le mail de verification a ete envoyer'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 60.0,
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20.0),
            child: FlutterLogo(
              size: 100.0,
            ),
          ),
          SizedBox(
            height: 50.0,
          ),
          Text(
            'User ID :',
          ),
          Text(
            uid,
          ),
          SizedBox(
            height: 50.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Email : $email',
              ),
              user!.emailVerified
                  ? Text(
                      ' verifier',
                      style: TextStyle(color: Colors.green),
                    )
                  : TextButton(
                      onPressed: () {
                        print('hey');
                        verifyEmail();
                      },
                      child: Text(
                        'Verifier email',
                      ),
                    )
            ],
          ),
          SizedBox(
            height: 50.0,
          ),
          Column(
            children: <Widget>[
              Text(
                'Date de creation',
              ),
              Text(
                creationTime.toString(),
              )
            ],
          ),
          SizedBox(
            height: 50.0,
          ),
          ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();

              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                builder: (context) {
                  return LoginScreen();
                },
              ), (route) => false);
            },
            child: Text(
              'Deconneion',
            ),
          )
        ],
      ),
    );
  }
}
