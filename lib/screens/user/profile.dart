import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final email = FirebaseAuth.instance.currentUser!.email;
  final creationTime = FirebaseAuth.instance.currentUser!.metadata.creationTime;

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
            child: FlutterLogo(),
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
            children: <Widget>[
              Text(
                'Email : $email',
              ),
              TextButton(
                onPressed: () {
                  print('hey');
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
            onPressed: () {},
            child: Text(
              'Logout',
            ),
          )
        ],
      ),
    );
  }
}
