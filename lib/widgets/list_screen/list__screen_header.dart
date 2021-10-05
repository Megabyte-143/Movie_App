import 'package:flutter/material.dart';

class ListScreenHeader extends StatelessWidget {
  const ListScreenHeader({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.3,
      width: width,
      child: Stack(
        children: [
          const Positioned(
            top: 0,
            left: 0,
            child: Image(
              image: AssetImage(
                "assets/images/top_left.png",
              ),
              fit: BoxFit.fill,
            ),
          ),
          const Positioned(
            top: 0,
            right: 0,
            child: Image(
              image: AssetImage(
                "assets/images/top_right.png",
              ),
            ),
          ),
          Positioned(
            bottom: height * 0.03,
            left: width * 0.1,
            child: Material(
              elevation: 10,
              color: Colors.transparent,
              shadowColor: Colors.transparent,
              child: Container(
                width: width * 0.5,
                height: height * 0.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color.fromRGBO(152, 20, 255, 0.41),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade100,
                      offset: Offset.fromDirection(1, 4),
                      spreadRadius: 5,
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    "Hey Yash! \n Here is Your Movie List ",
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
