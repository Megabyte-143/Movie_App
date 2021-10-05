import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../provider/movie_list_provider.dart';

import '../widgets/list_screen/movie_tile.dart';
import '../widgets/list_screen/list__screen_header.dart';

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
          SizedBox(
              height: height * 0.64,
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream:
                    FirebaseFirestore.instance.collection('movies').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text("An Erro Occured"),
                    );
                  } else {
                    final docs = snapshot.data!.docs;
                    return ListView.builder(
                      itemBuilder: (ctx, i) {
                        return Consumer<MovieListProvider>(
                            builder: (ctx, movie, child) {
                          return MovieTile(
                            height: height,
                            width: width,
                            title: docs[i]['title'],
                            director: docs[i]['director'],
                            imgUrl: docs[i]['imgUrl'],
                            status: docs[i]['status'],
                            statusFun: () {
                              movie.movieStatus(
                                docs[i]['title'],
                                !docs[i]['status'],
                              );
                            },
                            delFun: () {
                              movie.delMovie(docs[i]['title']);
                            },
                          );
                        });
                      },
                      itemCount: docs.length,
                    );
                  }
                },
              )),
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
