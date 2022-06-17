import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class RealDatabase {
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  DatabaseReference? dbRef;

  void addNews(String title, String b1, String p1) {
    dbRef = firebaseDatabase.ref();
    dbRef!
        .child("News")
          .push()
        .set({"title": "$title", "body": "$b1", "photo": "$p1"});
  }

  Stream<DatabaseEvent> getReadNews() {
    dbRef = firebaseDatabase.ref();
    return dbRef!.child("News").onValue;
  }

  void deleteNews(String key) {
    dbRef = firebaseDatabase.ref();
    dbRef!.child("News").child("$key").remove();
  }

  void updateData(String t1, String b1, String p1, String key) {
    dbRef = firebaseDatabase.ref();

    dbRef!
        .child("News")
        .child("$key")
        .set({"title": t1, "body": b1, "photo": p1});
  }
}
