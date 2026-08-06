import 'package:flutter/material.dart';
import 'package:flutter_material_drawer/flutter_material_drawer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material Drawer Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4F46E5),
          brightness: Brightness.light,
          surface: const Color(0xFFFFFFFF),
          surfaceContainerLow: const Color(0xFFF1F5F9),
          surfaceContainerHighest: const Color(0xFFE2E8F0),
        ),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      themeMode: ThemeMode.light,
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final MaterialDrawerController _drawerController;
  
  // Customization states
  DrawerType _currentDrawerType = DrawerType.rounded;
  Color _themeSelectedColor = const Color(0xFF4F46E5);
  Color _headerColor = const Color(0xFF4F46E5);
  double _elevation = 4.0;

  @override
  void initState() {
    super.initState();
    _drawerController = MaterialDrawerController();
    _drawerController.addListener(_onDrawerIndexChanged);
  }

  @override
  void dispose() {
    _drawerController.removeListener(_onDrawerIndexChanged);
    _drawerController.dispose();
    super.dispose();
  }

  void _onDrawerIndexChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Menu items configuration
    final menuItems = [
      const DrawerMenuItem(
        title: 'Dashboard',
        icon: Icons.dashboard_rounded,
        badge: 'New',
      ),
      const DrawerMenuItem(
        title: 'User Profile',
        icon: Icons.person_rounded,
      ),
      const DrawerMenuItem(
        title: 'Messages',
        icon: Icons.message_rounded,
        badge: '4',
      ),
      const DrawerMenuItem(
        title: 'Settings',
        icon: Icons.settings_rounded,
      ),
    ];

    // Theme configuration based on user customization settings
    final drawerTheme = MaterialDrawerTheme(
      backgroundColor: _currentDrawerType == DrawerType.dark ? const Color(0xff202124) : Colors.white,
      selectedColor: _themeSelectedColor,
      unselectedColor: _currentDrawerType == DrawerType.dark ? Colors.white70 : Colors.black87,
      iconColor: _currentDrawerType == DrawerType.dark ? Colors.white70 : Colors.black54,
      selectedIconColor: Colors.white,
      headerColor: _headerColor,
      dividerColor: _currentDrawerType == DrawerType.dark ? Colors.white12 : const Color(0xFFE0E0E0),
      elevation: _elevation,
      borderRadius: 24,
      itemRadius: 16,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _getPageTitle(_drawerController.selectedIndex),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
      ),
      drawer: MaterialDrawer(
        controller: _drawerController,
        items: menuItems,
        name: 'Jane Doe',
        email: 'jane.doe@example.com',
        handle: '@jane_doe_ux',
        followingCount: 184,
        followersCount: '4.8K',
        type: _currentDrawerType,
        theme: drawerTheme,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.surfaceContainerLow,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Display page content depending on selected drawer item
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _buildPageContent(_drawerController.selectedIndex),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getPageTitle(int index) {
    switch (index) {
      case 0:
        return 'Dashboard';
      case 1:
        return 'User Profile';
      case 2:
        return 'Messages';
      case 3:
        return 'Settings & Style';
      default:
        return 'Material Drawer';
    }
  }

  Widget _buildPageContent(int index) {
    switch (index) {
      case 0:
        return _buildDashboard();
      case 1:
        return _buildProfile();
      case 2:
        return _buildMessages();
      case 3:
      default:
        return _buildSettings();
    }
  }

  Widget _buildDashboard() {
    return ListView(
      key: const ValueKey('dashboard'),
      children: [
        _buildWelcomeCard(),
        const SizedBox(height: 16),
        const Text(
          'Quick Actions & Style Previews',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.4,
          children: [
            _buildStatCard('Classic Style', DrawerType.classic, Colors.blue),
            _buildStatCard('Rounded Design', DrawerType.rounded, Colors.purple),
            _buildStatCard('Gradient Look', DrawerType.gradient, Colors.deepOrange),
            _buildStatCard('Glassmorphism', DrawerType.glass, Colors.teal),
            _buildStatCard('Minimal Style', DrawerType.minimal, Colors.blueGrey),
            _buildStatCard('Twitter Style', DrawerType.twitter, const Color(0xFF1DA1F2)),
          ],
        ),
        const SizedBox(height: 20),
        _buildInfoCard(
          'Try customization!',
          'Go to the Settings tab in the drawer or click any drawer style above to quickly apply and visualize the change.',
          Icons.lightbulb_outline_rounded,
        ),
      ],
    );
  }

  Widget _buildWelcomeCard() {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.primaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back, Jane!',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Explore different drawer styles and components by opening the left-side drawer.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onPrimaryContainer.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Icon(
              Icons.waving_hand_rounded,
              size: 48,
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, DrawerType type, Color color) {
    final isCurrent = _currentDrawerType == type;
    return Card(
      elevation: isCurrent ? 4 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: isCurrent ? BorderSide(color: color, width: 2) : BorderSide.none,
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            _currentDrawerType = type;
            if (type == DrawerType.dark) {
              _headerColor = const Color(0xff303134);
            } else if (type == DrawerType.gradient) {
              _headerColor = Colors.transparent;
            } else if (type == DrawerType.twitter) {
              _headerColor = Colors.white;
              _themeSelectedColor = const Color(0xFF1DA1F2);
            } else {
              _headerColor = color;
            }
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Switched to ${type.name.toUpperCase()} Drawer Style!'),
              duration: const Duration(seconds: 1),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.style_rounded, size: 28, color: color),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                isCurrent ? 'Active' : 'Apply',
                style: TextStyle(
                  fontSize: 12,
                  color: isCurrent ? color : Colors.grey,
                  fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfile() {
    return Card(
      key: const ValueKey('profile'),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.indigo,
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),
            const SizedBox(height: 16),
            const Text(
              'Jane Doe',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
              'jane.doe@example.com',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const Divider(height: 40),
            _buildProfileDetailRow(Icons.phone, 'Phone', '+1 (555) 019-2834'),
            _buildProfileDetailRow(Icons.location_on, 'Location', 'San Francisco, CA'),
            _buildProfileDetailRow(Icons.work, 'Role', 'Lead UX Designer'),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 16),
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const Spacer(),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildMessages() {
    final messages = [
      {'sender': 'HR Team', 'subject': 'New Policy Guidelines', 'time': '10:30 AM', 'unread': true},
      {'sender': 'John Doe', 'subject': 'Feedback on Design Mockups', 'time': 'Yesterday', 'unread': true},
      {'sender': 'GitHub Alert', 'subject': 'Repository successfully cloned', 'time': '2 days ago', 'unread': false},
      {'sender': 'Support Hub', 'subject': 'Welcome to Antigravity IDE', 'time': '5 days ago', 'unread': false},
    ];

    return ListView.builder(
      key: const ValueKey('messages'),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final msg = messages[index];
        final isUnread = msg['unread'] as bool;
        return Card(
          elevation: isUnread ? 2 : 0,
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: isUnread ? Colors.red.shade100 : Colors.grey.shade200,
              child: Icon(
                isUnread ? Icons.mark_email_unread : Icons.drafts,
                color: isUnread ? Colors.red : Colors.grey,
              ),
            ),
            title: Text(
              msg['sender'] as String,
              style: TextStyle(fontWeight: isUnread ? FontWeight.bold : FontWeight.normal),
            ),
            subtitle: Text(msg['subject'] as String),
            trailing: Text(
              msg['time'] as String,
              style: TextStyle(color: isUnread ? Colors.blue : Colors.grey, fontSize: 12),
            ),
            onTap: () {},
          ),
        );
      },
    );
  }

  Widget _buildSettings() {
    return ListView(
      key: const ValueKey('settings'),
      children: [
        const Text(
          'Drawer Configuration',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Text(
          'Customize the drawer options and theme properties dynamically below:',
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        const SizedBox(height: 16),
        
        // Drawer Style selector
        const Text('Drawer Type Style', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: DrawerType.values.map((type) {
            return ChoiceChip(
              label: Text(type.name.toUpperCase()),
              selected: _currentDrawerType == type,
              onSelected: (selected) {
                if (selected) {
                  setState(() {
                    _currentDrawerType = type;
                    // Automatically adjust header color to match style
                    if (type == DrawerType.dark) {
                      _headerColor = const Color(0xff303134);
                    } else if (type == DrawerType.gradient) {
                      _headerColor = Colors.transparent;
                    } else if (type == DrawerType.twitter) {
                      _headerColor = Colors.white;
                      _themeSelectedColor = const Color(0xFF1DA1F2);
                    }
                  });
                }
              },
            );
          }).toList(),
        ),
        const Divider(height: 32),

        // Header Color selector
        const Text('Header Background Color', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          children: [
            Colors.blue,
            Colors.indigo,
            Colors.purple,
            Colors.teal,
            Colors.amber,
            Colors.red,
          ].map((color) {
            final isSelected = _headerColor == color;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _headerColor = color;
                });
              },
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: isSelected ? Border.all(color: Theme.of(context).colorScheme.primary, width: 3) : null,
                ),
              ),
            );
          }).toList(),
        ),
        const Divider(height: 32),

        // Selected item indicator color
        const Text('Selected Item Color', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          children: [
            Colors.blue,
            Colors.indigo,
            Colors.purple,
            Colors.teal,
            Colors.amber,
            Colors.red,
          ].map((color) {
            final isSelected = _themeSelectedColor == color;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _themeSelectedColor = color;
                });
              },
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: isSelected ? Border.all(color: Theme.of(context).colorScheme.primary, width: 3) : null,
                ),
              ),
            );
          }).toList(),
        ),
        const Divider(height: 32),

        // Elevation slider
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Drawer Elevation', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('${_elevation.toInt()}'),
          ],
        ),
        Slider(
          value: _elevation,
          min: 0,
          max: 16,
          divisions: 4,
          onChanged: (val) {
            setState(() {
              _elevation = val;
            });
          },
        ),
        const SizedBox(height: 16),
        _buildInfoCard(
          'Drawer Theme Properties',
          'We leverage MaterialDrawerTheme to define item margins, curves, backgrounds, and item selection colors. Slide from the left margin or tap the top-left menu icon to see your customized drawer!',
          Icons.info_outline_rounded,
        ),
      ],
    );
  }

  Widget _buildInfoCard(String title, String desc, IconData icon) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.secondary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    desc,
                    style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
