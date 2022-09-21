import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ups_clone/models/types.model.dart';
import 'package:ups_clone/widgets/deliveryCard.dart';

import '../graphql/graphql_client.dart';
import '../graphql/queries.dart';

class CustomerCard extends StatelessWidget {
  CustomerCard({
    Key? key,
    required this.customer,
    required this.order,
    required this.itemCount,
  }) : super(key: key);
  CustomerList customer;
  List<OrderList> order;
  int itemCount;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModal(context);
      },
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        customer.value!.name!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "ID: ${customer.name}",
                        style: TextStyle(
                          color: Colors.orange.shade400,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "x$itemCount",
                        style: TextStyle(
                          color: Colors.orange.shade400,
                        ),
                      ),
                      Icon(
                        Icons.inventory_2_rounded,
                        color: Colors.orange.shade400,
                        size: 32,
                      )
                    ],
                  ),
                ],
              ),
              Divider(
                color: Colors.orange.shade400,
              ),
              Row(
                children: [
                  Text(
                    customer.value!.email!,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  showModal(BuildContext context) {
    showMaterialModalBottomSheet(
        expand: true,
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        )),
        builder: (context) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => {Navigator.of(context).pop()},
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.black,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 16.0,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.88,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(customer.value!.name!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.orange,
                          )),
                      const Text("deliveries",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 18.0,
                          )),
                      const Divider(
                        height: 30,
                        color: Colors.orange,
                        thickness: 1,
                      ),
                      ListView.builder(
                          itemCount: itemCount,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return DeliveryCard(
                              order: order[index],
                              color: Colors.orange,
                              size: 200,
                            );
                          })
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}
