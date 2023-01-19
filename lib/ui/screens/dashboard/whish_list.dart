import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/ui/screens/dashboard/dash_board_screen.dart';
import 'package:first_app/ui/screens/dashboard/product_list.dart';
import 'package:first_app/resources/color_manager.dart';
import 'package:first_app/utilites/common_utilities.dart';
import 'package:flutter/material.dart';

class WLists extends StatefulWidget {
  const WLists({super.key});

  @override
  State<WLists> createState() => _WListsState();
}

class _WListsState extends State<WLists> {
  //GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final String? userId = FirebaseAuth.instance.currentUser?.uid;
  var db = FirebaseFirestore.instance.collection('Wishlist').snapshots();

  final TextEditingController _listnames = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DashBoard()));
                },
                child: Icon(
                  Icons.arrow_back,
                  color: ColorManager.Primarytheme,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Your Shopping List',
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
      body: Center(
        child: Stack(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Wishlist")
                  .where("uid",
                      isEqualTo: FirebaseAuth.instance.currentUser?.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      QueryDocumentSnapshot<Object?> documentSnapshot =
                          snapshot.data!.docs.elementAt(index);

                      return Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Products(
                                          wishid: documentSnapshot.id,
                                          title:
                                              "${snapshot.data?.docs[index]['name']}",
                                        )));
                          },
                          child: Card(
                              elevation: 1.5,
                              // ignore: sized_box_for_whitespace
                              child: Container(
                                height: 100,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Text(
                                                snapshot.data?.docs[index]
                                                    ['name'],
                                                style: const TextStyle(
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 18),
                                              ),
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  var wishid =
                                                      documentSnapshot.id;
                                                  FirebaseFirestore.instance
                                                      .collection('Wishlist')
                                                      .doc(wishid)
                                                      .delete();
                                                },
                                                child: Icon(
                                                  Icons.delete,
                                                  color:
                                                      ColorManager.Primarytheme,
                                                  size: 25,
                                                ))
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 100,
                                        width: 120,
                                        decoration: BoxDecoration(
                                            color: ColorManager.faButton),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                'Qty: ${snapshot.data?.docs[index]['quantity'].toString() ?? ''}',
                                                style: TextStyle(
                                                    color: ColorManager.black,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Text(
                                                'Total: ₹${snapshot.data?.docs[index]['total'].toString() ?? ''}',
                                                style: TextStyle(
                                                    color: ColorManager
                                                        .Primarytheme,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ]),
                              )),
                        ),
                      );
                    });
              },
            ),

            //TextFormField to add List
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  decoration: BoxDecoration(
                      color: ColorManager.faButton,
                      borderRadius: BorderRadius.circular(30)),
                  child: TextFormField(
                      controller: _listnames,
                      textAlign: TextAlign.center,
                      decoration: CommonUtilities.getTextInputDecorWishlist(
                          _listnames, () {
                        // ignore: unnecessary_null_comparison
                        if (_listnames != null) {
                          Map<String, dynamic> data = {
                            "uid": userId,
                            "name": _listnames.text,
                            "quantity": 0,
                            "total": 0
                          };

                          CollectionReference collectionReference =
                              FirebaseFirestore.instance.collection('Wishlist');
                          collectionReference.add(data);
                        }
                      })),
                ),
              )
            ]),
          ],
        ),
      ),
    );
  }
}
