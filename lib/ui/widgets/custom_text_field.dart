import 'package:flutter/material.dart';
import 'package:xyz_store/common/app_colors.dart';

class CustomTextFormWidget extends StatelessWidget {
  CustomTextFormWidget(
      {Key? key,
      required this.textController,
      required this.textString,
      required this.functionValidator})
      : super(key: key);

  final TextEditingController textController;
  String textString;
  String Function(String?)? functionValidator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
      validator: functionValidator!,
      cursorColor: GlobalColors().primaryRed,
      controller: textController,
      decoration: InputDecoration(
        labelStyle: TextStyle(color: GlobalColors().textFieldColor),
        enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: GlobalColors().primaryRed, width: 1)),
        focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: GlobalColors().primaryRed, width: 2)),
        labelText: textString,
      ),
    );
  }
}
