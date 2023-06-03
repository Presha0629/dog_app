import 'package:dog_app/reusable_widgets/reusable_widget.dart';
import 'package:dog_app/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import '../utils/color_utils.dart';
import 'package:dog_app/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final List<String> userType = ["User", "Organization"];

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _userNameTextController = TextEditingController();
  final TextEditingController _locationTextController = TextEditingController();
  final TextEditingController _phoneNumberTextController =
      TextEditingController();
  String currentValue = userType[0];
  void changeUserType(String? value) {
    setState(() {
      currentValue = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> onlyForOrganization = [
      const SizedBox(
        height: 20,
      ),
      reusableTextField("Enter Location", Icons.location_city, false,
          _locationTextController),
      const SizedBox(
        height: 20,
      ),
      reusableTextField(
          "Enter Phone Number", Icons.phone, false, _phoneNumberTextController),
      const SizedBox(
        height: 20,
      ),
    ];
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
            padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Username", Icons.person_outline, false,
                    _userNameTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField(
                    "Enter Email Id", Icons.email, false, _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Password", Icons.lock_outline, true,
                    _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                UserTypeSelector(
                  currentValue: currentValue,
                  changeUserType: changeUserType,
                ),
                if (currentValue == "Organization") ...onlyForOrganization,

                // reusableDropdown('Select Option', Icons.arrow_drop_down, [
                //   'User',
                //   'Organization',
                // ], "User", (String newValue) {
                //   setState(() {
                //     "User" = newValue; // Update the selected value
                //   });
                // });
                const SizedBox(
                  height: 20,
                ),
                signInSignUpButton(context, false, () async {
                  await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                      .then((value) async {
                    print("Created New Account");
                    var data = {
                      "Email": _emailTextController.text,
                      "Location": _locationTextController.text,
                      "Phone Number": _phoneNumberTextController.text,
                      "Type": currentValue,
                      "Username": _userNameTextController.text
                    };
                    await FirebaseFirestore.instance
                        .collection("Users")
                        .add(data)
                        .whenComplete(
                            () => debugPrint("DEBUG::Stored to Database"));
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                    );
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                }),
                signInOption()
              ],
            ),
          ))),
    );
  }

  Row signInOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account?",
            style: TextStyle(color: Color.fromARGB(179, 16, 15, 15))),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignInScreen()));
          },
          child: const Text(
            "Sign In",
            style: TextStyle(
                color: Color.fromARGB(255, 15, 15, 15),
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}

class UserTypeSelector extends StatefulWidget {
  const UserTypeSelector(
      {required this.currentValue, required this.changeUserType, super.key});
  final String currentValue;
  final void Function(String?) changeUserType;
  @override
  State<UserTypeSelector> createState() => _UserTypeSelectorState();
}

class _UserTypeSelectorState extends State<UserTypeSelector> {
  String currentValue = userType[0];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      items: userType.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      value: currentValue,
      onChanged: widget.changeUserType,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.widgets,
          color: Color.fromARGB(179, 16, 15, 15),
        ),
        labelText: "text",
        labelStyle: TextStyle(
          color: const Color.fromARGB(255, 16, 16, 16).withOpacity(0.9),
        ),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: const Color.fromARGB(255, 249, 247, 247).withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none),
        ),
      ),
    );
  }
}
