import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../provider/movie_list_provider.dart';

import '../widgets/list__screen_header.dart';

import 'add_screen.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          ListScreenHeader(height: height, width: width),
          ChangeNotifierProvider(
            create: (context) => MovieListProvider(),
            child: Container(
              height: height * 0.64,
              child: Consumer<MovieListProvider>(
                builder: (context, movieList, child) => ListView.builder(
                  itemBuilder: (ctx, i) => Container(
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
                                  color:
                                      const Color.fromRGBO(152, 20, 255, 0.41),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                              movieList.movies[i].title,
                                              maxLines: 3,
                                              softWrap: true,
                                              overflow: TextOverflow.fade,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          const Expanded(
                                            child: Text(
                                              "Director: ",
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              movieList.movies[i].director,
                                              maxLines: 3,
                                              softWrap: true,
                                              overflow: TextOverflow.fade,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              movieList.movieStatus(
                                                  movieList.movies[i]);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: movieList
                                                          .movies[i].status
                                                      ? const Text(
                                                          "Movie Marked Watched")
                                                      : const Text(
                                                          "Movied Marked Unwatched",
                                                        ),
                                                ),
                                              );
                                            },
                                            icon: movieList.movies[i].status
                                                ? const FaIcon(
                                                    FontAwesomeIcons.solidEye,
                                                  )
                                                : const FaIcon(
                                                    FontAwesomeIcons.eye,
                                                  ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              movieList.delMovie(
                                                  movieList.movies[i]);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
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
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(30),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    movieList.movies[i].imgUrl,
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  itemCount: movieList.movies.length,
                ),
              ),
            ),
          ),
          Container(
            height: height * 0.06,
            color: Colors.transparent,
            child: Center(
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AddScreen.routeName);
                },
                icon: const FaIcon(
                  FontAwesomeIcons.plusCircle,
                ),
                iconSize: height * 0.04,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
