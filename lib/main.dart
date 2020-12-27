import 'package:country_info/provider/country_list_provider.dart';
import 'package:country_info/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

import 'model/countries.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CountryListProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Future<List<Countries>> fetch() async {
    final url = 'https://restcountries.eu/rest/v2/all';
    List<Countries> countries = [];
    final response = await get(url);
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      List<dynamic> countryList = result;
      print(countryList);
      countryList
          .forEach((element) => countries.add(Countries.fromMap(element)));
      return countries;
    }
    throw Exception('Unable to fetch data');
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<Countries>>(
        future: fetch(),
        builder: (context, snapshot) => ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (ctx, i) => Center(
              child: ListTile(
                  title: Column(
                      children: snapshot.data[i].coordinate
                          .map((e) => Text(e.toString()))
                          .toList()),
                  subtitle: Column(
                    children: snapshot.data[i].languages
                        .map((e) => Text(e.name))
                        .toList(),
                  ),
                  leading: SvgPicture.network(
                      "https://restcountries.eu/data/col.svg"))),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetch,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
