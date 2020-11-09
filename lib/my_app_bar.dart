import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  MyAppBar({this.title});
  final Widget title;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.blue[500]
      ),
      child: Column(
        children: [
          Container(
            height: 12,
          ),
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.menu),
                tooltip: 'Navigation Menu',
                onPressed: null,
              ),
              Expanded(
                child: title,
              ),
              IconButton(
                icon: Icon(Icons.search),
                tooltip: 'search',
                onPressed: null,
              )
            ],
          ),
        ],
      ),
    );
  }

}