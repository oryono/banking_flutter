import 'package:banking/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() {
  final HttpLink httpLink = HttpLink(
    uri: 'https://banking.patrickoryono.site/api',
  );

  final AuthLink authLink = AuthLink(
    getToken: () => 'Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJCYW5raW5nR3JhcGgiLCJleHAiOjE1OTA3NTQ2NjksImlhdCI6MTU4ODMzNTQ2OSwiaXNzIjoiQmFua2luZ0dyYXBoIiwianRpIjoiMzM2YmQ1NDMtY2ZlMi00Y2MwLTk2MGEtYTljNmNiODQ0MGE0IiwibmJmIjoxNTg4MzM1NDY4LCJzdWIiOiIxIiwidHlwIjoiYWNjZXNzIn0.bLzAmYixmJofx6rvaLis6IdVNCZ--d9WMZcGNwyYLXrRTKQa_IL-9OnBxWbMsV7FhR_kFu7Zu_RnIdUviqrsEg',
  );

  final Link link = authLink.concat(httpLink);

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      cache: InMemoryCache(),
      link: link,
    ),
  );

  runApp(GraphQLProvider(client: client, child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.teal,
        ),
        home: Home());
  }
}
