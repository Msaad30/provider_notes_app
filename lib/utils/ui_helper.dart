import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UiHelper{

  static customTextFeild(
    VoidCallback suffCallback, {
    required TextEditingController controller,
    required String hintText,
    required IconData suffIcon,
  }){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            suffixIcon: InkWell(
                onTap: suffCallback,
                child: Icon(suffIcon)
            ),
            hintText: hintText,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20)
            )
        ),
      ),
    );
  }

}