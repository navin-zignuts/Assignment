import 'package:firebase_database/firebase_database.dart';
import 'package:first_app/resources/assets_manager.dart';
import 'package:first_app/resources/color_manager.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProductCard extends StatefulWidget {
  ProductCard({super.key, required this.snapshot});
  DataSnapshot snapshot;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
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
                    width: 80,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
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
                                  Text(widget.snapshot
                                      .child('quantity')
                                      .value
                                      .toString()),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.add_circle_outline,
                                    color: ColorManager.Primarytheme,
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
