// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:productos_app/screens/chats/chathome.dart';
import 'package:productos_app/screens/homescreens/admin_screens/admin_perfil_screen.dart';
import 'package:productos_app/screens/screens.dart';

final appRouter =GoRouter(
  //Aqui se formula las rutas de navegacion entre la screens para no saturar el main
  initialLocation: '/splash',
  routes: [
    //Inicio
    GoRoute(
     path:'/splash', //nombre de la ruta 
     builder:(context, state)=> const Splash(),
    ),
    GoRoute(
     path:'/loginscreen', //nombre de la ruta 
     builder:(context, state)=> const LoginScreen(),
    ),
    GoRoute(
     path:'/registerscreen', //nombre de la ruta 
     builder:(context, state)=> const RegisterScreen(),
    ),
    
    //Home Screen
    GoRoute(
      path: '/',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const HomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Change the opacity of the screen using a Curve based on the the animation's
            // value
            return FadeTransition(
              opacity:
                  CurveTween(curve: Curves.easeInOutCirc).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
        GoRoute(
      path: '/favoriscreen',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const FavoritScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Change the opacity of the screen using a Curve based on the the animation's
            // value
            return FadeTransition(
              opacity:
                  CurveTween(curve: Curves.easeInOutCirc).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
        GoRoute(
      path: '/gpsscreen',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const GpsScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Change the opacity of the screen using a Curve based on the the animation's
            // value
            return FadeTransition(
              opacity:
                  CurveTween(curve: Curves.easeInOutCirc).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
        GoRoute(
      path: '/perfilscreen',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const PerfilScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Change the opacity of the screen using a Curve based on the the animation's
            // value
            return FadeTransition(
              opacity:
                  CurveTween(curve: Curves.easeInOutCirc).animate(animation),
              child: child,
            );
          },
        );
      },
    ),

    GoRoute(
     path:'/chat',//nombre de la ruta que acorta lo de abajo
     builder:(context, state)=> const ChatScreen(title: '',),
    ),
    GoRoute(
     path:'/chat2',//nombre de la ruta que acorta lo de abajo
     builder:(context, state)=> ChatHome(),
    ),
    
    //rutas Categorias
    GoRoute(
     path:'/irmedicinal',//nombre de la ruta que acorta lo de abajo
     builder:(context, state)=> const CatMedScreen(),
    ),
    GoRoute(
     path:'/irarboles',//nombre de la ruta que acorta lo de abajo
     builder:(context, state)=> const CatArbolScreen(),
    ),
    GoRoute(
     path:'/irotros',//nombre de la ruta que acorta lo de abajo
     builder:(context, state)=> const CatOtroScreen(),
    ),
    GoRoute(
     path:'/irornamental',//nombre de la ruta que acorta lo de abajo
     builder:(context, state)=>  const CatOrnaScreen(),
    ),
    GoRoute(
     path:'/search',//nombre de la ruta jo
     builder:(context, state)=> const SearchScreen(),
    ),
    //Admin Home
    GoRoute(
     path:'/adminhome',//nombre de la ruta que acorta lo de abajo
     builder:(context, state)=> const AdminHomeScreen(),
    ),
    GoRoute(
     path:'/adminperfil',//nombre de la ruta que acorta lo de abajo
     builder:(context, state)=> const AdminPerfilScreen(),
    ),
    GoRoute(
     path:'/upimagen',//nombre de la ruta que acorta lo de abajo
     builder:(context, state)=> const UpImageScreen(),
    ),
  ],
  
);