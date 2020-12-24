import 'package:country_info/model/countries.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

import 'home_screen.dart';

class CountryDetailsSheet extends StatelessWidget {
  final Countries countries;

  const CountryDetailsSheet({Key key, this.countries}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: MediaQuery.of(context).size.height / 1.5,
      color: Colors.transparent,
      child: new Container(
          decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(10.0),
                  topRight: const Radius.circular(10.0))),
          child: Column(
            children: [
              ListTile(
                subtitle: Text(
                  countries.capital,
                  style: TextStyle(fontSize: 16),
                ),
                leading: CircleAvatar(
                  //backgroundColor: color,
                  child: Text(
                    countries.name.substring(0, 1),
                    style: TextStyle(color: Colors.white, fontSize: 18.5),
                  ),
                ),
                title: Text(
                  countries.name,
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          )),
    );
  }
}
