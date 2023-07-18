import 'package:dog_app/providers/user_provider.dart';
import 'package:dog_app/screens/donate_page.dart';
import 'package:dog_app/screens/rescue_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dog_app/entities/user.dart';

import 'package:dog_app/utils/color_utils.dart';
import 'package:dog_app/screens/adopt_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserProvider>(context);
    final User user = userData.user!;

    return Scaffold(
      appBar: AppBar(
        title: (user.type == "User"
            ? const Text("User Dashboard")
            : const Text("Organization Dashboard")),
        backgroundColor: const Color.fromARGB(48, 66, 76, 79),
        // actions: [
        //   ElevatedButton(
        //     onPressed: () async {
        //       await firebase_auth.FirebaseAuth.instance.signOut();
        //       userData.signOut();
        //     },
        //     child: const Text(
        //       'Sign Out',
        //       style: TextStyle(backgroundColor:Color.fromARGB(5, 5, 5, 5)),
        //     ),
        //   ),
        // ],
      ),
      body: const DashBoard(),
    );
  }
}

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        hexStringToColor("#7EE8FA"),
        hexStringToColor("#EEC0C6"),
        hexStringToColor("7EE8FA")
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: const SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MyCard(
              imagePath: 'assets/images/Rescue_image.jfif',
              title: 'Rescue',
            ),
            SizedBox(
              width: 15,
              height: 15,
            ),
            MyCard(
              imagePath: 'assets/images/adopt3.jfif',
              title: 'Adopt',
            ),
            SizedBox(
              width: 15,
              height: 15,
            ),
            MyCard(
              imagePath: 'assets/images/donate2.jfif',
              title: 'Donation',
            ),
          ],
        ),
      ),
    ));
  }
}

class MyCard extends StatelessWidget {
  const MyCard({required this.imagePath, required this.title, Key? key})
      : super(key: key);
  final String imagePath;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Card(
        child: InkWell(
      onTap: () {
        if (title == "Adopt") {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AdoptionPage()));
        } else if (title == "Donation") {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const DonationPage()));
        } else {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const RescuePage()));
        }
      },
      child: SizedBox(
        width: 200,
        height: 200,
        child: Column(
          children: [
            Image.asset(imagePath),
            const SizedBox(
              width: 15,
              height: 15,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    ));
  }
}
