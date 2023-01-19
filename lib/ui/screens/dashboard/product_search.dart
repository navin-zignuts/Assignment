import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:first_app/ui/screens/dashboard/product_card.dart';
import 'package:first_app/ui/screens/dashboard/product_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart' as db;

class DataSearch extends SearchDelegate<String> {
  String wishid;
  String title;
  DataSearch(this.wishid, this.title);
  @override
  List<Widget>? buildActions(BuildContext context) {
    //actions for app bar
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    //leading icon on the left of the app bar
    return IconButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => Products(title: title, wishid: wishid)));
        },
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    //show some results based on the selection
    return FirebaseAnimatedList(
      query: getStream(query),
      itemBuilder: (context, snapshot, animation, index) {
        return ProductCard(wishid: wishid, snapshot: snapshot);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //show when someone searches for something
    return const Text('Search Products !!!');
  }

  db.Query getStream(String query) {
    var z = db.FirebaseDatabase.instance
        .ref("product")
        .orderByChild("pname")
        .equalTo(query);
    return z;
  }
}
