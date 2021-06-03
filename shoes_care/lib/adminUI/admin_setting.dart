import 'package:flutter/material.dart';
import 'package:shoes_care/app_theme.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shoes_care/authentication_service.dart';
import 'package:provider/provider.dart';
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
            SettingsTile(
              title: 'Logout',
              // subtitle: '',
              onPressed: (context) {
                //logout dialog
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext bc) {
                    return Container(
                      height: MediaQuery.of(context).size.height * .20,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Spacer(),
                                IconButton(
                                  icon: Icon(
                                    Icons.cancel,
                                    color: AppTheme.maroon,
                                    size: 25,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Are you sure you want to logout?",
                                  style: TextStyle(fontSize: 20, color: Colors.black),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
// ignore: deprecated_member_use
                                RaisedButton(
                                  child: Text('Yes'),
                                  color: Colors.black,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    context.read<AuthenticationService>().signOut();
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
