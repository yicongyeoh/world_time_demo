import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map loadingData = {};
  String? flag;

  @override
  Widget build(BuildContext context) {
    loadingData = loadingData.isNotEmpty
        ? loadingData
        : ModalRoute.of(context)!.settings.arguments as Map;
    print('loading data = $loadingData');


    String bgImage = loadingData['isDayTime'] ? 'day.png' : 'night.png';
    Color? bgColor =
        loadingData['isDayTime'] ? Colors.blue : Colors.indigo[700];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: Column(
              children: [
                TextButton.icon(
                  onPressed: () async {
                    dynamic result =
                        await Navigator.pushNamed(context, '/location');
                    setState(() {
                      loadingData = {
                        'time': result['time'],
                        'location': result['location'],
                        'isDayTime': result['isDayTime'],
                        'flag': result['flag'],
                      };
                    });
                  },
                  icon: Icon(
                    Icons.edit_location,
                    color: Colors.grey[300],
                  ),
                  label: Text(
                    'Edit Location',
                    style: TextStyle(
                      color: Colors.grey[300],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      loadingData['location'],
                      style: TextStyle(
                        fontSize: 28,
                        letterSpacing: 2,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                    loadingData['time'],
                    style: TextStyle(
                      fontSize: 66,
                      color: Colors.white,
                    )),
                Expanded(
                  child: Image(
                      image: AssetImage('assets/${loadingData['flag']}'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
