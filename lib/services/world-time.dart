import 'dart:convert';

import 'package:http/http.dart' show Response, get;
import 'package:intl/intl.dart' show DateFormat;

class WorldTime {
  String location;
  String time;
  String flag;
  String url;
  bool isDaytime;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      Uri url = Uri.https('worldtimeapi.org', '/api/timezone/${this.url}');

      Response response = await get(url);
      Map data = jsonDecode(response.body);

      String datetimeRaw = data['datetime'];
      String datetime = datetimeRaw.substring(0, datetimeRaw.length - 6);

      DateTime now = DateTime.parse(datetime);

      isDaytime = now.hour > 6 && now.hour < 20;

      this.time = DateFormat.jm().format(now);
    } catch (err) {
      print('Caught error $err');
      this.time = 'Could not get time data';
    }
  }
}
