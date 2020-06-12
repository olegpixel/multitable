import 'package:flutter/material.dart';
import 'package:multitables/widgets/styled_button.dart';
import 'package:multitables/datastore/progress_dao.dart';
import 'package:multitables/funcs/localisations.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void _cleanProgress() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context).translate('settings-screen_modal-title')),
          content: Text(AppLocalizations.of(context).translate('settings-screen_modal-desc')),
          actions: [
            FlatButton(
              child: Text(AppLocalizations.of(context).translate('settings-screen_modal-button-cancel')),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text(AppLocalizations.of(context).translate('settings-screen_modal-button-ok')),
              onPressed: () {
                clearAllStats();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        title: Text(AppLocalizations.of(context).translate('settings-screen_title'),
            style: TextStyle(
              color: Color(0xff3D3D74),
            )),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xff3D3D74)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 3.0, right: 15.0, left: 15.0),
              child: StyledButton(
                onPressed: _cleanProgress,
                text: AppLocalizations.of(context).translate('settings-screen_clear-progress'),
//                light: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
