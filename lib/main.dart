import 'package:bus/search.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SMITrigger? _go;
  double _top = -40;
  double _bottom = -240;

  static const List<String> _cities = <String>[
    'Casablanca',
    'Rabat',
    'Tanger',
  ];
  String _depart = 'Casablanca';
  String _destination = 'Tanger';

  void _swipCities() {
    String temp = _depart;
    setState(() {
      _depart = _destination;
      _destination = temp;
    });
  }

  void _loadingAnimation() {
    setState(() {
      _top = 40;
      _bottom = 40;
    });
  }

  void _finishAnimation() {
    setState(() {
      _top = -40;
      _bottom = -240;
    });
  }

  void _onRiveInit(Artboard artboard) {
    var controller = StateMachineController.fromArtboard(
      artboard,
      'StateMachine',
      onStateChange: _onStateChange,
    );
    artboard.addController(controller!);
    _go = controller.findInput<bool>('go') as SMITrigger;
    _loadingAnimation();
    setState(() {});
  }

  void _onStateChange(String stateMachineName, String stateName) {
    print('State Changed in $stateMachineName to $stateName');
    if (stateName == "ExitState") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SearchPage()),
      );
    }
  }

  void _hitGo() {
    _finishAnimation();
    _go?.fire();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          RiveAnimation.asset(
            'assets/bus.riv',
            animations: ['coming'],
            fit: BoxFit.cover,
            onInit: _onRiveInit,
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 600),
            top: _top,
            left: 40,
            right: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Wednesday',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      '02/10/2021',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      '24°C',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.cloud_queue,
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 600),
            bottom: _bottom,
            left: 40,
            right: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'From',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
                DropdownButton<String>(
                  value: _depart,
                  icon: Visibility(
                    visible: false,
                    child: Icon(Icons.arrow_downward),
                  ),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.white),
                  underline: Container(
                    height: 1,
                    color: Colors.white,
                  ),
                  dropdownColor: Colors.blue,
                  onChanged: (String? newValue) {
                    setState(() {
                      _depart = newValue!;
                    });
                  },
                  items: _cities.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                ElevatedButton(
                  onPressed: () => {_swipCities()},
                  child: Icon(Icons.swap_vert),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'To',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
                DropdownButton<String>(
                  value: _destination,
                  icon: Visibility(
                    visible: false,
                    child: Icon(Icons.arrow_downward),
                  ),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.white),
                  underline: Container(
                    height: 1,
                    color: Colors.white,
                  ),
                  dropdownColor: Colors.blue,
                  onChanged: (String? newValue) {
                    setState(() {
                      _destination = newValue!;
                    });
                  },
                  items: _cities.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => {_hitGo()},
                  child: Text("Search"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
