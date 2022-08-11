import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:world_countries/country.dart';



class CountryDetailPage extends StatelessWidget {
  final Country _country;

  CountryDetailPage(this._country);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blueAccent,
      title: Text(_country.name),
      centerTitle: true,
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: double.infinity),
          SvgPicture.network(
            _country.flag,
            width: MediaQuery.of(context).size.width / 2,
            placeholderBuilder: (context) {
              return Container(
                width: MediaQuery.of(context).size.width / 2,
                height: 120,
                color: Colors.grey,
              );
            },
          ),
          SizedBox(height: 24),
          Text(
            _country.name,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 36),
          _buildAlltheDetails(),
        ],
      ),
    );
  }

  Widget _buildAlltheDetails() {
    return Column(
      children: [
        _buildDetayRow("Ülke İsmi: ", _country.name),
        _buildDetayRow("Başkent: ", _country.capital),
        _buildDetayRow("Bölge: ", _country.region),
        _buildDetayRow("Nüfus: ", _country.population.toString()),
        _buildDetayRow("Dil: ", _country.language),
      ],
    );
  }

  Widget _buildDetayRow(String baslik, String detay) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 16),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              baslik,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Text(
              detay,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
