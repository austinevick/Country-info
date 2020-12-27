import 'package:country_info/model/countries.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class CountryDetailsSheet extends StatelessWidget {
  final Countries countries;

  const CountryDetailsSheet({Key key, this.countries}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.transparent,
      child: new Container(
          decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(10.0),
                  topRight: const Radius.circular(10.0))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  subtitle: Text(
                    countries.capital,
                    style: TextStyle(fontSize: 16),
                  ),
                  leading: CircleAvatar(
                    child: Text(
                      countries.name.substring(0, 1),
                      style: TextStyle(color: Colors.white, fontSize: 18.5),
                    ),
                  ),
                  title: Text(
                    countries.name,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Divider(),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: countries.currencies
                        .map((e) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Currency:',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(e.name),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Symbol:',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(e.symbol),
                                  ],
                                ),
                              ],
                            ))
                        .toList()),
                Divider(),
                Text(
                  'Population:',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(NumberFormat('#,###,###,###,###')
                    .format(countries.population)),
                Divider(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Language',
                      style: TextStyle(fontSize: 16),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: countries.languages
                            .map(
                              (e) => Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 0, right: 8, top: 6),
                                    child: Text(
                                      e.name,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList()),
                  ],
                ),
                Divider(),
                Text(
                  'Region:',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(countries.region),
                Divider(),
                Text(
                  'Subregion:',
                  style: TextStyle(fontSize: 16),
                ),
                Text(countries.region)
              ],
            ),
          )),
    );
  }
}
