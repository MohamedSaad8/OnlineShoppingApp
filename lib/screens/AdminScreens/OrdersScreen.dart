import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlineshoppingapp/Models/Order.dart';
import 'package:onlineshoppingapp/constants.dart';
import 'package:onlineshoppingapp/services/store.dart';

class OrderScreen  extends StatelessWidget {
  static String id = "Orders" ;
  final Store store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: store.loadOrders(),
        builder: (context , snapshot)
        {
          if(!snapshot.hasData)
            {
              return Center(
                child: Text(
                  "No Orders"
                ),
              ) ;
            }
          else
            {
              List<Order> orders = [] ;
             for(var doc in snapshot.data.documents)
               {
                 orders.add((Order(
                  totalPrice: doc.data[kTotalPrice],
                   address: doc.data[kAddress]
                 )));
               }
              return ListView.builder(
                itemCount: orders.length,

                  itemBuilder: (context , index){
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(orders[index].address),
                        Text(orders[index].totalPrice.toString())
                      ],
                    );
                  }) ;
            }
        },
      )
    );
  }
}
