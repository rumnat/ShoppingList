import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppinglist/entities/Item.dart';

class ItemWidget extends StatelessWidget {
  final Item item;
  final Function onTap;

  ItemWidget({this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromRGBO(240, 240, 240, 1),
            borderRadius: BorderRadius.circular(8.0)),
        child: ListTile(
          title: Text(StringUtils.capitalize(item.name.toLowerCase()),
              style: TextStyle(
                  fontSize: 18,
                  color: Color.fromRGBO(74, 74, 74, 1),
                  fontWeight: FontWeight.w700)),
          onTap: onTap,
        ),
      ),
    );
  }
}
