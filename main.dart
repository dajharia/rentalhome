import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../screens/home.dart';
import 'firebase_options.dart';
import '../data/network_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkTheme = false;

  void _toggleTheme() {
    setState(() {
      _isDarkTheme = !_isDarkTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: _isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white, // AppBar background
          elevation: 4, // Shadow elevation
          iconTheme: const IconThemeData(color: Colors.blue),
          titleTextStyle: const TextStyle(
            color: Colors.blue,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          shadowColor: Colors.grey.withOpacity(0.5), // Shadow color
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: const Color.fromARGB(255, 232, 231, 231), // Background color
          elevation: 8, // Shadow elevation
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[900], // AppBar background for dark theme
          elevation: 4, // Shadow elevation
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          shadowColor: Colors.black.withOpacity(0.8), // Shadow color
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.grey[850], // Background color for dark theme
          elevation: 8, // Shadow elevation
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey,
        ),
        colorScheme: const ColorScheme.dark(
          primary: Colors.blueAccent,
          secondary: Colors.amberAccent,
        ),
      ),
      home: NetworkWrapper(
        child: HomeScreen(toggleTheme: _toggleTheme, isDarkTheme: _isDarkTheme),
      ),
    );
  }
}

class NetworkWrapper extends StatefulWidget {
  final Widget child;
  const NetworkWrapper({required this.child, super.key});

  @override
  _NetworkWrapperState createState() => _NetworkWrapperState();
}

class _NetworkWrapperState extends State<NetworkWrapper> {
  late final NetworkService _networkService;
  bool _isConnected = true;
  bool _showNotification = false;

  @override
  void initState() {
    super.initState();
    _networkService = NetworkService();
    _networkService.networkStream.listen((status) {
      setState(() {
        _isConnected = status;
        _showNotification = true;

        // कनेक्शन जुड़ने पर नोटिफिकेशन को 3 सेकंड में छुपाएं।
        if (status) {
          Future.delayed(const Duration(seconds: 3), () {
            if (mounted && _isConnected) {
              setState(() {
                _showNotification = false;
              });
            }
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          widget.child,
          if (_showNotification)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 35,
                color: _isConnected ? Colors.green : Colors.red,
                child: Center(
                  child: Text(
                    _isConnected
                        ? 'Connected to Internet'
                        : 'No Internet Connection',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _networkService.dispose();
    super.dispose();
  }
}
