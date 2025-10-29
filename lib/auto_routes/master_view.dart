import 'package:anims/auto_routes/app_router.dart';
import 'package:anims/auto_routes/popup_cubit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class MasterView extends StatefulWidget {
  const MasterView({super.key});

  @override
  State<MasterView> createState() => _MasterViewState();
}

class _MasterViewState extends State<MasterView> {
  @override
  void initState() {
    super.initState();
    context.read<PopupCubit>().isFromNotification = true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PopupCubit, bool>(
      listener: (context, state) {
        if (state) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Hoş geldin!'),
              content: const Text('Bunu sadece bir kez göreceksin 😄'),
              actions: [
                TextButton(
                  onPressed: () {
                    context.read<PopupCubit>().dismissPopup();
                    Navigator.pop(context);
                  },
                  child: const Text('Tamam'),
                ),
              ],
            ),
          );
        }
      },
      child: AutoTabsScaffold(
        routes: [
          const HomeRoute(),
          const ProfileRoute(),
          const SettingsRoute(),
          // const SettingsWrapper2(),
        ],
        bottomNavigationBuilder: (_, tabsRouter) {
          return BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          );
        },
      ),
    );
  }
}
