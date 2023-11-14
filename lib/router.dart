import 'package:go_router/go_router.dart';

import 'presentation/screens/screens.dart';

enum AppRoutes {
  player(path: '/'),
  addPlanet(path: '/add-planet');

  final String path;

  const AppRoutes({required this.path});
}

final router = GoRouter(
  routes: [
    GoRoute(
      path: AppRoutes.player.path,
      builder: (_, __) => const PlayerScreen(),
    ),
    GoRoute(
      path: AppRoutes.addPlanet.path,
      builder: (_, __) => const AddPlanetScreen(),
    ),
  ],
);
