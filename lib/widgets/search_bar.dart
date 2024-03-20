import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List<String> searchList = [
    "Apple",
    "Banana",
    "Cherry",
    "Date",
    "Fig",
    "Grapes",
    "Kiwi",
    "Lemon",
    "Mango",
    "Orange",
    "Papaya",
    "Raspberry",
    "Strawberry",
    "Tomato",
    "Watermelon",
  ];
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => Navigator.of(context).pop(),
      // Exit from the search screen.
    );
  }

  @override
  Widget buildResults(BuildContext context) {

    final List<String> searchResults = searchList
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        
        return ListTile(
          title: Text(searchResults[index]),
          onTap: () {
            // Handle the selected search result.
            close(context, searchResults[index]);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    final List<String> suggestionList = query.isEmpty
      ? []
      : searchList
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();

  return ListView.builder(
    itemCount: suggestionList.length,
    itemBuilder: (context, index) {
      return ListTile(
        title: Text(suggestionList[index]),
        onTap: () {
          print("i chose you");
          query = suggestionList[index];
          close(context, suggestionList[index]);
          // Show the search results based on the selected suggestion.
        },
      );
    },
    );
  }
  
  @override
  ThemeData appBarTheme(BuildContext context){
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    return theme.copyWith(
      
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: Colors.black,
          fontSize: 20
      ),
      titleMedium: TextStyle(
        color: Colors.black,
        fontSize: 15
      ),
      titleSmall: TextStyle(
        color: Colors.black,
        fontSize: 13
      ),
      bodyLarge: TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
      bodySmall: TextStyle(
        color: Colors.black,
        fontSize: 15
      ),
      bodyMedium: TextStyle(
        color: Colors.black,
        fontSize: 14
      ),
      labelLarge: TextStyle(
        color: Colors.black,
        fontSize: 20
      ),
      labelMedium: TextStyle(
        color: Colors.black,
        fontSize: 15
      ),
      labelSmall: TextStyle(
        color: Colors.black,
        fontSize: 13
      )

      )
    );
  }
}
