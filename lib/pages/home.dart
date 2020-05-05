import 'package:banking/pages/account.dart';
import 'package:banking/pages/transfers.dart';
import 'package:banking/pages/wallet.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedTab,
        children: pageList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedTab,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            selectedTab = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            title: Text('Wallets',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.compare_arrows),
            title: Text('Transfers',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text(
              'My Account',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> get pageList {
    List<Widget> pageList = List<Widget>();
    pageList.add(Wallet());
    pageList.add(Transfers());
    pageList.add(Account());

    return pageList;
  }
}
