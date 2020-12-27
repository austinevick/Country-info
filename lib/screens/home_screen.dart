import 'dart:async';
import 'dart:math';

import 'package:country_info/connectivity/network_connectivity.dart';
import 'package:country_info/provider/country_list_provider.dart';
import 'package:country_info/screens/bottom_sheet.dart';
import 'package:country_info/screens/search_screen.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Random random = Random();
  final controller = ScrollController();
  static StreamSubscription<DataConnectionStatus> subscription;
  bool isVisible = false;

  @override
  void initState() {
    NetworkConnectivityService.checkConnection(
      context,
      subscription,
    );
    Provider.of<CountryListProvider>(context, listen: false)
        .fetchListOfCountries();
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CountryListProvider>(
      builder: (context, provider, child) => Scaffold(
        appBar: ScrollAppBar(
          backgroundColor: Colors.red,
          actions: [
            !isVisible
                ? FlatButton(
                    child: Text('Search',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    onPressed: () => setState(() => isVisible = true))
                : FlatButton(
                    child: Text('Cancel',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    onPressed: () => setState(() => isVisible = false)),
          ],
          controller: controller,
          title: Text('Countries and their capital'),
        ),
        body: isVisible
            ? SearchScreen()
            : provider.countriesList.isEmpty
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    controller: controller,
                    itemCount: provider.countriesList.length,
                    itemBuilder: (context, index) {
                      final countries = provider.countriesList[index];
                      final color = Colors
                          .primaries[random.nextInt(Colors.primaries.length)];
                      return Container(
                          padding: EdgeInsets.all(4.0),
                          child: Material(
                            elevation: 2.0,
                            borderRadius: BorderRadius.circular(4.0),
                            child: ListTile(
                              trailing: IconButton(
                                  icon: Icon(Icons.arrow_forward_ios),
                                  onPressed: () {}),
                              onTap: () => showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (ctx) => CountryDetailsSheet(
                                        countries: countries,
                                      )),
                              subtitle: Text(
                                countries.capital,
                                style: TextStyle(fontSize: 15),
                              ),
                              leading: CircleAvatar(
                                backgroundColor: color,
                                child: Text(
                                  countries.name.substring(0, 1),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18.5),
                                ),
                              ),
                              title: Text(
                                countries.name,
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ));
                    }),
      ),
    );
  }
}
