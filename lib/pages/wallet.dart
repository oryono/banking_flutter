import 'package:banking/utils/money.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';

class Wallet extends StatefulWidget {
  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  String getAccounts = """
    query getAccounts (\$customerId: Int!){
       accounts(customerId: \$customerId){
        accountNumber
        id
        name
      }
    }
""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallets'),
      ),
      body: Query(
        options: QueryOptions(
          documentNode: gql(getAccounts),
          // this is the query string you just created
          variables: {
            'customerId': 1,
          },
          pollInterval: 10,
        ),
        builder: (QueryResult result,
            {VoidCallback refetch, FetchMore fetchMore}) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }

          if (result.loading) {
            return Center(
              child: Loading(
                indicator: BallPulseIndicator(),
                size: 100.0,
                color: Colors.teal,
              ),
            );
          }

          // it can be either Map or List
          List accounts = result.data['accounts'];

          return ListView.builder(
              itemCount: accounts.length,
              itemBuilder: (context, index) {
                final repository = accounts[index];

                return Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  height: 150,
                  width: double.maxFinite,
                  child: Card(
                    elevation: 5,
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.account_balance_wallet,
                            size: 45,
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                repository['name'],
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.teal),
                              ),
                              Text(
                                repository['accountNumber'],
                                style: TextStyle(color: Colors.grey.shade500),
                              )
                            ],
                          ),
                        ),
                        Query(
                            options: QueryOptions(documentNode: gql("""
                                  query getAccountDetails(\$accountId: Int!) {
                                    accountDetails(accountId: \$accountId) {
                                      account{
                                        name
                                      }
                                      balance
                                    }
                                  }
                            """),
                                // this is the query string you just created
                                variables: {
                                  'accountId': int.parse(repository['id']),
                                }),
                            builder: (QueryResult result,
                                {VoidCallback refetch, FetchMore fetchMore}) {
                              if (result.hasException) {
                                return Text(result.exception.toString());
                              }
                              if (result.loading) return Text('Loading');
                              return ListTile(
                                title: Text(
                                    money(result.data['accountDetails']
                                            ['balance']
                                        .toDouble()),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 30,
                                        color: Colors.grey.shade500)),
                              );
                            })
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}

//ListTile(
//title: Text(
//money(3000000),
//style: TextStyle(
//fontWeight: FontWeight.w500, fontSize: 35),
//
//),
//)
