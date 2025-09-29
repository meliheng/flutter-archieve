import 'package:anims/cubits/custom_page_view/cubit/custom_page_view_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomPageView extends StatelessWidget {
  const CustomPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomPageViewCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Custom Page View')),
        body: BlocBuilder<CustomPageViewCubit, CustomPageViewState>(
          builder: (context, state) {
            if (state is! CustomPageViewInitial) {
              return SizedBox.shrink();
            }
            final cubit = context.read<CustomPageViewCubit>();
            return Column(
              children: [
                if (cubit.pageController.hasClients &&
                    cubit.pageController.page?.toInt() == 1)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'COLOR SELECTION',
                      style: TextStyle(
                        fontSize: 16,
                        color: state.selectedColor ?? Colors.black,
                      ),
                    ),
                  ),
                Expanded(
                  child: PageView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: cubit.pageController,
                    children: [
                      _NumberSelection(),
                      _ColorSelection(),
                      Container(
                        color: Colors.blue,
                        child: const Center(child: Text('Page 3')),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        bottomSheet: BlocBuilder<CustomPageViewCubit, CustomPageViewState>(
          builder: (context, state) {
            if (state is! CustomPageViewInitial) {
              return SizedBox.shrink();
            }
            final cubit = context.read<CustomPageViewCubit>();
            return SafeArea(
              child: ElevatedButton.icon(
                onPressed: state.isNavigating ? null : () async {
                  if (state.selectedIndex != -1 &&
                      cubit.pageController.page?.toInt() == 0) {
                    await cubit.navigateToNextPage();
                  } else if (state.selectedColor != null &&
                      cubit.pageController.page?.toInt() == 1) {
                    showAboutDialog(
                      context: context,
                      applicationName: 'Selected Color',
                      applicationVersion:
                          'Color: ${state.selectedColor.toString()}',
                      children: [
                        Text(
                          'You selected color: ${state.selectedColor.toString()}',
                        ),
                      ],
                    );
                  }
                },
                label: state.isNavigating 
                    ? Text("Loading...") 
                    : Text("Continue"),
                icon: state.isNavigating 
                    ? SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Icon(Icons.arrow_forward),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _NumberSelection extends StatelessWidget {
  const _NumberSelection();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 100,
      itemBuilder: (context, index) {
        return ListTile(
          tileColor: index % 2 == 0 ? Colors.grey[200] : Colors.white,
          title: Text('Item $index'),
          onTap: () {
            context.read<CustomPageViewCubit>().setIndex(index);
          },
        );
      },
    );
  }
}

class _ColorSelection extends StatelessWidget {
  const _ColorSelection();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 100,
      itemBuilder: (context, index) {
        return ListTile(
          tileColor: index % 2 == 0 ? Colors.grey[200] : Colors.white,
          title: Text('Color $index'),
          onTap: () {
            context.read<CustomPageViewCubit>().setColor(
              Colors.primaries[index % Colors.primaries.length],
            );
          },
        );
      },
    );
  }
}
