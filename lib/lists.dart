import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/resources/color_manager.dart';
import 'package:first_app/resources/fonts_manager.dart';
import 'package:flutter/material.dart';

class WLists extends StatefulWidget {
  @override
  State<WLists> createState() => _WListsState();
}

class _WListsState extends State<WLists> {
  var db = FirebaseFirestore.instance.collection('Lists').snapshots();

  final TextEditingController _listnames = TextEditingController();
  List<String> litems = [];

  //to add data in firebase
  addData() {
    Map<String, dynamic> data = {'name': _listnames.text};
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('Lists');
    collectionReference.add(data);
  }

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
              Icon(
                Icons.arrow_back,
                color: ColorManager.Primarytheme,
              ),
              SizedBox(
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
      body: Center(
        child: Stack(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: db,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Card(
                            elevation: 1.5,
                            child: Container(
                              height: 100,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        snapshot.data?.docs[index]['name'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color: ColorManager.faButton),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text('Quantity - 0'),
                                            Text('Total - Rs 0')
                                          ],
                                        ),
                                      ),
                                    )
                                  ]),
                            )),
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
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                width: 2, color: ColorManager.Primarytheme)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                width: 2, color: ColorManager.Primarytheme)),
                        hintText: "New List",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorManager.Primarytheme),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: ColorManager.Primarytheme,
                                  borderRadius: BorderRadius.circular(30)),
                              child: InkWell(
                                onTap: () {
                                  addData();
                                },
                                child: Icon(
                                  Icons.add,
                                  color: ColorManager.faButton,
                                ),
                              )),
                        )),
                  ),
                ),
              )
            ]),
          ],
        ),
      ),
    );
  }
}
