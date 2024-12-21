import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'landlord.dart';
import 'about.dart';
import 'rentar.dart'; // Rentar Page को import करें
import 'login.dart'; // Admin Page को import करें
import 'package:com.dajweb.rentalhome/data/disclaimer.dart';
import 'package:com.dajweb.rentalhome/data/policy_page.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback toggleTheme; // Theme toggle callback
  final bool isDarkTheme; // Theme mode

  const HomeScreen(
      {super.key, required this.toggleTheme, required this.isDarkTheme});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool _isAppBarVisible = true;
  bool _isNavBarVisible = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      _toggleVisibility(true);
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      _toggleVisibility(false);
    }
  }

  void _toggleVisibility(bool isVisible) {
    setState(() {
      _isAppBarVisible = isVisible;
      _isNavBarVisible = isVisible;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String _getAppBarTitle() {
    switch (_selectedIndex) {
      case 0:
        return 'Bhola Rental Home Service';
      case 1:
        return 'Houses Detail Dashboard';
      case 2:
        return 'Landlord Form';
      case 3:
        return 'About';
      default:
        return 'Home';
    }
  }

  Widget _getScreen() {
    switch (_selectedIndex) {
      case 0:
        return _buildHomeContent(); // Static page
      case 1:
        return RenterScreen(scrollController: _scrollController); // Rentar page
      case 2:
        return const LandlordForm(); // Landlord page
      case 3:
        return const Aboutpage(); // About page
      default:
        return const Center(child: Text('Home'));
    }
  }

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Rental Home किराये का घर',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          const Text(
              'भारत में किराये का घर सेवा \nउपलब्ध करने के लिए समर्पित पहला Rental Home ऐप',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(height: 20),
          Image.asset(
            'assets/images/home_icon.png',
            height: 150,
          ),
          const SizedBox(height: 20),
          const Text(
            'हमारा मकसद है कि हम आपको सबसे अच्छा किराये का घर उपलब्ध कराएं।',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isAppBarVisible
          ? AppBar(
              title: Text(
                _getAppBarTitle(),
                style: Theme.of(context)
                    .textTheme
                    .titleLarge, // Default text style
              ),
              backgroundColor: Theme.of(context)
                  .appBarTheme
                  .backgroundColor, // Default AppBar color
              iconTheme: Theme.of(context).iconTheme, // Default icon theme
              elevation: 4.0, // Add shadow/elevation to AppBar
              actions: [
                IconButton(
                  icon: Icon(
                    widget.isDarkTheme
                        ? Icons.dark_mode
                        : Icons.light_mode, // Theme toggle icon
                  ),
                  onPressed:
                      widget.toggleTheme, // Call the passed toggle function
                  color:
                      Theme.of(context).iconTheme.color, // Default icon color
                ),
              ],
            )
          : null,
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF0072FF),
                    Color(0xFF00C6FF),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage('assets/images/admin.webp'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Welcome to Bhola Rental',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Your trusted rental service',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.blue),
              title: const Text('Home'),
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.orange),
              title: const Text('Renter'),
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.business, color: Colors.green),
              title: const Text('Landlord'),
              onTap: () {
                _onItemTapped(2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info, color: Colors.teal),
              title: const Text('About'),
              onTap: () {
                _onItemTapped(3);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.description, color: Colors.blueGrey),
              title: const Text('Disclaimer'),
              onTap: () {
                Navigator.pop(context); // Drawer को बंद करें
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DisclaimerPage(
                      toggleTheme: widget.toggleTheme,
                      isDarkTheme: widget.isDarkTheme,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.policy, color: Colors.indigo),
              title: const Text('Privacy Policy'),
              onTap: () {
                Navigator.pop(context); // Drawer को बंद करें
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PrivacyPolicyPage(
                      isDarkTheme: widget.isDarkTheme,
                      toggleTheme: widget.toggleTheme,
                    ),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading:
                  const Icon(Icons.admin_panel_settings, color: Colors.red),
              title: const Text('Admin'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
          Column(
            children: [
              Expanded(child: _getScreen()),
              if (_isNavBarVisible)
                BottomNavigationBar(
  currentIndex: _selectedIndex, // Ensure that the selected index is managed
  onTap: _onItemTapped, // Make sure your navigation logic is connected
  items: const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Renter',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Landlord',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.info),
      label: 'About',
    ),
  ],
  backgroundColor: Theme.of(context).colorScheme.surface, // Default background color
  selectedItemColor: Theme.of(context).colorScheme.primary, // Selected item color
  unselectedItemColor:
      Theme.of(context).colorScheme.onSurface.withOpacity(0.6), // Unselected item color
  type: BottomNavigationBarType.fixed, // Fixed layout
  elevation: 8.0, // Shadow added to BottomNavigationBar
  showUnselectedLabels: true, // Ensure unselected labels are shown
),


            ],
          ),
        ],
      ),
    );
  }
}

class DisclaimerPage extends StatelessWidget {
  final VoidCallback toggleTheme; // Theme toggle callback
  final bool isDarkTheme; // Theme mode

  const DisclaimerPage({super.key, required this.toggleTheme, required this.isDarkTheme});

  @override
  Widget build(BuildContext context) {
    return DisclaimerScreen(
      toggleTheme: toggleTheme,
      isDarkTheme: isDarkTheme,
    ); // Pass toggleTheme and isDarkTheme to DisclaimerScreen
  }
}

class PrivacyPolicyPage extends StatelessWidget {
  final bool isDarkTheme;
  final VoidCallback toggleTheme;

  const PrivacyPolicyPage({
    super.key,
    required this.isDarkTheme,
    required this.toggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    return PolicyPage(
      isDarkTheme: isDarkTheme,
      toggleTheme: toggleTheme,
    );
  }
}