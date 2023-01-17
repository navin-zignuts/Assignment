import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/user_preferences/user_preferences.dart';

class dbFirebase {
  static createCart(qty, total, wishid, pid) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    var query = await firestore
        .collection('Cart')
        .where('pid', isEqualTo: pid)
        .where('wishid', isEqualTo: wishid)
        .get();

    if (query.size == 0) {
      FirebaseFirestore.instance.collection('Cart').add({
        'uid': await UserPreferences.getUserId(),
        'pid': pid,
        'quantity': qty,
        'total': total,
        'wishid': wishid
      });
    } else {
      var docid = query.docs.first.id;
      firestore
          .collection('Cart')
          .doc(docid)
          .update({'quantity': qty, 'total': total});
    }
  }

  static createWishlistTotalAndQuantity(wishid, prize) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var dbqty = await firestore
        .collection("Wishlist")
        .doc(wishid)
        .get()
        .then((value) => value.get("quantity"));

    var dbTotal = await firestore
        .collection("Wishlist")
        .doc(wishid)
        .get()
        .then((value) => value.get("total"));

    await firestore
        .collection("Wishlist")
        .doc(wishid)
        .update({"quantity": dbqty += 1, "total": dbTotal += prize});
  }
}
