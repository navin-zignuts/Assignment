import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:first_app/database_services/firebase_service.dart';
import 'package:first_app/resources/assets_manager.dart';
import 'package:first_app/resources/color_manager.dart';
import 'package:first_app/user_preferences/user_preferences.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProductCard extends StatefulWidget {
  String wishid;
  ProductCard({super.key, required this.snapshot, required this.wishid});
  DataSnapshot snapshot;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int qty = 0;
  int total = 0;
  getQuantity() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var quary = await firestore
        .collection("Cart")
        .where("pid", isEqualTo: widget.snapshot.child("pid").value)
        .where("wishid", isEqualTo: widget.wishid)
        .get();
    if (quary.size == 0) {
    } else {
      var cId = quary.docs.first.id;
      var x = await firestore
          .collection("Cart")
          .doc(cId)
          .get()
          .then((value) => value.get("quantity"));
      setState(() {
        qty = x;
      });
    }
  }

  void initState() {
    getQuantity();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      shadowColor: ColorManager.Primarytheme,
      child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          height: 100,
          width: 100,
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.,
            children: [
              Stack(
                children: [
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    height: 100,
                    width: 150,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          topLeft: Radius.circular(15)),
                      child: Image.network(
                        widget.snapshot.child('image').value.toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                      child: Container(
                    height: 15,
                    width: 85,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
                        color: ColorManager.discount),
                    child: Text(
                      '  10% Discount',
                      style: TextStyle(
                          color: ColorManager.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
                  Positioned(
                      bottom: 3,
                      right: 3,
                      child: Container(
                        width: 33,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: ColorManager.white),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 12,
                              color: ColorManager.Primarytheme,
                            ),
                            const Text('4.5',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 60,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Image.asset(ImageAssets.Tesco),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.snapshot.child('pname').value.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.snapshot.child('desc').value.toString(),
                      style: TextStyle(color: ColorManager.pr_desc),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 55,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8, top: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      '1 x kg',
                      style: TextStyle(fontSize: 13),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.currency_rupee,
                          size: 20,
                          color: ColorManager.Primarytheme,
                        ),
                        Text(
                          widget.snapshot.child('prize').value.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: ColorManager.Primarytheme),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 11),
                      child: Column(
                        children: [
                          Container(
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: ColorManager.faButton),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.remove_circle_outline,
                                    color: ColorManager.Primarytheme,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text('$qty'),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      setState(() {
                                        qty += 1;
                                        total = (widget.snapshot
                                                .child('prize')
                                                .value as int) *
                                            qty;
                                      });

                                      dbFirebase.createCart(
                                          qty,
                                          total,
                                          widget.wishid,
                                          widget.snapshot.child('pid').value);

                                      dbFirebase.createWishlistTotalAndQuantity(
                                          widget.wishid,
                                          widget.snapshot.child("prize").value);
                                      // FirebaseFirestore firestore =
                                      //     FirebaseFirestore.instance;

                                      // var query = await firestore
                                      //     .collection('Cart')
                                      //     .where('pid',
                                      //         isEqualTo: widget.snapshot
                                      //             .child('pid')
                                      //             .value)
                                      //     .where('wishid',
                                      //         isEqualTo: widget.wishid)
                                      //     .get();

                                      // if (query.size == 0) {
                                      //   FirebaseFirestore.instance
                                      //       .collection('Cart')
                                      //       .add({
                                      //     'uid':
                                      //         await UserPreferences.getUserId(),
                                      //     'pid': widget.snapshot
                                      //         .child('pid')
                                      //         .value,
                                      //     'quantity': qty,
                                      //     'total': total,
                                      //     'wishid': widget.wishid
                                      //   });
                                      // } else {
                                      //   var docid = query.docs.first.id;
                                      //   firestore
                                      //       .collection('Cart')
                                      //       .doc(docid)
                                      //       .update({
                                      //     'quantity': qty,
                                      //     'total': total
                                      //   });
                                      // }

                                      // var dbqty = await firestore
                                      //     .collection("Wishlist")
                                      //     .doc(widget.wishid)
                                      //     .get()
                                      //     .then(
                                      //         (value) => value.get("quantity"));

                                      // var dbTotal = await firestore
                                      //     .collection("Wishlist")
                                      //     .doc(widget.wishid)
                                      //     .get()
                                      //     .then((value) => value.get("total"));

                                      // await firestore
                                      //     .collection("Wishlist")
                                      //     .doc(widget.wishid)
                                      //     .update({
                                      //   "quantity": dbqty += 1,
                                      //   "total": dbTotal +=
                                      //       widget.snapshot.child("prize").value
                                      // });
                                    },
                                    child: Icon(
                                      Icons.add_circle_outline,
                                      color: ColorManager.Primarytheme,
                                    ),
                                  )
                                ]),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
