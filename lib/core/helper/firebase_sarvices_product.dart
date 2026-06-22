import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  DocumentSnapshot? lastDocument;
  bool hasMore = true;

  Future<List<DocumentSnapshot>> fetchProducts({String? region}) async {
    Query query = FirebaseFirestore.instance
        .collection('newsupload')
        .orderBy('createdAt', descending: true)
        .limit(10);

    // Filter by region
    if (region != null && region != "الكل") {
      query = query.where('region', isEqualTo: region);
    }

    // Pagination
    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument!);
    }

    final snapshot = await query.get();

    if (snapshot.docs.isNotEmpty) {
      lastDocument = snapshot.docs.last;
    } else {
      hasMore = false;
    }

    return snapshot.docs;
  }

  void resetPagination() {
    lastDocument = null;
    hasMore = true;
  }
}
