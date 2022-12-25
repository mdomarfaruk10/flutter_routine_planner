import 'package:flutter/material.dart';

class MyInputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  const MyInputField({Key? key,
    required this.title,
    required this.hint,
    this.controller,
     this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black
            ),
          ),
          Container(
            height: 52,
            width: 300,
            margin: EdgeInsets.only(top: 8.0,),
            padding: EdgeInsets.only(left: 14),
            decoration: BoxDecoration(
              color: Colors.grey,
              border: Border.all(
                width: 1.0,
              ),
              borderRadius:BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: widget==null?false:true,
                    autofocus: false,
                    controller: controller,
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 17,
                        color: Colors.white
                    ),
                    decoration: InputDecoration(
                        hintText: hint,
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 17,
                            color: Colors.white
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 0,
                            )
                        )
                    ),
                  ),
                ),
                widget==null?Container():Container(child: widget,)
              ],
            ),
          ),

        ],
      ),
    );
  }
}
