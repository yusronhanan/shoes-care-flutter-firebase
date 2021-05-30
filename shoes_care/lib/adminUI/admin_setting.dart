import 'package:flutter/material.dart';
import 'package:shoes_care/app_theme.dart';
import 'package:shoes_care/model/admin.dart';
import 'package:settings_ui/settings_ui.dart';

class AdminSettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AdminSettingPageState();
  }
}

class AdminSettingPageState extends State<AdminSettingPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: buildSettingsList()
    );
  }

  Widget buildSettingsList() {
    return SettingsList(
      backgroundColor: Colors.white,
      sections: [
        SettingsSection(
          title: 'Order',
          tiles: [
            SettingsTile(
              title: 'Complete Orders',
              // subtitle: '',
              onPressed: (context) {
                Navigator.pushNamed(context, '/allCompleteOrder');
              },
            ),
          ],
        ),
        SettingsSection(
          title: 'Customer',
          tiles: [
            SettingsTile(
              title: 'All Customers',
              // subtitle: '',
              onPressed: (context) {
                Navigator.pushNamed(context, '/allCustomer');
              },
            ),
          ],
        ),
        SettingsSection(
          title: 'Courier',
          tiles: [
            SettingsTile(
              title: 'All Couriers',
              // subtitle: '',
              onPressed: (context) {
                Navigator.pushNamed(context, '/allCourier');
              },
            ),
          ],
        ),
        SettingsSection(
          title: 'More Settings',
          tiles: [
            SettingsTile(
              title: 'Payment',
              // subtitle: '',
              onPressed: (context) {
                Navigator.pushNamed(context, '/allPayment');
              },
            ),
            SettingsTile(
              title: 'Menu Order',
              // subtitle: '',
              onPressed: (context) {
                Navigator.pushNamed(context, '/allMenuOrder');
              },
            ),
            SettingsTile(
              title: 'My Profile',
              // subtitle: '',
              onPressed: (context) {
                Navigator.pushNamed(context, '/adminProfile');
              },
            ),
          ],
        ),
      ],
    );
  }
}
