import 'dart:math';

import 'package:country_info/model/countries.dart';
import 'package:country_info/network/network_request.dart';
import 'package:country_info/screens/bottom_sheet.dart';
import 'package:country_info/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Random random = Random();
  final controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScrollAppBar(
        actions: [
          IconButton(
              icon: Icon(
                Icons.search,
                size: 30,
              ),
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => SearchScreen())))
        ],
        controller: controller,
        title: Text('List of Countries'),
      ),
      body: FutureBuilder<List<Countries>>(
          future: NetworkRequest.getCountries(),
          builder: (ctx, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                controller: controller,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  final countries = snapshot.data[index];
                  final color =
                      Colors.primaries[random.nextInt(Colors.primaries.length)];
                  return Container(
                    padding: EdgeInsets.all(8.0),
                    child: Material(
                      elevation: 4.0,
                      borderRadius: BorderRadius.circular(4.0),
                      child: ListTile(
                        onTap: () => showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (ctx) => CountryDetailsSheet(
                                  countries: countries,
                                )),
                        subtitle: Text(
                          countries.capital,
                          style: TextStyle(fontSize: 16),
                        ),
                        leading: CircleAvatar(
                          backgroundColor: color,
                          child: Text(
                            countries.name.substring(0, 1),
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.5),
                          ),
                        ),
                        title: Text(
                          countries.name,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
