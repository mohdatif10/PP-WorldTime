import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data={};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    try{
      data = data.isNotEmpty? data : ModalRoute.of(context)?.settings.arguments as Map;
    }catch(e){
      data = {};
    }

    //set background
    String bgImage=data["isDaytime"]? "day.png": "night.png";
    Color bgColor = data['isDaytime'] ? Colors.blue[200]! : Colors.indigo[700]!;


    return Scaffold(
      backgroundColor: bgColor,
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/$bgImage"),
              fit: BoxFit.cover),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0,120,0,0),
              child: Column(
                children: <Widget>[
                  TextButton.icon(
                    onPressed: () async {
                      dynamic result = await Navigator.pushNamed(context, '/location');
                      if(result != null){
                        setState(() {
                          data = {
                            'time': result['time'],
                            'location': result['location'],
                            'isDaytime': result['isDaytime'],
                            'flag': result['flag']
                          };
                        });
                      }
                    },
                    icon: Icon(
                        Icons.edit_location,
                    color: Colors.grey[300],),
                    label: Text("Edit location",
                    style: TextStyle(color:Colors.grey[300]),
                    )),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(data["location"],
                      style:TextStyle(
                        fontSize: 30,
                        letterSpacing: 2,
                        color:Colors.white,
                      )
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(data["time"],
                      style:TextStyle(
                        fontSize: 70,
                        letterSpacing: 1,
                        color:Colors.white,
                      )
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }

}