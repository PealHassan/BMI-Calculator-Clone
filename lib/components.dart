import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class components {
  static customTextField(TextEditingController controller,String text,  double width) {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      padding: EdgeInsets.only(left: 20,top: 20),
      width: width,
      child: TextField(    
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: text,
            alignLabelWithHint: true,
            labelStyle: TextStyle(
              fontSize: 15,
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(width: 2),
            ),
          ),
        ),
    
    );
  }
} 