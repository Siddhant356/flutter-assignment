// import 'package:assigment/presentation/addDetail/pages/add_detail.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
//
// import '../../presentation/error/pages/error_screen.dart';
// import '../../presentation/home/pages/home_screen.dart';
// import 'app_route_constant.dart';
//
// class NyAppRouter {
//   static GoRouter router = GoRouter(
//       initialLocation: '/',
//       routes: <RouteBase>[
//         GoRoute(
//           name: AppRouteConstants.homeRouteName,
//           path: '/',
//           builder: (context, state) {
//             return const HomeScreen();
//           },
//         ),
//         GoRoute(
//           name: AppRouteConstants.addDetailsRouteName,
//           path: '/addDetails',
//           builder: (context, state){
//             return const AddDetail();
//           }
//         )
//       ],
//       errorPageBuilder: (context, state) {
//         return const MaterialPage(child: ErrorScreen());
//       },
//       // redirect: (_, state) {
//       //   if (FirebaseAuth.instance.currentUser == null && !(state.location.contains('/login'))) {
//       //     return '/login';
//       //   } else {
//       //     return null;
//       //   }
//       // }
//       );
// }
