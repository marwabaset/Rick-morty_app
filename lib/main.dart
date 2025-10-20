import 'package:flutter/material.dart';
import 'package:rickandmorty_app/app_router.dart';

void main() {
  runApp( RickApp(appRouter: AppRouter(),));
}

class RickApp extends StatelessWidget {
 
  final AppRouter appRouter;

  const RickApp({super.key, required this.appRouter});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute:appRouter.generateRoute ,
    );
  }
}
