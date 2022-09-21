import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ups_clone/graphql/graphql_client.dart';
import 'package:ups_clone/graphql/queries.dart';
import 'package:ups_clone/models/types.model.dart';

import '../widgets/customerCard.dart';

class CustomerScreen extends StatefulWidget {
  CustomerScreen({Key? key, required this.ordersList}) : super(key: key);
  List<OrderList> ordersList;
  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade200,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/delivery.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 32.0),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    searchController.text = value;
                    searchController.selection = TextSelection.fromPosition(
                        TextPosition(offset: searchController.text.length));
                  });
                },
                decoration: InputDecoration(
                  focusColor: Colors.orange.shade200,
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Search by Customers",
                ),
              ),
            ),
            Query(
              options: QueryOptions(
                document: gql(MyQueries().getCustomers()),
                fetchPolicy: FetchPolicy.cacheAndNetwork,
              ),
              builder: (QueryResult result,
                  {VoidCallback? refetch, FetchMore? fetchMore}) {
                if (result.hasException) {
                  return Text(result.exception.toString());
                }

                if (result.isLoading) {
                  return Center(
                    child: LinearProgressIndicator(
                      color: Colors.orange,
                      backgroundColor: Colors.orange.shade300,
                    ),
                  );
                }

                List customersArray = result.data?['getCustomers'];
                List<CustomerList> customers = customersArray
                    .map((customer) => CustomerList.fromJson(customer))
                    .where((customer) => customer.value!.name!
                        .toLowerCase()
                        .startsWith(searchController.text.toLowerCase()))
                    .toList();

                if (customers.isEmpty) {
                  return const Text('No Customers');
                }
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: customers.length,
                    itemBuilder: (context, index) {
                      List<OrderList> order = [];
                      for (var o in widget.ordersList) {
                        if (o.value?.trackingItems?.customerId ==
                            customers[index].name) {
                          order.add(o);
                        }
                      }

                      return CustomerCard(
                        customer: customers[index],
                        order: order,
                        itemCount: order.length,
                      );
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
