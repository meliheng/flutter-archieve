import 'package:anims/views/listview/cubits/cubit/get_notification_cubit.dart';
import 'package:anims/views/listview/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  
  int _calculateTotalItems(Map<String, List<NotificationModel>> groupedNotifications) {
    int total = 0;
    groupedNotifications.forEach((key, notifications) {
      total += 1; // header
      total += notifications.length; // notifications
    });
    return total;
  }
  
  Map<String, dynamic> _getItemAtIndex(Map<String, List<NotificationModel>> groupedNotifications, int index) {
    int currentIndex = 0;
    
    for (final entry in groupedNotifications.entries) {
      final dateKey = entry.key;
      final notifications = entry.value;
      
      // Check if this index is the header
      if (currentIndex == index) {
        return {'type': 'header', 'title': dateKey};
      }
      currentIndex++;
      
      // Check if this index is within the notifications for this date
      for (final notification in notifications) {
        if (currentIndex == index) {
          return {'type': 'notification', 'notification': notification};
        }
        currentIndex++;
      }
    }
    
    // Fallback (shouldn't happen)
    return {'type': 'error'};
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetNotificationCubit()..fetchNotifications(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notifications'),
          actions: [
            BlocBuilder<GetNotificationCubit, GetNotificationState>(
              builder: (context, state) {
                if (state is GetNotificationLoaded) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (state.isEditMode && state.selectedIndices.isNotEmpty) ...[
                        IconButton(
                          onPressed: () {
                            context.read<GetNotificationCubit>().deleteSelected();
                          },
                          icon: const Icon(Icons.delete),
                          tooltip: 'Delete Selected',
                        ),
                        IconButton(
                          onPressed: () {
                            context.read<GetNotificationCubit>().selectAll();
                          },
                          icon: const Icon(Icons.select_all),
                          tooltip: 'Select All',
                        ),
                      ],
                      IconButton(
                        onPressed: () {
                          context.read<GetNotificationCubit>().toggleEditMode();
                        },
                        icon: Icon(state.isEditMode ? Icons.done : Icons.edit),
                        tooltip: state.isEditMode ? 'Done' : 'Edit',
                      ),
                    ],
                  );
                }
                return IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<GetNotificationCubit, GetNotificationState>(
          builder: (context, state) {
            if (state is GetNotificationLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetNotificationLoaded) {
              final groupedNotifications = state.groupedNotifications;
              final notifications = state.notifications;
              
              return ListView.builder(
                itemCount: _calculateTotalItems(groupedNotifications),
                itemBuilder: (context, index) {
                  final item = _getItemAtIndex(groupedNotifications, index);
                  
                  if (item['type'] == 'header') {
                    return Container(
                      color: Colors.grey[100],
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                        child: Text(
                          item['title'] as String,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    );
                  } else {
                    final notification = item['notification'] as NotificationModel;
                    final globalIndex = notifications.indexOf(notification);
                    final isSelected = state.selectedIndices.contains(globalIndex);
                    
                    return ListTile(
                      key: ValueKey(notification.timestamp),
                      leading: state.isEditMode
                          ? Checkbox(
                              value: isSelected,
                              onChanged: (bool? value) {
                                context.read<GetNotificationCubit>().toggleSelection(globalIndex);
                              },
                            )
                          : null,
                      title: Text(notification.title),
                      subtitle: Text(notification.message),
                      trailing: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        switchInCurve: Curves.easeInOut,
                        switchOutCurve: Curves.easeInOut,
                        transitionBuilder: (Widget child, Animation<double> animation) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: state.isEditMode ? const Offset(1.0, 0.0) : const Offset(1.0, 0.0),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          );
                        },
                        child: state.isEditMode 
                            ? SizedBox.shrink()
                            : Container(
                                key: const ValueKey('normal_mode'),
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Handle button press
                                  },
                                  child: const Text('Action'),
                                ),
                              ),
                      ),
                      onTap: state.isEditMode
                          ? () {
                              context.read<GetNotificationCubit>().toggleSelection(globalIndex);
                            }
                          : null,
                    );
                  }
                },
              );
            } else if (state is GetNotificationError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
