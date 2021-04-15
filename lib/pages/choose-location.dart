import 'package:flutter/material.dart';
import 'package:world_time/services/location.dart';
import 'package:world_time/services/world-time.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  int counter = 0;

  List<WorldTime> locations = [];

  void getExternalLocations() async {
    Location location = Location();

    List result = await location.getLocations();

    setState(() {
      locations = [
        ...result.map((item) {
          return WorldTime(
            url: item['url'],
            location: item['location'],
            flag: item['flag'],
          );
        })
      ];
    });
  }

  void updateTime(index) async {
    WorldTime worldTime = locations[index];

    await worldTime.getTime();

    Navigator.pop(context, {
      'location': worldTime.location,
      'flag': worldTime.flag,
      'time': worldTime.time,
      'isDaytime': worldTime.isDaytime,
    });
  }

  @override
  Widget build(BuildContext context) {
    getExternalLocations();

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[9000],
        title: Text('Choose a Location'),
        elevation: 0,
      ),
      body: ListView.builder(
          itemCount: locations.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
              child: Card(
                child: ListTile(
                  onTap: () {
                    updateTime(index);
                  },
                  title: Text(locations[index].location),
                  leading: CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/flags/${locations[index].flag}'),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
