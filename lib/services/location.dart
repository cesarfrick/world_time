import 'dart:convert';

import 'package:flutter/services.dart';

class Location {
  Future<List> getLocations() async {
    String locations =
        await rootBundle.loadString('assets/data/locations.json');
    List jsonData = jsonDecode(locations)['data'];

    return jsonData;
  }
}
