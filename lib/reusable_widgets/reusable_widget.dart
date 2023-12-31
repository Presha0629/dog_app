import 'package:flutter/material.dart';

Image logoWidget({
  required String imagePath,
}) {
  return Image.asset(
    imagePath,
    fit: BoxFit.fitWidth,
    width: 300,
    height: 300,
  );
}

TextField reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: const Color.fromARGB(255, 15, 15, 15),
    style: TextStyle(
      color: const Color.fromARGB(255, 15, 15, 15).withOpacity(0.9),
    ),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: const Color.fromARGB(255, 5, 5, 5),
      ),
      labelText: text,
      labelStyle: TextStyle(
        color: const Color.fromARGB(255, 5, 5, 5).withOpacity(0.9),
      ),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: const Color.fromARGB(255, 249, 247, 247).withOpacity(0.3),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: const BorderSide(width: 0, style: BorderStyle.none),
      ),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

Container signInSignUpButton(
    BuildContext context, bool isLogin, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return const Color.fromARGB(66, 196, 103, 11);
          }
          return const Color.fromARGB(255, 251, 250, 250);
        }),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      ),
      child: Text(
        isLogin ? 'Log In' : 'Sign Up',
        style: const TextStyle(
            color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
  );
}

// Widget reusableDropdown(String text, IconData icon, List<String> items,
//     String selectedValue, Function(String) onChanged) {
//   return DropdownButtonFormField<String>(
//     value: selectedValue,
//     onChanged:(String? value) {
//       cur = 
//     },
//     decoration: InputDecoration(
//       prefixIcon: Icon(
//         icon,
//         color: const Color.fromARGB(179, 16, 15, 15),
//       ),
//       labelText: text,
//       labelStyle: TextStyle(
//         color: const Color.fromARGB(255, 16, 16, 16).withOpacity(0.9),
//       ),
//       filled: true,
//       floatingLabelBehavior: FloatingLabelBehavior.never,
//       fillColor: const Color.fromARGB(255, 249, 247, 247).withOpacity(0.3),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(30.0),
//         borderSide: const BorderSide(width: 0, style: BorderStyle.none),
//       ),
//     ),
//     items: items.map((String value) {
//       return DropdownMenuItem<String>(
//         value: value,
//         child: Text(value),
//       );
//     }).toList(),
//   );
// }
