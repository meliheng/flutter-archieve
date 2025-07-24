import 'package:anims/cubits/design_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CubitView extends StatefulWidget {
  const CubitView({super.key});

  @override
  State<CubitView> createState() => _CubitViewState();
}

class _CubitViewState extends State<CubitView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cubit View')),
      body: BlocProvider(
        create: (context) => DesignCubit(),
        child: Builder(
          builder: (context) {
            return Column(
              children: [
                if ((context.watch<DesignCubit>().state as DesignInitial)
                        .currentIndex ==
                    0)
                  Text('Current Index: vov'),
                Expanded(
                  child: PageView(
                    children: [
                      _FirstView(title: "Page 1"),
                      _SecondView(),
                      Center(
                        child: Column(
                          children: [
                            Text('Page 3'),
                            ElevatedButton(
                              onPressed: null,
                              child: Text('Go to Page 1'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _SecondView extends StatelessWidget {
  const _SecondView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text('Page 2'),
          ElevatedButton(onPressed: null, child: Text('Go to Page 3')),
        ],
      ),
    );
  }
}

class _FirstView extends StatelessWidget {
  const _FirstView({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    print("building _FirstView");
    return Center(
      child: Column(
        children: [
          _CustomText(),
          ElevatedButton(
            onPressed: () {
              context.read<DesignCubit>().changeIndex(1);
            },
            child: const Text('Go to Page 2'),
          ),
        ],
      ),
    );
  }
}

class _CustomText extends StatefulWidget {
  const _CustomText({super.key});

  @override
  State<_CustomText> createState() => _CustomTextState();
}

class _CustomTextState extends State<_CustomText> {
  @override
  void initState() {
    print("initState called");
    super.initState();
  }

  @override
  void didUpdateWidget(covariant _CustomText oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget called");
  }

  @override
  Widget build(BuildContext context) {
    return const Text('Page 1');
  }
}
