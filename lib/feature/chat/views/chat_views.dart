import 'package:flutter/material.dart';

// final listMessage = [
//   {
//     "id":123,
//     "message": 331
//   },
//   {
//     "id":123,
//     "message": 332
//   },
//   {
//     "id":123,
//     "message": 333
//   },
//   {
//     "id":123,
//     "message": 334
//   }
// ];

final listMessage = [
  {"id": 331, "home": 123, "away": 234, "message": "chao ban"},
  {"id": 332, "home": 234, "away": 123, "message": "chao ban"},
  {"id": 333, "home": 123, "away": 234, "message": "ban khoe khong"},
  {
    "id": 334,
    "home": 234,
    "away": 123,
    "message": "toi khoe! cam on sssssssssssssssssssssssssssssssssssssssssss"
  },
  {"id": 333, "home": 123, "away": 234, "message": "ban khoe khong"},
  {"id": 333, "home": 123, "away": 234, "message": "ban khoe khong"},
  {"id": 333, "home": 123, "away": 234, "message": "ban khoe khong"},
  {"id": 333, "home": 123, "away": 234, "message": "ban khoe khong"},
];

class ChatPage extends StatelessWidget {
  Widget build(BuildContext context) {
    print("Hello Rebuild");
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(35))),
          child: Column(
            children: [
              Container(
                height: 80,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: const BoxDecoration(color: Colors.white),
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Color(0xFF584CD7),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(35))),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration:
                            const BoxDecoration(color: Color(0xFF584CD7)),
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(35))),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Color(0xFF584CD7),
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(35)),
                  ),
                  child: ListView.builder(
                    reverse: true,
                    itemCount: listMessage.length,
                    itemBuilder: (context, index) {
                      int my_id = 123;
                      int friend_id = 234;

                      return Align(
                        alignment: (listMessage[index]["home"] == my_id)
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: constraints.maxWidth * 0.66,
                          ),
                          padding: const EdgeInsets.all(10.0),
                          margin: const EdgeInsets.symmetric(vertical: 5.0),
                          decoration: BoxDecoration(
                            color: (listMessage[index]["home"] == my_id)
                                ? Colors.white
                                : Color.fromARGB(255, 123, 112, 240),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Text(
                            "${listMessage[index]["message"]}",
                            style: (listMessage[index]["home"] == my_id)
                                ? Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: Color(0xFF584cd7))
                                : Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              buildMessageInputBox()
            ],
          ),
        ),
      ),
    );
  }
}

class buildMessageInputBox extends StatelessWidget {
  const buildMessageInputBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(color: Color(0xFF584CD7)),
      child: Row(
        children: [
          Expanded(
              flex: 8,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white),
                child: TextField(
                  
                  style: TextStyle(color: Colors.black, fontSize: 15),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    hintText: "Message",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none),
                  ),
                ),
              )),
          Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white),
                child: ElevatedButton(
                  
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    backgroundColor: Colors.white,
                    elevation: 0
                  ),
                  onPressed: (){},
                  child: Icon(Icons.send),
                ),
              ))
        ],
      ),
    );
  }
}
