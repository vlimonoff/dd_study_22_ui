import 'package:dd_study_22_ui/data/services/auth_service.dart';
import 'package:dd_study_22_ui/ui/navigation/app_navigator.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});
  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _counter = 0;
  bool _showFab = true;
  bool _showNotch = true;
  final _authService = AuthService();

  FloatingActionButtonLocation _fabLocation =
      FloatingActionButtonLocation.endDocked;

  void _onShowNotchChanged(bool value) {
    setState(() {
      _showNotch = value;
    });
  }

  void _onShowFabChanged(bool val) {
    setState(() {
      _showFab = val;
    });
  }

  void _onFabLockationChanged(FloatingActionButtonLocation? loc) {
    setState(() {
      _fabLocation = loc ?? FloatingActionButtonLocation.endDocked;
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _logout() {
    _authService.logout().then((value) => AppNavigator.toLoader());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: _fabLocation,
      appBar: AppBar(
        title: Text("${widget.title} = $_counter"),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: _logout,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        children: [
          SwitchListTile(
            onChanged: _onShowNotchChanged,
            value: _showNotch,
            title: const Text("Notch"),
          ),
          SwitchListTile(
            onChanged: _onShowFabChanged,
            value: _showFab,
            title: const Text("Fab"),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(10),
            child: Text("Fab locations"),
          ),
          RadioListTile(
            title: const Text("centerDocked"),
            value: FloatingActionButtonLocation.centerDocked,
            groupValue: _fabLocation,
            onChanged: _onFabLockationChanged,
          ),
          RadioListTile(
            title: const Text("centerFloat"),
            value: FloatingActionButtonLocation.centerFloat,
            groupValue: _fabLocation,
            onChanged: _onFabLockationChanged,
          ),
          RadioListTile(
            title: const Text("endDocked"),
            value: FloatingActionButtonLocation.endDocked,
            groupValue: _fabLocation,
            onChanged: _onFabLockationChanged,
          ),
          RadioListTile(
            title: const Text("endFloat"),
            value: FloatingActionButtonLocation.endFloat,
            groupValue: _fabLocation,
            onChanged: _onFabLockationChanged,
          ),
        ],
      ),
      floatingActionButton: !_showFab
          ? null
          : Wrap(
              children: [
                FloatingActionButton(
                  onPressed: _incrementCounter,
                  tooltip: 'Increment',
                  child: const Icon(Icons.access_alarm),
                ),
              ],
            ),
      bottomNavigationBar: _BottomAppBarTest(
        fabLocation: _fabLocation,
        shape: _showNotch ? const CircularNotchedRectangle() : null,
      ),
    );
  }
}

class _BottomAppBarTest extends StatelessWidget {
  _BottomAppBarTest({
    required this.fabLocation,
    this.shape,
  });

  final FloatingActionButtonLocation fabLocation;
  final CircularNotchedRectangle? shape;
  final List<FloatingActionButtonLocation> centerVariants = [
    FloatingActionButtonLocation.centerDocked,
    FloatingActionButtonLocation.centerFloat,
  ];

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: shape,
      color: Colors.amberAccent,
      child: Row(
        mainAxisAlignment: centerVariants.contains(fabLocation)
            ? MainAxisAlignment.spaceAround
            : MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
