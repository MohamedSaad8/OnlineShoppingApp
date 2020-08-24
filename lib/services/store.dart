import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onlineshoppingapp/Models/ProductModal.dart';
import 'package:onlineshoppingapp/constants.dart';
class Store
{
  final fireStore = Firestore.instance;

  addProduct (Product product) {
    fireStore.collection(kCollectionName).add({
      kProductName : product.productName ,
      kProductCategory: product.productCategory ,
      kProductDescription : product.productDescription,
      kProductPrice : product.productPrice,
      kProductImageLocation : product.productImageLocation
    });
  }

  Stream<QuerySnapshot> loadProduct()  {
   return  fireStore.collection(kCollectionName).snapshots();
  }

  deleteProduct(documentID) {
    fireStore.collection(kCollectionName).document(documentID).delete();
  }

  modifyProduct (data ,documentID )
  {
    fireStore.collection(kCollectionName).document(documentID).updateData(data);
  }

 Stream<QuerySnapshot> loadOrders ()
  {
    return fireStore.collection(kOrders).snapshots();
  }

  addOrders(data , List<Product> products)
  {
    final refrance = fireStore.collection(kOrders).document();
    refrance.setData(data);
    for(var product in products)
      {
        refrance.collection(kOrderDetails).document().setData({
          kProductName : product.productName ,
          kProductPrice:product.productPrice,
          kProductCategory:product.productCategory,
          kProductImageLocation : product.productImageLocation,
          kProductQuantity : product.quantity
        });
      }

  }

}