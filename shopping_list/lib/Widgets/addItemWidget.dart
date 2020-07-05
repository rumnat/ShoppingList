import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddItemWidget extends StatelessWidget {
  final TextEditingController _controller = new TextEditingController();
  final Function(String) onAdd;

  AddItemWidget({this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 24, left: 16, right: 16),
        child: TextField(
            style: TextStyle(color: Color.fromRGBO(74, 74, 74, 1.0)),
            controller: _controller,
            onSubmitted: (itemName) {
              if (itemName.trim().isEmpty) return;
              onAdd(itemName.trim());
              _controller.clear();
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(16),
              hintText: 'Add item...',
              hintStyle: TextStyle(
                color: Color.fromRGBO(235, 227, 223, 1.0),
                fontWeight: FontWeight.w600,
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromRGBO(235, 227, 223, 1.0), width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromRGBO(235, 227, 223, 1.0), width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromRGBO(235, 227, 223, 1.0), width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromRGBO(235, 227, 223, 1.0), width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(25))),
            )));
  }
}
