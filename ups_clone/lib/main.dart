import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ups_clone/graphql/graphql_client.dart';
import 'package:ups_clone/graphql/queries.dart';
import 'package:ups_clone/models/types.model.dart';
import 'package:ups_clone/screens/customer_screen.dart';
import 'package:ups_clone/screens/orders_screen.dart';
import 'firebase_options.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final ValueNotifier<GraphQLClient> client = ValueNotifier(GraphQLClient(
    link: HttpLink("http://localhost:5001/api/wishful-indri"),
    cache: GraphQLCache(),
  ));

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'UPS Clone',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  static List<OrderList> ordersList = [];
  final GraphQlClientConfig _clientConfig = GraphQlClientConfig();
  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  fetchOrders() async {
    GraphQLClient client = _clientConfig.myGQLClient();
    QueryResult result = await client.query(QueryOptions(
      document: gql(MyQueries().getOrders()),
      fetchPolicy: FetchPolicy.cacheAndNetwork,
    ));
    if (result.hasException) {
      return Text(result.exception.toString());
    }

    if (result.isLoading) {
      return const Center(
        child: LinearProgressIndicator(
          color: Colors.white,
        ),
      );
    }

    List ordersArray = result.data?['getOrders'];
    List<OrderList> orders =
        ordersArray.map((customer) => OrderList.fromJson(customer)).toList();

    if (orders.isNotEmpty) {
      setState(() {
        ordersList = orders;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ordersList.isEmpty
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.orange,
              ),
            )
          : PageView(
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
              children: [
                CustomerScreen(
                  ordersList: ordersList,
                ),
                OrdersScreen(
                  ordersList: ordersList,
                ),
              ],
            ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            selectedIndex = index;

            _pageController.animateToPage(
              index,
              duration: const Duration(
                milliseconds: 200,
              ),
              curve: Curves.linear,
            );
          });
        },
        currentIndex: selectedIndex,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.orange.shade700,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Customers'),
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_rounded), label: "Orders")
        ],
      ),
    );
  }
}
