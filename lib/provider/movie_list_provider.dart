import 'package:flutter/material.dart';

import '../api/firebase_api.dart';

class MovieListProvider with ChangeNotifier {

  void delMovie(String title) {
    FirebaseApi.delMovie(title);
  }

  void movieStatus(String title, bool status) {
    FirebaseApi.statusUpdate(status, title);
  }
}
