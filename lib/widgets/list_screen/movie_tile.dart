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
        horizontal: width * 0.04,
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
                  width: width * 0.8,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(152, 20, 255, 0.41),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    width: width * 0.48,
                    padding: EdgeInsets.symmetric(
                      vertical: height * 0.02,
                      horizontal: width * 0.02,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Movie: ",
                                style: Theme.of(context).textTheme.headline6,
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
                            Expanded(
                              child: Text(
                                "Director:",
                                style: Theme.of(context).textTheme.headline6,
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
