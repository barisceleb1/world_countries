import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:world_countries/favorites.dart';
import 'package:world_countries/joint_list.dart';
import 'package:world_countries/country.dart';
import 'package:http/http.dart' as http;


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String _apiConnection = "https://restcountries.com/v2/all?fields="
      "alpha2Code,name,capital,region,population,flag,languages";

  List<Country> _allCountries = [];

  List<String> _favoriteCountryCodes = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pullFavoritesFromDeviceMemory().then((_) {
        _pullCountriesOnline();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text("ÜLKELER",style: TextStyle(fontSize: 22),),
      centerTitle: true,
      backgroundColor: Colors.green,
      actions: [
        IconButton(
          icon: Icon(Icons.favorite),
          onPressed: () {
            _openFavoritesPage(context);
          },
        ),
      ],
    );
  }

  Widget _buildBody() {
    return _allCountries.length == 0
        ? Center(child: CircularProgressIndicator())
        : JointList(_allCountries, _favoriteCountryCodes);
  }

  void _openFavoritesPage(BuildContext context) {
    MaterialPageRoute pagePath = MaterialPageRoute(
      builder: (BuildContext context) {
        return Favorites(_allCountries, _favoriteCountryCodes);
      },
    );

    Navigator.push(context, pagePath);
  }

  Future<void> _pullFavoritesFromDeviceMemory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favorites = await prefs.getStringList("favoriler");

    if (favorites != null) {
      for (String countryCode in favorites) {
        _favoriteCountryCodes.add(countryCode);
      }
    }
  }

  void _pullCountriesOnline() async {
    Uri uri = Uri.parse(_apiConnection);
    http.Response response = await http.get(uri);
    List<dynamic> parsedResponse = jsonDecode(response.body);

    for (int i = 0; i < parsedResponse.length; i++) {
      Map<String, dynamic> ulkeMap = parsedResponse[i];
      Country country = Country.fromMap(ulkeMap);
      if (country != null) {
        _allCountries.add(country);
      }
    }

    setState(() {});
  }
}
