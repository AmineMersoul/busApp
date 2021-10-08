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

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  SMITrigger? _go, _start;
  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );
    _animation = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 1.0, curve: Curves.easeIn),
      ),
    );
    _controller.forward();
    super.initState();
  }

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

  void _onRiveInit(Artboard artboard) {
    var controller = StateMachineController.fromArtboard(
      artboard,
      'StateMachine',
      onStateChange: _onStateChange,
    );
    artboard.addController(controller!);
    _go = controller.findInput<bool>('go') as SMITrigger;
    _start = controller.findInput<bool>('start') as SMITrigger;
  }

  void _onStateChange(String stateMachineName, String stateName) {
    print('State Changed in $stateMachineName to $stateName');
    if (stateName == "ExitState") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SearchPage()),
      ).then((value) {
        _controller.forward();
        _start?.fire();
      });
    }
  }

  void _hitGo() {
    _controller.reverse();
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
          Positioned(
            top: 60,
            left: 40,
            right: 40,
            child: AnimatedBuilder(
              animation: _controller.view,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _animation.value * -100),
                  child: child,
                );
              },
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
          ),
          Positioned(
            bottom: 40,
            left: 40,
            right: 40,
            child: AnimatedBuilder(
              animation: _controller.view,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _animation.value * 280),
                  child: child,
                );
              },
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
                    items:
                        _cities.map<DropdownMenuItem<String>>((String value) {
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
                    items:
                        _cities.map<DropdownMenuItem<String>>((String value) {
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
          ),
        ],
      ),
    );
  }
}
