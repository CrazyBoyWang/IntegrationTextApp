import 'package:flutter/material.dart';

class ClipTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget avatar = Image.asset(
      "assets/images/logo.png",
      width: 50,
    );
    return Center(
      child: Column(
        children: <Widget>[
          avatar,
          ClipOval(child: avatar),
          ClipRRect(
            borderRadius:BorderRadius.circular(5.0),
            child: avatar,
          ),
          Row(

            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                widthFactor: .9,
                child: avatar,

              ),


              Text("what fuck",style: TextStyle(color: Colors.lightGreen),)

            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

            ],
          ),
        ],
      ),
    );
  }
  
}
