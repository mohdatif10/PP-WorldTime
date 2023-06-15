import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String? location; //location name for UI
  String? time; //time at location
  String? flag; //url to an asset flag icon
  String? url; // the '/continent/city' in url location
  bool? isDaytime; //true or false

  WorldTime({required this.location, required this.flag, required this.url});

  Future <void> getTime() async {
    try {
      //make API request
      Response response = await get(
          Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      //print(data);

      //getting properties from data
      String datetime = data["datetime"];
      String offset = data["utc_offset"].substring(0, 3);
      // print(datetime);
      // print(offset);

      //create a DateTime object

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      //print(now);

      //set the time property
      isDaytime = now.hour>6 && now.hour<20? true: false;
      time = DateFormat.jm().format(now);
    }
    catch (e) {
      print("caught error: $e");
      time="couldnt get time data";
    }
  }
}


