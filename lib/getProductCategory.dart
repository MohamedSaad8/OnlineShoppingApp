import 'Models/ProductModal.dart';

List<Product> getProductByCategory(String category , List<Product> _allProducts) {
  List<Product> products = [] ;
  for(var pro in _allProducts)
  {
    if(pro.productCategory == category)
    {
      products.add(pro) ;
    }
  }
  return products ;
}