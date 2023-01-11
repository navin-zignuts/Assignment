import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:first_app/resources/assets_manager.dart';
import 'package:first_app/resources/color_manager.dart';
import 'package:flutter/material.dart';

class Products extends StatefulWidget {
  final String title;

  const Products({super.key, required this.title});
  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final refDatabase = FirebaseDatabase.instance.ref('product');

  @override
  Widget build(BuildContext context) {
    //final ref = refDatabase.reference();
    return Scaffold(
        appBar: AppBar(
          //automaticallyImplyLeading: false,
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
                SizedBox(
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
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      elevation: 3,
                      shadowColor: ColorManager.Primarytheme,
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          height: 100,
                          width: 100,
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    height: 100,
                                    width: 150,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(15),
                                          topLeft: Radius.circular(15)),
                                      child: Image.network(
                                        snapshot
                                            .child('image')
                                            .value
                                            .toString(),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      child: Container(
                                    height: 15,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(25)),
                                        color: ColorManager.discount),
                                    child: Text(
                                      '10% Discount',
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
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: ColorManager.white),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              size: 12,
                                              color: ColorManager.Primarytheme,
                                            ),
                                            Text('4.5',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold)),
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
                                    Container(
                                        width: 60,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8),
                                          child: Image.asset(ImageAssets.Tesco),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      snapshot.child('pname').value.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      snapshot.child('desc').value.toString(),
                                      style: TextStyle(
                                          color: ColorManager.pr_desc),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 55,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 8, top: 8),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
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
                                          snapshot
                                              .child('prize')
                                              .value
                                              .toString(),
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
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: ColorManager.faButton),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Icon(
                                                    Icons.remove_circle_outline,
                                                    color: ColorManager
                                                        .Primarytheme,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(snapshot
                                                      .child('quantity')
                                                      .value
                                                      .toString()),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Icon(
                                                    Icons.add_circle_outline,
                                                    color: ColorManager
                                                        .Primarytheme,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Totals 780',
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                  Text('₹330',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: ColorManager.Primarytheme))
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
