import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SeatPage extends StatefulWidget {
  SeatPage({Key? key}) : super(key: key);

  @override
  _SeatPageState createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage>
    with SingleTickerProviderStateMixin {
  late Animation _animation;
  late AnimationController _controller;
  SMITrigger? _standardTrigger, _premiumTrigger;
  Color _standard = Colors.white, _premium = Colors.transparent;
  String _price = "80 DH";

  void _onRiveInit(Artboard artboard) {
    var controller = StateMachineController.fromArtboard(
      artboard,
      'State Machine 1',
    );
    artboard.addController(controller!);
    _standardTrigger = controller.findInput<bool>('normal') as SMITrigger;
    _premiumTrigger = controller.findInput<bool>('premuim') as SMITrigger;
  }

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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _selectPremuim() {
    setState(() {
      _premiumTrigger?.fire();
      _standard = Colors.transparent;
      _premium = Colors.white;
      _price = "120 DH";
    });
  }

  void _selectStandard() {
    setState(() {
      _standardTrigger?.fire();
      _standard = Colors.white;
      _premium = Colors.transparent;
      _price = "80 DH";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(right: 20, left: 20, top: 40, bottom: 20),
            child: Row(
              children: [
                AnimatedBuilder(
                  animation: _controller.view,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(_animation.value * -40, 0),
                      child: child,
                    );
                  },
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Color.fromARGB(255, 39, 66, 140),
                    ),
                  ),
                ),
                Spacer(),
                AnimatedBuilder(
                  animation: _controller.view,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _animation.value * -40),
                      child: child,
                    );
                  },
                  child: Text(
                    "Seat Selection",
                    style: TextStyle(color: Color.fromARGB(255, 39, 66, 140)),
                  ),
                ),
                Spacer(
                  flex: 2,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  children: [
                    Text(
                      '09:00',
                      style: TextStyle(
                          color: Color.fromARGB(255, 60, 66, 85), fontSize: 18),
                    ),
                    Text(
                      'Casablanca',
                      style: TextStyle(
                          color: Color.fromARGB(255, 60, 66, 85), fontSize: 12),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.directions_bus,
                      size: 18,
                      color: Color.fromARGB(255, 60, 66, 85),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '3h 45min, Direct',
                      style: TextStyle(
                          color: Color.fromARGB(255, 60, 66, 85), fontSize: 12),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      '12:45',
                      style: TextStyle(
                          color: Color.fromARGB(255, 60, 66, 85), fontSize: 18),
                    ),
                    Text(
                      'Tanger',
                      style: TextStyle(
                          color: Color.fromARGB(255, 60, 66, 85), fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0)),
                    color: _standard,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8.0),
                    child: Column(
                      children: [
                        Text(
                          'Standard',
                          style: TextStyle(
                              color: Color.fromARGB(255, 60, 66, 85),
                              fontSize: 18),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '80 HD',
                          style: TextStyle(
                              color: Color.fromARGB(255, 60, 66, 85),
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  print("Standard");
                  _selectStandard();
                },
              ),
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0)),
                    color: _premium,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8.0),
                    child: Column(
                      children: [
                        Text(
                          'Premium',
                          style: TextStyle(
                              color: Color.fromARGB(255, 60, 66, 85),
                              fontSize: 18),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '120 DH',
                          style: TextStyle(
                              color: Color.fromARGB(255, 60, 66, 85),
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  print("Premium");
                  _selectPremuim();
                },
              ),
            ],
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    child: RiveAnimation.asset(
                      'assets/bus_seat.riv',
                      animations: [''],
                      onInit: _onRiveInit,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'selection',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 60, 66, 85),
                                  fontSize: 12),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Seat Z51',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 60, 66, 85),
                                  fontSize: 18),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'price',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 60, 66, 85),
                                  fontSize: 12),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              _price,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 60, 66, 85),
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("BOOK NOW"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
