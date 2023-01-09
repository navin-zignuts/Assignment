import 'package:first_app/resources/color_manager.dart';
import 'package:flutter/material.dart';

class WLists extends StatefulWidget {
  @override
  State<WLists> createState() => _WListsState();
}

class _WListsState extends State<WLists> {
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
                Icons.qr_code,
                color: ColorManager.Primarytheme,
              )
            ],
          ),
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: ColorManager.faButton,
        foregroundColor: ColorManager.Primarytheme,
        label: Padding(
          padding: const EdgeInsets.all(120.0),
          child: Row(
            children: [Text('New List'), Icon(Icons.add)],
          ),
        ),
      ),
      //body: ,
    );
  }
}
