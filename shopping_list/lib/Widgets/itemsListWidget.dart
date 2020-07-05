import 'dart:collection';

import 'package:basic_utils/basic_utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shoppinglist/Widgets/ItemWidget.dart';
import 'package:shoppinglist/Widgets/addItemWidget.dart';

import '../entities/Item.dart';
import 'headerWidget.dart';

class ItemsListWidget extends StatefulWidget {
  final String title;

  ItemsListWidget(this.title);

  @override
  State<StatefulWidget> createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsListWidget> {
  DatabaseReference _itemsRef =
      FirebaseDatabase.instance.reference().child('items');

  // Actions

  Future _showRemoveConfirmationDialog(String itemName) {
    // flutter defined function
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Delete"),
              content: Text("Are you sure you want to delete this item?"),
              actions: <Widget>[
                FlatButton(
                    child: Text("Remove",
                        style: TextStyle(color: Colors.red, fontSize: 18)),
                    onPressed: () {
                      _removeItem(itemName);
                      Navigator.of(context).pop();
                    }),
                FlatButton(
                    child: Text("Close",
                        style: TextStyle(color: Colors.grey, fontSize: 18)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ]);
        });
  }

  void _showAddItemDialog(String itemName) {
    var focusNode = FocusNode();
    FocusScope.of(context).requestFocus(FocusNode());
    focusNode.requestFocus();

    var _controller = TextEditingController();
    _controller.text = StringUtils.capitalize(itemName.toLowerCase());

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: TextField(
                  controller: _controller,
                  focusNode: focusNode,
                  onSubmitted: (newItemName) {
                    if (newItemName.trim().isEmpty) {
                      Navigator.of(context).pop();
                      return;
                    }
                    _editItem(itemName.trim(), newItemName);
                    Navigator.of(context).pop();
                  }));
        });
  }

  void _removeItem(String itemName) {
    _itemsRef.child(itemName).remove();
  }

  void _addItem(String itemName) {
    _itemsRef.child(itemName.trim().toLowerCase()).set(true);
  }

  void _editItem(String itemName, String newItemName) {
    _removeItem(itemName);
    _addItem(newItemName);
  }

  // Widgets

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(children: <Widget>[HeaderWidget(), _body()]));
  }

  Widget _body() {
    return Flexible(
        child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0))),
            child: Column(
                children: <Widget>[AddItemWidget(onAdd: _addItem), _streamList()])));
  }

  Widget _streamList() {
    return Flexible(
        child: StreamBuilder<List<Item>>(
      stream: _itemsRef.onValue
          .map((event) =>
              event.snapshot.value != null ? event.snapshot.value : Map())
          .map((value) => value as LinkedHashMap)
          .map((itemsMap) => itemsMap.keys.toList())
          .map((itemNames) => itemNames.map((name) => Item(name)).toList()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("");
        } else {
          List<Item> items = snapshot.data;
          return _listView(items);
        }
      },
    ));
  }

  Widget _listView(List<Item> items) {
    return ListView.builder(
      itemCount: items.length != null ? items.length : 0,
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key(items[index].name),
          child: ItemWidget(
              item: items[index],
              onTap: (() => _showAddItemDialog(items[index].name))),
          background: Container(
            color: Colors.red,
            padding: EdgeInsets.symmetric(horizontal: 20),
            alignment: AlignmentDirectional.centerEnd,
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          direction: DismissDirection.endToStart,
          confirmDismiss: (direction) {
            return _showRemoveConfirmationDialog(items[index].name);
          },
        );
      },
    );
  }
}
