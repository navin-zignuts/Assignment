// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:first_app/resources/color_manager.dart';
import 'package:flutter/material.dart';

class CommonUtilities {
  //Input Text Form Field
  static getTextInputDecor(String labelText, IconData iconData,
      {Color colorBorder = Colors.black, Color colorIcon = Colors.black}) {
    return InputDecoration(
        focusedErrorBorder:
            OutlineInputBorder(borderSide: BorderSide(color: colorBorder)),
        errorBorder:
            OutlineInputBorder(borderSide: BorderSide(color: colorBorder)),
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: colorBorder)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: colorBorder)),
        labelText: labelText,
        labelStyle: TextStyle(color: colorBorder),
        prefixIcon: Icon(
          iconData,
          color: colorIcon,
        ));
  }

  //Input TextFormField for Password
  static getTextInputDecorPass(
      String labelText, IconData iconData, Function onLockedClick,
      {Color colorBorder = Colors.black,
      Color colorIcon = Colors.black,
      bool isLocked = true}) {
    return InputDecoration(
        focusedErrorBorder:
            OutlineInputBorder(borderSide: BorderSide(color: colorBorder)),
        errorBorder:
            OutlineInputBorder(borderSide: BorderSide(color: colorBorder)),
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: colorBorder)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: colorBorder)),
        labelText: labelText,
        labelStyle: TextStyle(color: ColorManager.Primarytheme),
        prefixIcon: Icon(
          iconData,
          color: colorIcon,
        ),
        suffixIcon: InkWell(
            onTap: () {
              onLockedClick();
            },
            child: Icon(
              isLocked ? Icons.visibility_off : Icons.visibility,
              color: colorIcon,
            )));
  }

  static getTextInputDecorWishlist(_listnames, Function() addData) {
    return InputDecoration(
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(width: 2, color: ColorManager.Primarytheme)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(width: 2, color: ColorManager.Primarytheme)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(width: 2, color: ColorManager.Primarytheme)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(width: 2, color: ColorManager.Primarytheme)),
        hintText: "New List",
        hintStyle: TextStyle(
            fontWeight: FontWeight.bold, color: ColorManager.Primarytheme),
        suffixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              decoration: BoxDecoration(
                  color: ColorManager.Primarytheme,
                  borderRadius: BorderRadius.circular(30)),
              child: InkWell(
                onTap: () {
                  _listnames.text.isEmpty ? null : addData();

                  _listnames.clear();
                },
                child: Icon(
                  Icons.add,
                  color: ColorManager.faButton,
                ),
              )),
        ));
  }
}
