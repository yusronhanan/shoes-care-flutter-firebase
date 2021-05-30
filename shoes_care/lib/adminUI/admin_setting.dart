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
          title: 'Order Settings',
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
          ],
        ),
      ],
    );
  }
}
