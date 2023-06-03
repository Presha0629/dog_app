import 'package:dog_app/screens/home_screen.dart';
import 'package:dog_app/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../reusable_widgets/reusable_widget.dart';
import '../utils/color_utils.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            hexStringToColor("EA5A6F"),
            hexStringToColor("DE791E"),
            hexStringToColor("FCCF3A")
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.fromLTRB(
                    20, MediaQuery.of(context).size.height * 0.2, 20, 0),
                child: Column(
                  children: <Widget>[
                    logoWidget(imagePath: 'assets/images/logo.png'),
                    const SizedBox(
                      height: 30,
                    ),
                    reusableTextField("Enter Username", Icons.person_outline,
                        false, _emailTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter Password", Icons.lock_outline,
                        true, _passwordTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    signInSignUpButton(context, true, () async {
                      debugPrint("DEBUG::BHaitha");
                      await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: _emailTextController.text,
                              password: _passwordTextController.text)
                          .then((value) async {
                        // debugPrint("DEBUG::BHaitha");
                        var user = await FirebaseFirestore.instance
                            .collection("Users")
                            .where("Email",
                                isEqualTo: _emailTextController.text)
                            .get();
                        debugPrint("DEBUG::${user.docs.first.data()}");
                        // ignore: use_build_context_synchronously
                        Provider.of<UserProvider>(context, listen: false)
                            .createUser(
                                user.docs.first.data()["Username"],
                                user.docs.first.data()["Email"],
                                user.docs.first.data()["Type"]);
                        debugPrint(
                            "DEBUG::UserType= ${user.docs.first.data()["Type"]}");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()));
                      }).onError((error, stackTrace) {
                        // ignore: avoid_print
                        debugPrint("DEBUG::Error ${error.toString()}");
                      });
                    }),
                    signUpOption()
                  ],
                )),
          )),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?",
            style: TextStyle(color: Color.fromARGB(179, 15, 14, 14))),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()));
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(
                color: Color.fromARGB(255, 25, 25, 25),
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
