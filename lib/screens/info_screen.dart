import 'package:flutter/material.dart';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final PageController pageController = PageController(
    initialPage: 0,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('COVID-19 Pamphlet'),
      ),
      body: PageView(
        controller: pageController,
        scrollDirection: Axis.vertical,
        children: [
          SizedBox.expand(
            child: 
              Image.asset('assets/Covid1.jpg')
          ),
          SizedBox.expand(
            child: 
              Image.asset('assets/Covid2.jpg')
          ),
          SizedBox.expand(
            child: 
              Image.asset('assets/Covid3.png')
          )
        ],
      )
    );
  }
}