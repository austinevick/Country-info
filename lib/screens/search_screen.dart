import 'package:country_info/model/countries.dart';
import 'package:country_info/network/network_request.dart';
import 'package:flutter/material.dart';
import 'package:search_widget/search_widget.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Countries>>(
          future: NetworkRequest.getCountries(),
          builder: (context, snapshot) => snapshot.hasData
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: SearchWidget(
                        noItemsFoundWidget: Center(
                          child: Text('No item found'),
                        ),
                        dataList: snapshot.data,
                        popupListItemBuilder: (countries) {
                          return PopupListItem(
                            countries: countries,
                          );
                        },
                        selectedItemBuilder: (countries, selectedItem) {
                          return SelectedItemWidget(
                            countries: countries,
                            tapSelectedItem: selectedItem,
                          );
                        },
                        queryBuilder:
                            (String query, List<Countries> countries) {
                          return countries
                              .where((country) => country.name
                                  .toLowerCase()
                                  .contains(query.toLowerCase()))
                              .toList();
                        }),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                )),
    );
  }
}

class PopupListItem extends StatelessWidget {
  final Countries countries;

  const PopupListItem({Key key, this.countries}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Material(
        // elevation: 4.0,
        borderRadius: BorderRadius.circular(4.0),
        child: ListTile(
          subtitle: Text(
            countries.capital,
            style: TextStyle(fontSize: 16),
          ),
          leading: CircleAvatar(
            // backgroundColor: color,
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
      ),
    );
  }
}

class SelectedItemWidget extends StatelessWidget {
  final Countries countries;
  final VoidCallback tapSelectedItem;

  const SelectedItemWidget({Key key, this.countries, this.tapSelectedItem})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Material(
        // elevation: 4.0,
        borderRadius: BorderRadius.circular(4.0),
        child: ListTile(
          subtitle: Text(
            countries.capital,
            style: TextStyle(fontSize: 16),
          ),
          leading: CircleAvatar(
            // backgroundColor: color,
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
      ),
    );
  }
}
