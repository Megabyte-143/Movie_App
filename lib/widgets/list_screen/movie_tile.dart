import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MovieTile extends StatelessWidget {
  const MovieTile({
    Key? key,
    required this.height,
    required this.width,
    required this.title,
    required this.director,
    required this.imgUrl,
    required this.status,
    required this.statusFun,
    required this.delFun,
  }) : super(key: key);

  final double height;
  final double width;
  final String title;
  final String director;
  final String imgUrl;
  final bool status;
  final Function statusFun;
  final Function delFun;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: height * 0.03,
        horizontal: width * 0.09,
      ),
      height: height * 0.4,
      width: width,
      child: Stack(
        children: [
          Positioned(
            right: 0,
            bottom: height * 0.08,
            child: Material(
              elevation: 20,
              shadowColor: Colors.transparent,
              color: Colors.transparent,
              child: Container(
                  alignment: Alignment.bottomRight,
                  height: height * 0.22,
                  width: width * 0.7,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(152, 20, 255, 0.41),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      //color: Colors.yellow,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    width: width * 0.39,
                    padding: EdgeInsets.symmetric(
                      vertical: height * 0.02,
                      horizontal: width * 0.01,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                "Movie: ",
                              ),
                            ),
                            Expanded(
                              child: Text(
                                title,
                                maxLines: 3,
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Expanded(
                              child: Text(
                                "Director: ",
                              ),
                            ),
                            Expanded(
                              child: Text(
                                director,
                                maxLines: 3,
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              onPressed: () {
                                statusFun();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: !status
                                        ? const Text("Movie Marked Watched")
                                        : const Text(
                                            "Movied Marked Unwatched",
                                          ),
                                  ),
                                );
                              },
                              icon: status
                                  ? const FaIcon(
                                      FontAwesomeIcons.solidEye,
                                    )
                                  : const FaIcon(
                                      FontAwesomeIcons.eye,
                                    ),
                            ),
                            IconButton(
                              onPressed: () {
                                delFun();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Movie Deleted from the list",
                                    ),
                                  ),
                                );
                              },
                              icon: const FaIcon(
                                FontAwesomeIcons.trashAlt,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
            ),
          ),
          Positioned(
            child: Material(
              elevation: 20,
              color: Colors.transparent,
              child: Container(
                height: height * 0.3,
                width: width * 0.45,
                decoration: BoxDecoration(
                 // color: Colors.yellow,
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: NetworkImage(
                      imgUrl,
                    ),
                    fit: BoxFit.fill,
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
