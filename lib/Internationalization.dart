import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/**
 * 国际化
 */

class DemoLocalizations {
  final Locale locale;

  DemoLocalizations(this.locale);

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'titlehaha': 'First example list',
    },
    'zh': {
      'titlehaha': '第一个示例列表',
    }
  };

  get titlehaha {
    return _localizedValues[locale.languageCode]['titlehaha'];
  }

  //此处通过Localizations来获取到示例
  static DemoLocalizations of(BuildContext context) {
    return Localizations.of(context, DemoLocalizations);
  }
}

class DemoLocalizationsDelegate
    extends LocalizationsDelegate<DemoLocalizations> {
  const DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'zh'].contains(locale.languageCode);
  }

  @override
  Future<DemoLocalizations> load(Locale locale) {
    return new SynchronousFuture<DemoLocalizations>(
        new DemoLocalizations(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<DemoLocalizations> old) {
    return false;
  }

  static DemoLocalizationsDelegate delegate = const DemoLocalizationsDelegate();
}

/*************App 内语言切换 start*************/
class FreeLocalizations extends StatefulWidget {
  final Widget child;

  FreeLocalizations({Key key, this.child}) : super(key: key);

  @override
  State<FreeLocalizations> createState() {
    return new _FreeLocalizations();
  }
}

class _FreeLocalizations extends State<FreeLocalizations> {
  Locale _locale = const Locale('zh', 'CH');

  changeLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Localizations.override(
      context: context,
      locale: _locale,
      child: widget.child,
    );
  }
}

GlobalKey<_FreeLocalizations> freeLocalizationStateKey =
    new GlobalKey<_FreeLocalizations>();

bool flag = true;

void changeLocale() {
  if (flag) {
    freeLocalizationStateKey.currentState
        .changeLocale(const Locale('zh', "CH"));
  } else {
    freeLocalizationStateKey.currentState
        .changeLocale(const Locale('en', "US"));
  }
  flag = !flag;
}

/*************App 内语言切换 end*************/
