import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:first_app/ui/screens/dashboard/product_card.dart';
import 'package:first_app/resources/assets_manager.dart';
import 'package:first_app/resources/color_manager.dart';
import 'package:flutter/material.dart';

class Products extends StatefulWidget {
  final String title;
  String wishid;

  Products({super.key, required this.title, required this.wishid});
  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final refDatabase = FirebaseDatabase.instance.ref('product');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: ColorManager.Primarytheme),
          backgroundColor: ColorManager.white,
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                      color: ColorManager.Primarytheme,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.search,
                  color: ColorManager.Primarytheme,
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
          ]),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                    child: FirebaseAnimatedList(
                  query: refDatabase,
                  itemBuilder: (contect, snapshot, animation, index) {
                    return ProductCard(
                        wishid: widget.wishid, snapshot: snapshot);
                  },
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
                                    ),
                                  ),
                                  StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection("Wishlist")
                                        .doc(widget.wishid)
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        var data = snapshot.data?.get("total");
                                        return Text(data.toString(),
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold));
                                      } else {
                                        return Text("0",
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
}
