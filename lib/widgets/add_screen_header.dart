import 'package:flutter/material.dart';

class AddScreenHeader extends StatelessWidget {
  const AddScreenHeader({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
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
            bottom: height * 0.1,
            left: width * 0.1,
            child: Container(
              width: width * 0.5,
              height: height * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color.fromRGBO(152, 20, 255, 0.41),
              ),
              child: Center(
                child: Text(
                  "Add a Movie",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
