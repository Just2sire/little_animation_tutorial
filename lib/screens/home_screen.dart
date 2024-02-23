import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late Animation<double> _textAnimation;
  late Animation<Offset> _imageAnimation;
  late Animation<double> rotationAnimation;
  late AnimationController _textController;
  late AnimationController _imageController;
  late AnimationController rotationController;

  @override
  void initState() {
    super.initState();

    // Image animations
    _imageController = AnimationController(
      duration: const Duration(
        milliseconds: 400,
      ),
      vsync: this,
    );

    _imageAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(4, 0),
    ).animate(_imageController);

    // Text animations
    _textController = AnimationController(
      duration: const Duration(
        milliseconds: 400,
      ),
      vsync: this,
    );

    _textAnimation = Tween<double>(begin: 1.0, end: 0).animate(_textController);

    // Rotation animations
    rotationController = AnimationController(
      duration: const Duration(
        milliseconds: 500,
      ),
      vsync: this,
    );

    rotationAnimation = CurvedAnimation(
      parent: rotationController,
      curve: Curves.linear,
    );
  }

  int active = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Food Menu",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  SizedBox(
                    width: width * 0.35,
                    child: Padding(
                      padding: EdgeInsets.all(
                        10,
                      ),
                      child: ListView.builder(
                        itemCount: pics.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              rotationController.repeat();
                              Timer(Duration(milliseconds: 200), () {
                                _imageController.forward();
                                _textController.forward();
                              });
                              Timer(Duration(milliseconds: 400), () {
                                setState(() {
                                  active = index;
                                });
                                _imageController.reverse();
                                _textController.reverse();
                              });
                              Timer(Duration(milliseconds: 400), () {
                                rotationController.stop();
                              });
                            },
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                color: active == index ? Colors.amber : null,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image.asset(
                                pics[index],
                                width: width * 0.2,
                                height: width * 0.2,
                                fit: BoxFit.contain,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        SlideTransition(
                          position: _imageAnimation,
                          child: RotationTransition(
                            turns: rotationAnimation,
                            child: Image.asset(
                              pics[active],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ScaleTransition(
                          scale: _textAnimation,
                          child: Text(
                            names[active],
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting",
                          style: TextStyle(color: Colors.amber),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

List<String> pics = [
  "assets/rounded_food/pic_1.png",
  "assets/rounded_food/pic_2.png",
  "assets/rounded_food/pic_3.jpg",
  "assets/rounded_food/pic_4.png",
  "assets/rounded_food/pic_1.png",
  "assets/rounded_food/pic_2.png",
  "assets/rounded_food/pic_3.jpg",
  "assets/rounded_food/pic_4.png",
  "assets/rounded_food/pic_1.png",
  "assets/rounded_food/pic_2.png",
  "assets/rounded_food/pic_3.jpg",
  "assets/rounded_food/pic_4.png",
];

List<String> names = [
  "Pizza",
  "Halburger",
  "Tacos",
  "PanCake",
  "Pizza",
  "Halburger",
  "Tacos",
  "PanCake",
  "Pizza",
  "Halburger",
  "Tacos",
  "PanCake",
];
