
import 'package:flutter/cupertino.dart';

class HeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 16, top: 40, right: 16),
        child: Row(
          children: <Widget>[
            Text("Food\nBasket",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 26)),
            Spacer(),
            Image.asset(
              'assets/images/basket.png',
              fit: BoxFit.fill,
              width: 200,
            )
          ],
        ));
  }
}