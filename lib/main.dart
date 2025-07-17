import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/scan_page.dart';
import 'pages/result_page.dart';
import 'pages/history_page.dart';
import 'pages/profile_page.dart';
import 'providers.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ScanProvider()),
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  static const primaryColor = Color(0xFF0D47A1);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Matricule Checker',
      theme: ThemeData(
        primaryColor: primaryColor,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
            .copyWith(secondary: Colors.indigoAccent),
        scaffoldBackgroundColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor, // <-- fixed here
            minimumSize: Size(double.infinity, 48),
          ),
        ),
      ),
      initialRoute: LoginPage.routeName,
      routes: {
        LoginPage.routeName: (_) => LoginPage(),
        HomePage.routeName: (_) => HomePage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == ScanPage.routeName) {
          final args = settings.arguments as Map<String, dynamic>?;
          return MaterialPageRoute(
            builder: (_) => ScanPage(
              role: args?['role'] ?? 'Agent',
              username: args?['username'] ?? '',
            ),
          );
        } else if (settings.name == ResultPage.routeName) {
          final args = settings.arguments as Map<String, dynamic>?;
          return MaterialPageRoute(
            builder: (_) => ResultPage(
              role: args?['role'] ?? 'Agent',
              username: args?['username'] ?? '',
            ),
          );
        } else if (settings.name == HistoryPage.routeName) {
          final args = settings.arguments as Map<String, dynamic>?;
          return MaterialPageRoute(
            builder: (_) => HistoryPage(
              role: args?['role'] ?? 'Agent',
              username: args?['username'] ?? '',
            ),
          );
        } else if (settings.name == ProfilePage.routeName) {
          final args = settings.arguments as Map<String, dynamic>?;
          return MaterialPageRoute(
            builder: (_) => ProfilePage(
              role: args?['role'] ?? 'Agent',
              username: args?['username'] ?? '',
            ),
          );
        }
        return null;
      },
    );
  }
}

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String _role = 'Agent';
  String _username = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      _role = args['role'] ?? 'Agent';
      _username = args['username'] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      ScanPage(role: _role, username: _username),
      HistoryPage(role: _role, username: _username),
      ProfilePage(role: _role, username: _username),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Accueil ($_role)'),
        backgroundColor: MyApp.primaryColor,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        selectedItemColor: MyApp.primaryColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Historique',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
