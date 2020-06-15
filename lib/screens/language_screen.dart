import 'package:flutter/material.dart';
import 'package:multitables/funcs/app_lang.dart';
import 'package:multitables/main.dart';
import 'package:multitables/models/language.dart';
import 'package:multitables/funcs/localisations.dart';

class LanguageScreen extends StatefulWidget {
  static const routeName = '/lang';

  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  Locale _locale;
  List<Language> languageList;

  @override
  void _changeLanguage(String langCode) async {
    Locale _locale = await setLocale(langCode);
    MyApp.setLocale(context, _locale);
    setState(() {
      languageList.forEach((lang) {
        if (lang.languageCode == _locale.languageCode) {
          lang.selected = true;
        } else {
          lang.selected = false;
        }
      });
    });
  }

  Future<Null> getLocalPrefs() async {
    Locale l = await getLocale();
    setState(() {
      languageList.forEach((lang) {
        if (lang.languageCode == l.languageCode) {
          lang.selected = true;
        } else {
          lang.selected = false;
        }
      });
    });
  }

  void initState() {
    super.initState();
    languageList = [
      Language('English', 'combined-flag.png', 'en', false),
//      Language('Spanish', 'flag-spain.png', 'es', false),
      Language('Русский', 'flag-ru.png', 'ru', false),
    ];

    getLocalPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        title: Text(AppLocalizations.of(context).translate('language-screen_title'),
            style: TextStyle(
              color: Color(0xff3D3D74),
            )),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xff3D3D74)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: <Widget>[
          ...languageList.map((l) {
            return Container(
              child: ListTile(
                leading: Image(
                  image: AssetImage(
                    'assets/images/flags/' + l.flagIcon,
                  ),
                  width: 40.0,
                  height: 40.0,
                ),
                title: Text(l.name),
                onTap: () {
                  _changeLanguage(l.languageCode);
                },
                trailing: Icon(Icons.check, color: l.selected ? Color(0xff3D3D74) : Colors.transparent),
              ),
              decoration: new BoxDecoration(color: l.selected ? Color(0xffE3F0FF) : Colors.transparent),
            );
          }),
        ],
      ),
    );
  }
}
