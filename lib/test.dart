// import 'dart:async';

// import 'package:chatapp/feature/listfriend/constants/categorys.dart';
// import 'package:chatapp/feature/listfriend/views/list_friend.dart';
// import 'package:chatapp/widgets/search_bar.dart';
// import 'package:flutter/material.dart';

// class ListFriendPageTest extends StatelessWidget {
//   StreamController listFriendController = StreamController();
//   List<Widget> categoryList = [];
//   List<Widget> _widgetOptions = <Widget>[
//       ListFriend(),
//   ];
//   int _selectedIndex = 0;


//   List<Widget> getListCategory(){
//     for(int i = 0; i < 1; i++){
//       Color backgroundColorButton;
//       if ( i == _selectedIndex){
//         backgroundColorButton = Color(0xFF584CD7);
//       }else{
//         backgroundColorButton = Colors.grey.shade100;
//       }

//       categoryList.add(
//         CustomeCategory(
//           listFriendController: listFriendController,
//           backgroundColorButton: backgroundColorButton,
//           title: categoryMainPage[i],
//           index: i,
//           textColor: _selectedIndex == i ? Colors.black : Colors.white,
//         )
//       );
//     }
//     return categoryList;
//   }
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     print("EEE");
//     for(int i = 0; i < 3; i++){
//       Color backgroundColorButton;
//       if ( i == _selectedIndex){
//         backgroundColorButton = Color(0xFF584CD7);
//       }else{
//         backgroundColorButton = Colors.grey.shade100;
//       }

//       categoryList.add(
//         CustomeCategory(
//           listFriendController: listFriendController,
//         backgroundColorButton: backgroundColorButton, 
//         title: categoryMainPage[i], 
//         index: i,
//         textColor: _selectedIndex == i ? Colors.black : Colors.white,
//         onTap: () {
          
//         },
//         )
//       );
//     }
   
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         actions: [
//           IconButton(onPressed: () async{
//             final rs =await showSearch(context: context, delegate: CustomSearchDelegate());
//             print(rs);
//           }, icon: Icon(Icons.search)),
//           IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
//         ],
//         backgroundColor: Colors.transparent,
//         scrolledUnderElevation: 0,
//         title: ListTile(
//           title: Text(
//             "Hello,",
//             style: Theme.of(context)
//                 .textTheme
//                 .titleSmall
//                 ?.copyWith(color: Colors.grey.shade300),
//           ),
//           subtitle: Text(
//             "Le Hoai",
//             style: Theme.of(context)
//                 .textTheme
//                 .titleLarge
//                 ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
//           ),
//         ),
//       ),
//       body: Container(
//         child: Center(child: Text("text")),
//       )
//     );
//   }
// }

// class CustomeCategory extends StatelessWidget {
//   CustomeCategory({
//     super.key,
//     required this.backgroundColorButton,
//     required this.title,
//     this.textColor,
//     required this.index,
//     this.onTap,
//     required this.listFriendController
//   });
//   StreamController listFriendController;
//   Color backgroundColorButton;
//   Color? textColor;
//   String title;
//   int index;
//   Function()? onTap;

//    Widget build(BuildContext context) {
//     return Expanded(
//       child: Container(
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(50),
//           color: backgroundColorButton,
//         ),
//         child: GestureDetector(
//           onTap: () {
            
//           },
//           child: Text(
//             title,
//             style: Theme.of(context)
//                 .textTheme
//                 .bodyMedium
//                 ?.copyWith(
//                   color: textColor ,
//                   fontWeight: FontWeight.bold),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';

import 'package:chatapp/feature/authentication/view_models/notifiers/auth_change_notifier.dart';
import 'package:chatapp/feature/chat/view_model/notifier/chat_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Counter extends ChangeNotifier {
  Counter() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      _count++;
      notifyListeners();
    });
  }
  int _count = 42;
  int get count => _count;
}

class TroiOiPage extends StatelessWidget {
  const TroiOiPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            ElevatedButton(onPressed: (){
              context.read<AuthChangeNotifier>().Test();
            }, child: Text("CLICK")),
            Consumer<ChatNotifier>(builder: (context, value, child) {
              
              return Container();
            },)
          ],
        ),
    ));
  }
}
