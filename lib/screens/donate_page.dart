import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dog_app/entities/user.dart';

class DonationPage extends StatelessWidget {
  const DonationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Donation Page"),
        backgroundColor: const Color.fromARGB(49, 32, 54, 65),
      ),
      body: const OrganizationList(),
    );
  }
}

class OrganizationList extends StatelessWidget {
  const OrganizationList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<User>>(
      future: getOrganizationList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Show a loading indicator while waiting
        } else if (snapshot.hasError) {
          return Text(
              'Error: ${snapshot.error}'); // Show an error message if there's an error
        } else {
          List<User>? organizations = snapshot.data;
          return ListView.builder(
            itemCount: organizations?.length ?? 0,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Image.asset("assets/images/orglogo.webp"),
                title: Text(organizations![index].userName),
                subtitle: Text(organizations[index].phoneNumber),
                subtitleTextStyle: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                tileColor: const Color.fromARGB(255, 166, 200, 220),
                titleTextStyle: const TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                ),
                onTap: () {
                  showDetails(context, organizations[index]);
                },
              );
            },
          );
        }
      },
    );
  }
}

Future<List<User>> getOrganizationList() async {
  List<User> organizations = <User>[];
  final queryInstance = await FirebaseFirestore.instance
      .collection("Users")
      .where("Type", isEqualTo: "Organization")
      .get();

  for (var org in queryInstance.docs) {
    organizations.add(User(
        org.data()["Username"],
        org.data()["Email"],
        org.data()["Type"],
        org.data()["Phone Number"],
        org.data()["Location"]));
  }
  return (organizations);
}

void showDetails(BuildContext context, User user) async {
  final textStyle = Theme.of(context).textTheme.titleLarge;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return (AlertDialog(
        title: const Text("Details"),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/images/orglogo.webp"),
            Text("Name:${user.userName}", style: textStyle),
            Text("PhoneNo:${user.phoneNumber}", style: textStyle),
            Text("Location:${user.location}", style: textStyle),
            Text("Email: ${user.email}", style: textStyle),
          ],
        ),
      ));
    },
  );
}
