import 'package:bus/search.dart';
import 'package:flutter/material.dart';

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

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late AnimationController _controller, _controllerBus, _controllerBusGo;
  late Animation _animation,
      _animationBusScale,
      _animationBusRight,
      _animationBusTop,
      _animationBusScaleGo,
      _animationBusRightGo,
      _animationBusTopGo;
  bool visibilityBus = true, visibilityBusGo = false;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );
    _controllerBus = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );
    _controllerBusGo = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );
    _animation = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 1.0, curve: Curves.easeIn),
      ),
    );
    _animationBusScale = Tween(begin: 100.0, end: 200.0).animate(
      CurvedAnimation(
        parent: _controllerBus,
        curve: Interval(0.0, 1.0, curve: Curves.easeIn),
      ),
    );
    _animationBusRight = Tween(begin: -200.0, end: 10.0).animate(
      CurvedAnimation(
        parent: _controllerBus,
        curve: Interval(0.0, 1.0, curve: Curves.easeIn),
      ),
    );
    _animationBusTop = Tween(begin: 245.0, end: 210.0).animate(
      CurvedAnimation(
        parent: _controllerBus,
        curve: Interval(0.0, 1.0, curve: Curves.easeIn),
      ),
    );
    _animationBusScaleGo = Tween(begin: 200.0, end: 600.0).animate(
      CurvedAnimation(
        parent: _controllerBusGo,
        curve: Interval(0.0, 1.0, curve: Curves.easeIn),
      ),
    );
    _animationBusRightGo = Tween(begin: 10.0, end: 600.0).animate(
      CurvedAnimation(
        parent: _controllerBusGo,
        curve: Interval(0.0, 1.0, curve: Curves.easeIn),
      ),
    );
    _animationBusTopGo = Tween(begin: 210.0, end: 40.0).animate(
      CurvedAnimation(
        parent: _controllerBusGo,
        curve: Interval(0.0, 1.0, curve: Curves.easeIn),
      ),
    );
    _controllerBus.forward();
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

  void _hitGo() {
    setState(() {
      visibilityBus = false;
      visibilityBusGo = true;
    });
    _controllerBusGo.forward();
    _controller.reverse().then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SearchPage()),
      ).then((value) {
        _controller.forward(from: 0);
        _controllerBus.forward(from: 0);
        _controllerBusGo.reset();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            child: Image.asset(
              'assets/bus_background.png',
              fit: BoxFit.fitWidth,
            ),
          ),
          AnimatedBuilder(
            animation: _controllerBus.view,
            builder: (context, child) {
              return Visibility(
                visible: visibilityBus,
                child: Positioned(
                  top: _animationBusTop.value,
                  right: _animationBusRight.value,
                  child: Container(
                    height: _animationBusScale.value,
                    width: _animationBusScale.value,
                    child: Image.asset(
                      'assets/bus.png',
                    ),
                  ),
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: _controllerBusGo.view,
            builder: (context, child) {
              return Visibility(
                visible: visibilityBusGo,
                child: Positioned(
                  top: _animationBusTopGo.value,
                  right: _animationBusRightGo.value,
                  child: Container(
                    height: _animationBusScaleGo.value,
                    width: _animationBusScaleGo.value,
                    child: Image.asset(
                      'assets/bus.png',
                    ),
                  ),
                ),
              );
            },
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
