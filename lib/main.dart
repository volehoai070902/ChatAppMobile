import 'dart:async';

import 'package:chatapp/config/theme.dart';
import 'package:chatapp/feature/authentication/models/auth_result.dart';
import 'package:chatapp/feature/authentication/view_models/notifiers/auth_change_notifier.dart';
import 'package:chatapp/feature/authentication/views/intro_page.dart';
import 'package:chatapp/feature/chat/view_model/notifier/chat_notifier.dart';
import 'package:chatapp/feature/listfriend/views/list_friend.dart';
import 'package:chatapp/test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{
  await Supabase.initialize(
    url: 'https://unoazldgvjylccxiznha.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVub2F6bGRndmp5bGNjeGl6bmhhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTA4MzI1NzksImV4cCI6MjAyNjQwODU3OX0.NB8klHg1FA7-WO1pwCnyKhs0DcKIpVd14TKRtFOgih8',
    authOptions: const FlutterAuthClientOptions(
      authFlowType: AuthFlowType.pkce,)
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthChangeNotifier(),),
      ChangeNotifierProvider(create: (context) => ChatNotifier(),)
    ],
    child: const MyApp()));
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
      home: Consumer<AuthChangeNotifier>(
        builder: (context, value, child) {
          final isLogged = value.authState.result == AuthResult.success;
          if (isLogged){
            return ListFriendPage();
          } else{
            return MainPage();
          }
        }),
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