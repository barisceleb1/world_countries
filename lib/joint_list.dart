import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:world_countries/country.dart';
import 'package:world_countries/country_detail_page.dart';

class JointList extends StatefulWidget {
  List<Country> countryList;
  List<String> favoriteCountryCodes;

  JointList(this.countryList, this.favoriteCountryCodes);

  @override
  _JointListState createState() => _JointListState();
}

class _JointListState extends State<JointList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.countryList.length,
      itemBuilder: _buildListItem,
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    Country country = widget.countryList[index];

    return Card(
      child: ListTile(
        leading: ClipOval(
          child: SizedBox(
            width: 48,
            height: 48,
            child: SvgPicture.network(
              country.flag,
              clipBehavior: Clip.none,
              fit: BoxFit.cover,
              placeholderBuilder: (context) {
                return CircleAvatar(backgroundColor: Colors.grey);
              },
            ),
          ),
        ),
        title: Text(country.name),
        subtitle: Text("Başkent: ${country.capital}"),
        trailing: IconButton(
          icon: Icon(
            widget.
            favoriteCountryCodes.contains(country.countryCode)
                ? Icons.favorite
                : Icons.favorite_border,
            color: Colors.red,
          ),
          onPressed: () {
            _favoriTiklandi(country);
          },
        ),
        onTap: () {
          _ulkeTiklandi(context, country);
        },
      ),
    );
  }

  void _ulkeTiklandi(BuildContext context, Country country) {
    MaterialPageRoute pagePath = MaterialPageRoute(
      builder: (BuildContext context) {
        return CountryDetailPage(country);
      },
    );

    Navigator.push(context, pagePath);
  }

  void _favoriTiklandi(Country country) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (widget.favoriteCountryCodes.contains(country.countryCode)) {
      widget.favoriteCountryCodes.remove(country.countryCode);
    } else {
      widget.favoriteCountryCodes.add(country.countryCode);
    }

    await prefs.setStringList("favoriler", widget.favoriteCountryCodes);
    setState(() {});
  }
}
