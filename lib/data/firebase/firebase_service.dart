import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news_app/data/models/articles/source.dart';

class FirebaseService {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  CollectionReference<Sources> getCollectionReference() {
    return firebaseFirestore
        .collection('sources')
        .withConverter(
          fromFirestore: (snapshot, _) => Sources.fromJson(snapshot.data()!),
          toFirestore: (sources, _) => sources.toJson(),
        );
  }

  Future<void> setSource(List<Sources>? sources, String categoryId) async {
    var collection = await getCollectionReference().get();
    for (var doc in collection.docs) {
      if (doc.data().category == categoryId) return;
    }
    for (var e in sources ?? []) {
      await getCollectionReference().doc(e!.id).set(e);
    }
  }

  // getSource(String categoryId) async {
  //   var collection = getCollectionReference();
  //   return collection.doc(categoryId).get();
  // }

  clearCache() async {
    var collection = await getCollectionReference().get();
    for (var doc in collection.docs) {
      await doc.reference.delete();
    }
  }

  Future<List<Sources>> getSource(String categoryId) async {
    List<Sources> sources = [];
    var collection = getCollectionReference();

    // for (var doc in collection.docs) {
    //   sources.add(doc.data());
    // }
    var querySnapshot =
        await collection
            .where("category", isEqualTo: categoryId.toLowerCase())
            .get();
    sources = querySnapshot.docs.map((e) => e.data()).toList();
    // for (var doc in querySnapshot.docs) {
    //   final source = doc.sources.add(source);
    // }

    return sources;
  }
}
