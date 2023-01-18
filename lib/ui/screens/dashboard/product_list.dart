import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart' as db;
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:first_app/ui/screens/dashboard/product_card.dart';
import 'package:first_app/resources/assets_manager.dart';
import 'package:first_app/resources/color_manager.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Products extends StatefulWidget {
  final String title;
  String wishid;

  Products({super.key, required this.title, required this.wishid});
  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final refDatabase = db.FirebaseDatabase.instance.ref('product');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: FirebaseAnimatedList(
                    query: refDatabase,
                    itemBuilder: (context, snapshot, animation, index) {
                      return ProductCard(
                          wishid: widget.wishid, snapshot: snapshot);
                    },
                  ),
                )),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                        color: ColorManager.Primarytheme,
                        borderRadius: BorderRadius.circular(30)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.assignment,
                          color: ColorManager.white,
                        ),
                        Container(
                          width: 130,
                          height: 38.5,
                          decoration: BoxDecoration(
                              color: ColorManager.white,
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(ImageAssets.Cart),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Totals',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection("Wishlist")
                                        .doc(widget.wishid)
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        var data = snapshot.data?.get("total");
                                        return Text('₹ ${data.toString()}',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    ColorManager.Primarytheme));
                                      } else {
                                        return const Text("0",
                                            style: TextStyle(
                                              fontSize: 10,
                                            ));
                                      }
                                    },
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Text(
                          'Buy the list',
                          style: TextStyle(
                              color: ColorManager.white,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ));
  }

  AppBar buildAppBar() {
    return AppBar(
        iconTheme: IconThemeData(color: ColorManager.Primarytheme),
        backgroundColor: ColorManager.white,
        title: Text(
          widget.title,
          style: TextStyle(
              color: ColorManager.Primarytheme, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    showSearch(
                        context: context,
                        delegate: DataSearch(widget.wishid, widget.title));
                  },
                  child: Icon(
                    Icons.search,
                    color: ColorManager.Primarytheme,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.qr_code_scanner,
                  color: ColorManager.Primarytheme,
                )
              ],
            ),
          ),
        ]);
  }
}

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
