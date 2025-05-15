import 'package:auth_generator/views/generator_view.dart';
import 'package:auth_generator/views/settings.dart';
import 'package:fluent_ui/fluent_ui.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<NavigationPaneItem> get items => [
    PaneItem(
      icon: const Icon(FluentIcons.home),
      title: const Text('Home'),
      body: GeneratorView(),
    ),
  ];

  int topIndex = 0;
  PaneDisplayMode displayMode = PaneDisplayMode.auto;

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: const NavigationAppBar(
        title: Text('Auth Generator'),
        automaticallyImplyLeading: false,
      ),
      pane: NavigationPane(
        selected: topIndex,
        onItemPressed: (index) {
          // Do anything you want to do, such as:
          if (index == topIndex) {
            if (displayMode == PaneDisplayMode.open) {
              setState(() => displayMode = PaneDisplayMode.compact);
            } else if (displayMode == PaneDisplayMode.compact) {
              setState(() => displayMode = PaneDisplayMode.minimal);
            }
          }
        },
        onChanged: (index) => setState(() => topIndex = index),
        displayMode: displayMode,
        items: items,
        footerItems: [
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: const Text('Settings'),
            body: Settings(),
          ),
        ],
      ),
    );
  }
}
