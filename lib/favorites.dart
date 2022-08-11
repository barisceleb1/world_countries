import 'package:flutter/material.dart';

import 'package:world_countries/country.dart';
import 'package:world_countries/joint_list.dart';


class Favorites extends StatefulWidget {
  final List<Country> allCountries;
  final List<String> favoriteCountryCodes;

  Favorites(this.allCountries, this.favoriteCountryCodes);

  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  List<Country> _favoriteCountries = [];

  @override
  void initState() {
    super.initState();

    for (Country country in widget.allCountries) {
      if (widget.favoriteCountryCodes.contains(country.countryCode)) {
        _favoriteCountries.add(country);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text("Favoriler",style: TextStyle(fontSize: 21),),
      backgroundColor: Colors.red,
      centerTitle: true,
    );
  }

  Widget _buildBody() {
    return JointList(_favoriteCountries, widget.favoriteCountryCodes);
  }
}
