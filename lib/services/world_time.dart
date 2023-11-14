import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  late String location;
  late String time;
  late String flag;
  late String url;
  late bool? isDayTime;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      Response response =
          await get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      //print(data);

      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      // print(datetime);
      // print(offset);

      //create datetime object
      DateTime timeNow = DateTime.parse(datetime);
      timeNow = timeNow.add(Duration(hours: int.parse(offset)));

      //set time property
      isDayTime = timeNow.hour > 6 && timeNow.hour < 20 ? true : false;

      time = DateFormat.jm().format(timeNow);
    } catch (e) {
      time = 'could not get time info';
    }
  }
}
