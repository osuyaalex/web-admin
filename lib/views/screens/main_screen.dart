import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:web_admin/views/screens/side%20bar%20screens/categories_screen.dart';
import 'package:web_admin/views/screens/side%20bar%20screens/dashboard_screen.dart';
import 'package:web_admin/views/screens/side%20bar%20screens/orders_screen.dart';
import 'package:web_admin/views/screens/side%20bar%20screens/products_screen.dart';
import 'package:web_admin/views/screens/side%20bar%20screens/upload_banner_screen.dart';
import 'package:web_admin/views/screens/side%20bar%20screens/vendors_screen.dart';
import 'package:web_admin/views/screens/side%20bar%20screens/withdrawal_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _selectedItem = const DashboardScreen();


  screenSelector(item){
    switch(item.route){
      case DashboardScreen.routeName:
        setState(() {
          _selectedItem = DashboardScreen();
        });
        break;
      case VendorsScreen.routeName:
        setState(() {
          _selectedItem =  VendorsScreen();
        });
        break;
      case WithdrawalScreen.routeName:
        setState(() {
          _selectedItem =  WithdrawalScreen();
        });
        break;
      case OrdersScreen.routeName:
        setState(() {
          _selectedItem = OrdersScreen();
        });
        break;
      case CategoriesScreen.routeName:
        setState(() {
          _selectedItem =  CategoriesScreen();
        });
        break;
      case UploadBannerScreen.routeName:
        setState(() {
          _selectedItem =  UploadBannerScreen();
        });
        break;
      case ProductsScreen.routeName:
        setState(() {
          _selectedItem =  ProductsScreen();
        });
    }
  }
  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar: AppBar(
        title:  const Text('Management'),
      ),
      sideBar:  SideBar(
          items: const [
            AdminMenuItem(
                title: 'Dashboard',
              icon: Icons.dashboard,
              route: DashboardScreen.routeName
            ),
            AdminMenuItem(
                title: 'Vendors',
                icon: CupertinoIcons.person,
                route: VendorsScreen.routeName
            ),
            AdminMenuItem(
                title: 'Withdrawal',
                icon: CupertinoIcons.money_dollar,
                route: WithdrawalScreen.routeName
            ),
            AdminMenuItem(
                title: 'Orders',
                icon: CupertinoIcons.shopping_cart,
                route: OrdersScreen.routeName
            ),
            AdminMenuItem(
                title: 'Categories',
                icon: Icons.category,
                route: CategoriesScreen.routeName
            ),
            AdminMenuItem(
                title: 'Upload Banner',
                icon: CupertinoIcons.add,
                route: UploadBannerScreen.routeName
            ),
            AdminMenuItem(
                title: 'Products',
                icon: Icons.shop,
                route: ProductsScreen.routeName
            ),
          ],
          selectedRoute: '', onSelected: (item){
            screenSelector(item);
      },
        header: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'Osuya Alex Panel',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        footer: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'footer',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: _selectedItem,
    );
  }
}
