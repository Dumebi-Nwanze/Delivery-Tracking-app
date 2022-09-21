import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQlClientConfig {
  static HttpLink link = HttpLink("http://localhost:5001/api/wishful-indri");
  GraphQLClient myGQLClient() {
    return GraphQLClient(link: link, cache: GraphQLCache());
  }
}
