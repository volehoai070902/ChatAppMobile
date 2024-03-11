import 'dart:async';

import 'package:chatapp/config/theme.dart';
import 'package:chatapp/feature/authentication/views/intro_page.dart';
import 'package:chatapp/test.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightTheme(),
      home: MainPage(),
    );
  }
}



// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final emailController = TextEditingController();
//   final passController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.amber,
//       ),
//       body: Container(
//         child: Center(
//           child: Column(
//             children: [
//               TextField(
//                 decoration: const InputDecoration(
//                     icon: Icon(Icons.email),
//                     hintText: "input email here",
//                     labelText: "Email",
//                     border: InputBorder.none),
//                 controller: emailController,
//               ),
//               TextField(
//                 controller: passController,
//                 decoration: const InputDecoration(
//                     icon: Icon(Icons.password),
//                     hintText: "input password here",
//                     labelText: "Password",
//                     border: InputBorder.none),
//               ),
//               CustomeBtn(
//                 emailController: emailController,
//                 passController: passController,
//               )
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {},
//       ),
//     );
//   }
// }

// class CustomeBtn extends StatelessWidget {
//   CustomeBtn(
//       {super.key, required this.emailController, required this.passController});

//   TextEditingController emailController;
//   TextEditingController passController;
//   StreamController<bool> btnStreamController = StreamController();

//   @override
//   Widget build(BuildContext context) {
//     emailController.addListener(() {
//       if (emailController.text != "" && passController.text != "") {
//         btnStreamController.add(true);
//       } else {
//         btnStreamController.add(false);
//       }
//     });

//     passController.addListener(() {
//       if (emailController.text != "" && passController.text != "") {
//         btnStreamController.add(true);
//       } else {
//         btnStreamController.add(false);
//       }
//     });

//     return StreamBuilder(
//       stream: btnStreamController.stream,
//       builder: (context, snapshot) {
//         bool check = snapshot.data ?? false;
//         return ElevatedButton(
//             onPressed: check ? () {} : null, child: Text("LOGIN"));
//       },
//     );
//   }
// }