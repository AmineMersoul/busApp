import 'package:bus/seat.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  late Animation _animation, _animationDelay;
  late AnimationController _controller;

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
    _animationDelay = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.2, 1.0),
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

  Widget dateText(String text, {bool active = false}) {
    return Text(
      text,
      style: TextStyle(
        color: active == true ? Colors.black : Color.fromARGB(255, 39, 66, 140),
      ),
    );
  }

  void openSeatSelection() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SeatPage()),
    ).then((value) {
      _controller.forward(from: 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                AnimatedBuilder(
                  animation: _controller.view,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _animation.value * -40),
                      child: child,
                    );
                  },
                  child: Text(
                    "Casablanca to Tanger",
                    style: TextStyle(color: Color.fromARGB(255, 39, 66, 140)),
                  ),
                ),
                AnimatedBuilder(
                  animation: _controller.view,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(_animation.value * 40, 0),
                      child: child,
                    );
                  },
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.tune,
                      color: Color.fromARGB(255, 39, 66, 140),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      dateText("Fr", active: true),
                      SizedBox(height: 5),
                      dateText("01", active: true),
                    ],
                  ),
                  Column(
                    children: [
                      dateText("Sa"),
                      SizedBox(height: 5),
                      dateText("02"),
                    ],
                  ),
                  Column(
                    children: [
                      dateText("Su"),
                      SizedBox(height: 5),
                      dateText("03"),
                    ],
                  ),
                  Column(
                    children: [
                      dateText("Mo"),
                      SizedBox(height: 5),
                      dateText("04"),
                    ],
                  ),
                  Column(
                    children: [
                      dateText("Tu"),
                      SizedBox(height: 5),
                      dateText("05"),
                    ],
                  ),
                  Column(
                    children: [
                      dateText("We"),
                      SizedBox(height: 5),
                      dateText("06"),
                    ],
                  ),
                ],
              ),
            ),
            AnimatedBuilder(
              animation: _controller.view,
              builder: (context, child) {
                return Opacity(
                  opacity: _controller.value,
                  child: child,
                );
              },
              child: AnimatedBuilder(
                animation: _controller.view,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0.0, _animation.value * 20),
                    child: child,
                  );
                },
                child: ticket(fastest: true),
              ),
            ),
            SizedBox(height: 15),
            AnimatedBuilder(
              animation: _controller.view,
              builder: (context, child) {
                return Opacity(
                  opacity: _controller.value,
                  child: child,
                );
              },
              child: AnimatedBuilder(
                animation: _controller.view,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0.0, _animationDelay.value * 20),
                    child: child,
                  );
                },
                child: ticket(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ticket({bool fastest = false}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Column(
        children: [
          fastest == true
              ? Container(
                  alignment: Alignment.center,
                  height: 27,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                    color: Color.fromARGB(255, 112, 206, 79),
                  ),
                  child: Text(
                    "Fastest",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : SizedBox(
                  height: 10,
                ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sep 01',
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 10),
                        ),
                        Text(
                          '09:00',
                          style: TextStyle(
                              color: Color.fromARGB(255, 60, 66, 85),
                              fontSize: 18),
                        ),
                        Text(
                          'Casablanca',
                          style: TextStyle(
                              color: Color.fromARGB(255, 60, 66, 85),
                              fontSize: 12),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.directions_bus,
                          size: 24,
                          color: Color.fromARGB(255, 60, 66, 85),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '3h 45min, Direct',
                          style: TextStyle(
                              color: Color.fromARGB(255, 60, 66, 85),
                              fontSize: 12),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Sep 01',
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 10),
                        ),
                        Text(
                          '12:45',
                          style: TextStyle(
                              color: Color.fromARGB(255, 60, 66, 85),
                              fontSize: 18),
                        ),
                        Text(
                          'Tanger',
                          style: TextStyle(
                              color: Color.fromARGB(255, 60, 66, 85),
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Container(
                        height: 50,
                        width: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Economy",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 60, 66, 85),
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    "8 Seat Avaliable",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Text(
                                "80 DH",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 60, 66, 85),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        openSeatSelection();
                      },
                    ),
                    GestureDetector(
                      child: Container(
                        height: 50,
                        width: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "1st Class",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 60, 66, 85),
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    "5 Seat Avaliable",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Text(
                                "120 DH",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 60, 66, 85),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        openSeatSelection();
                      },
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
