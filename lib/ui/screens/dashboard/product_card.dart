import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:first_app/database_services/firebase_service.dart';
import 'package:first_app/resources/assets_manager.dart';
import 'package:first_app/resources/color_manager.dart';
import 'package:flutter/material.dart';

//ignore: must_be_immutable
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

  @override
  void initState() {
    getQuantity();

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
          height: 150,
          width: 100,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    height: 150,
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
                    //width: 85,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
                        color: ColorManager.discount),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                        '  10% Discount',
                        style: TextStyle(
                            color: ColorManager.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
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
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      //color: Colors.amber,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: 70, child: Image.asset(ImageAssets.Tesco)),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.snapshot.child('pname').value.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            '1 x kg',
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '500 g - ₹30',
                            style: const TextStyle(
                                fontSize: 13, color: Colors.black54),
                          ),
                          Text(
                            '₹${widget.snapshot.child('prize').value.toString()}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: ColorManager.Primarytheme),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            widget.snapshot.child('desc').value.toString(),
                            style: TextStyle(color: ColorManager.pr_desc),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Container(
                            height: 30,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: ColorManager.faButton),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (qty >= 1) {
                                          qty -= 1;

                                          total = (widget.snapshot
                                                  .child('prize')
                                                  .value as int) *
                                              qty;

                                          dbFirebase.createCart(
                                              qty,
                                              total,
                                              widget.wishid,
                                              widget.snapshot
                                                  .child('pid')
                                                  .value);

                                          dbFirebase
                                              .removegetWishlistTotalAndQuantity(
                                                  widget.wishid,
                                                  widget.snapshot
                                                      .child("prize")
                                                      .value);
                                        }
                                      });
                                    },
                                    child: Icon(
                                      Icons.remove_circle_outline,
                                      color: ColorManager.Primarytheme,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    '$qty',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    width: 15,
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

                                      dbFirebase.addgetWishlistTotalAndQuantity(
                                          widget.wishid,
                                          widget.snapshot.child("prize").value);
                                    },
                                    child: Icon(
                                      Icons.add_circle_outline,
                                      color: ColorManager.Primarytheme,
                                    ),
                                  )
                                ]),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
