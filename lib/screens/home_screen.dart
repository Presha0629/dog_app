import 'package:dog_app/screens/donate_page.dart';
import 'package:dog_app/screens/rescue_page.dart';
import 'package:flutter/material.dart';

import 'package:dog_app/utils/color_utils.dart';
import 'package:dog_app/screens/adopt_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: const DashBoard(),
    );
  }
}

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);

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
      child: const Column(
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
          )
        ],
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
        width: 250,
        height: 200,
        child: Column(
          children: [Image.asset(imagePath), Text(title)],
        ),
      ),
    ));
  }
}


// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//           child: const Text("Logout"),
//           onPressed: () {
//             FirebaseAuth.instance.signOut().then((value) {
//               print("Signed Out");
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const SignInScreen()));
//             });
//           },
//         ),
//       ),
//     );
//   }
// }
