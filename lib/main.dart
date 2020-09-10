import 'package:auto_size_text/auto_size_text.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'app_localizations.dart';
import 'features/auth/data/repository_impl/auth_repository_impl.dart';
import 'features/auth/domain/repository/auth_repository.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/home/presentation/bloc/bloc.dart';
import 'features/home/presentation/pages/home_screen.dart';
import 'features/locale/presentation/pages/locale_detail_screen.dart';
import 'features/status/data/repository_impl/news_repository_impl.dart';
import 'features/status/data/repository_impl/status_repository_impl.dart';
import 'features/status/domain/repository/news_repository.dart';
import 'features/status/domain/repository/status_repository.dart';
import 'features/status/presentation/bloc/intl/bloc.dart';
import 'features/status/presentation/bloc/news/bloc.dart';
import 'features/status/presentation/bloc/status/bloc.dart';
import 'messaging_service.dart';
import 'navigator_service.dart';
import 'services/storage/file_storage.dart';
import 'utils/colors.dart';
import 'utils/theme.dart';

///
/// Main Flutter Application
///
void main() async {
  // Set `enableInDevMode` to true to see reports while in debug mode
  // This is only to be used for confirming that reports are being
  // submitted as expected. It is not intended to be used for everyday
  // development.
  Crashlytics.instance.enableInDevMode = true;

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = await HydratedBlocDelegate.build();

  final MessagingService _messangerService = MessagingProvider.service;

  _messangerService.notificationAppLaunchDetails = await _messangerService.flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  var initializationSettingsAndroid = new AndroidInitializationSettings('@mipmap/launcher_icon');

  // Note: permissions aren't requested here just to demonstrate that can be done later using the `requestPermissions()` method
  // of the `IOSFlutterLocalNotificationsPlugin` class
  var initializationSettingsIOS = IOSInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
    onDidReceiveLocalNotification: (int id, String title, String body, String payload) async {
      _messangerService.didReceiveLocalNotificationSubject.add(
        ReceivedNotification(
          id: id,
          title: title,
          body: body,
          payload: payload,
        ),
      );
    },
  );
  var initializationSettings = InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);

  await _messangerService.flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onSelectNotification: (String payload) async {
      if (payload != null) {
        debugPrint('notification payload: ' + payload);
      }
      _messangerService.selectNotificationSubject.add(payload);
    },
  );

  return runApp(
    NavigatorProvider(
      child: NCovaApp(),
    ),
  );
}

class NCovaApp extends StatefulWidget {
  @override
  State<NCovaApp> createState() => _NCovaAppState();
}

class _NCovaAppState extends State<NCovaApp> {
  ThemeData daintyTheme;

  final NewsRepositoryImpl _newsRepository = NewsRepositoryImpl();
  final AuthRepositoryImpl _authRepository = AuthRepositoryImpl();

  @override
  void initState() {
    daintyTheme = buildDaintyTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final NavigatorService _service = NavigatorProvider.of(context).service;

    final StatusRepositoryImpl _statusRepository = StatusRepositoryImpl(
      fileStorage: const FileStorage(
        '__ncova_app__',
        getApplicationDocumentsDirectory,
      ),
      service: _service,
    );

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<StatusRepository>(create: (context) => _statusRepository),
        RepositoryProvider<NewsRepository>(create: (context) => _newsRepository),
        RepositoryProvider<AuthRepository>(create: (context) => _authRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(authRepository: _authRepository),
          ),
          BlocProvider<HomeBloc>(
            create: (context) => HomeBloc(),
          ),
          BlocProvider<StatusBloc>(
            create: (context) => StatusBloc(
              statusRepository: _statusRepository,
              context: context,
            ),
          ),
          BlocProvider<IntlBloc>(
            create: (context) => IntlBloc(intlRepository: _statusRepository),
          ),
          BlocProvider<NewsBloc>(
            create: (context) => NewsBloc(
              newsRepository: _newsRepository,
              context: context,
            ),
          ),
          // Add additional BlocProviders.
        ],
        child: MaterialApp(
          navigatorKey: _service.navigatorKey,
          title: "unCOVID",
          theme: daintyTheme,
          debugShowCheckedModeBanner: false,
          home: NCovaAppChild(),
          // List all the app's supported Locale's here
          supportedLocales: [
            Locale('en'),
            Locale('zh'),
          ],
          // These delegates make sure that the localization data for the proper language is loaded
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          // Returns a locale which will be used by the app
          localeListResolutionCallback: (locale, supportedLocales) {
            // Check if the current device locale is supported
            for (var supportedLocale in supportedLocales) {
              if (locale.contains(supportedLocale)) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: MessagingProvider.analytics),
          ],
        ),
      ),
    );
  }
}

class NCovaAppChild extends StatefulWidget {
  @override
  _NCovaAppChildState createState() => _NCovaAppChildState();
}

class _NCovaAppChildState extends State<NCovaAppChild> {
  NavigatorService _service;

  final MessagingService _messangerService = MessagingProvider.service;

  @override
  void initState() {
    final FirebaseMessaging _messanger = MessagingProvider.messanger;
    // Log in user anonymously
    BlocProvider.of<AuthBloc>(context).add(AuthEvent.signIn);

    _messanger.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onBackgroundMessage: MessagingProvider.backgroundMessageHandler,
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    _messanger.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });

    super.initState();
  }

  void _configureDidReceiveLocalNotificationSubject() {
    _messangerService.didReceiveLocalNotificationSubject.stream.listen((ReceivedNotification receivedNotification) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null ? Text(receivedNotification.title) : null,
          content: receivedNotification.body != null ? Text(receivedNotification.body) : null,
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Ok'),
              onPressed: () async {
                BlocProvider.of<StatusBloc>(context).add(LoadStatuses());
              },
            )
          ],
        ),
      );
    });
  }

  void _configureSelectNotificationSubject() {
    _messangerService.selectNotificationSubject.stream.listen((String payload) async {
      BlocProvider.of<StatusBloc>(context).add(LoadStatuses());
    });
  }

  @override
  void dispose() {
    _messangerService.didReceiveLocalNotificationSubject.close();
    _messangerService.selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _service = NavigatorProvider.of(context).service;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            _service.recyclingPopHandler();
          },
        ),
        actions: <Widget>[
          DropdownButton<String>(
            icon: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _dataTitle(),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Image.asset(
                      'assets/images/database.png',
                      width: 20,
                      height: 20,
                      color: DaintyColors.nearlyWhite,
                    ),
                  ),
                ],
              ),
            ),
            underline: Container(
              height: 0,
              color: Colors.transparent,
            ),
            onChanged: (String newValue) {
              setState(
                () {
                  if (newValue.contains('Worldometers')) {
                    _service.statusCollection = Firestore.instance.collection('statusWOM');
                  } else if (newValue.contains('BNO News')) {
                    _service.statusCollection = Firestore.instance.collection('statusBNO');
                  } else if (newValue.contains('John Hopkins University')) {
                    _service.statusCollection = Firestore.instance.collection('statusJHU');
                  }
                  // Then populate with the new state.
                  BlocProvider.of<IntlBloc>(context).add(LoadIntl());
                  BlocProvider.of<StatusBloc>(context).add(LoadStatuses());

                  // Bug where index is out of range on LocalDetailScreen
                  if (_service.currentPage is LocaleDetailScreen) {
                    LocaleDetailScreen.cardIndex = 0;
                  }
                },
              );
            },
            items: <String>['Worldometers', 'BNO News', 'John Hopkins University'].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(color: DaintyColors.darkerText),
                ),
              );
            }).toList(),
          )
        ],
      ),
      body: HomeScreen(),
    );
  }

  Widget _dataTitle() {
    switch (_service.statusCollection.id) {
      case 'statusBNO':
        return AutoSizeText(
          'BNO News',
          style: TextStyle(fontSize: 10),
        );
      case 'statusWOM':
        return AutoSizeText(
          'Worldometers',
          style: TextStyle(fontSize: 10),
        );
      case 'statusJHU':
        return AutoSizeText(
          'John Hopkins University',
          style: TextStyle(fontSize: 10),
        );
      default:
        return AutoSizeText(
          'Worldometers',
          style: TextStyle(fontSize: 10),
        );
    }
  }
}
