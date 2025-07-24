import 'package:anims/views/listview/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

part 'get_notification_state.dart';

class GetNotificationCubit extends Cubit<GetNotificationState> {
  GetNotificationCubit() : super(GetNotificationInitial());
  
  bool _isEditMode = false;
  Set<int> _selectedIndices = <int>{};
  
  Map<String, List<NotificationModel>> _groupNotificationsByDate(List<NotificationModel> notifications) {
    final grouped = <String, List<NotificationModel>>{};
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    
    for (final notification in notifications) {
      final notificationDate = DateTime(
        notification.timestamp.year,
        notification.timestamp.month,
        notification.timestamp.day,
      );
      
      String dateKey;
      if (notificationDate == today) {
        dateKey = 'Bugün';
      } else if (notificationDate == yesterday) {
        dateKey = 'Dün';
      } else {
        dateKey = DateFormat('d MMMM yyyy').format(notificationDate);
      }
      
      if (!grouped.containsKey(dateKey)) {
        grouped[dateKey] = [];
      }
      grouped[dateKey]!.add(notification);
    }
    
    // Sort each group by timestamp (newest first)
    grouped.forEach((key, notifications) {
      notifications.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    });
    
    return grouped;
  }
  
  Future<void> fetchNotifications() async {
    try {
      emit(GetNotificationLoading());
      // Simulate a network call or data fetching
      await Future.delayed(const Duration(seconds: 2));
      // Replace with actual data fetching logic
      final notifications = NotificationModel.notifications;
      final grouped = _groupNotificationsByDate(notifications);
      
      emit(GetNotificationLoaded(
        notifications: notifications,
        groupedNotifications: grouped,
        isEditMode: _isEditMode,
        selectedIndices: _selectedIndices,
      ));
    } catch (e) {
      emit(GetNotificationError(e.toString()));
    }
  }

  void toggleEditMode() {
    _isEditMode = !_isEditMode;
    if (!_isEditMode) {
      _selectedIndices.clear();
    }
    
    if (state is GetNotificationLoaded) {
      final currentState = state as GetNotificationLoaded;
      emit(GetNotificationLoaded(
        notifications: currentState.notifications,
        groupedNotifications: currentState.groupedNotifications,
        isEditMode: _isEditMode,
        selectedIndices: _selectedIndices,
      ));
    }
  }

  void toggleSelection(int index) {
    if (_selectedIndices.contains(index)) {
      _selectedIndices.remove(index);
    } else {
      _selectedIndices.add(index);
    }
    
    if (state is GetNotificationLoaded) {
      final currentState = state as GetNotificationLoaded;
      emit(GetNotificationLoaded(
        notifications: currentState.notifications,
        groupedNotifications: currentState.groupedNotifications,
        isEditMode: _isEditMode,
        selectedIndices: Set.from(_selectedIndices),
      ));
    }
  }

  void selectAll() {
    if (state is GetNotificationLoaded) {
      final currentState = state as GetNotificationLoaded;
      _selectedIndices = Set.from(List.generate(currentState.notifications.length, (index) => index));
      emit(GetNotificationLoaded(
        notifications: currentState.notifications,
        groupedNotifications: currentState.groupedNotifications,
        isEditMode: _isEditMode,
        selectedIndices: Set.from(_selectedIndices),
      ));
    }
  }

  void deselectAll() {
    _selectedIndices.clear();
    if (state is GetNotificationLoaded) {
      final currentState = state as GetNotificationLoaded;
      emit(GetNotificationLoaded(
        notifications: currentState.notifications,
        groupedNotifications: currentState.groupedNotifications,
        isEditMode: _isEditMode,
        selectedIndices: Set.from(_selectedIndices),
      ));
    }
  }

  void deleteSelected() {
    if (state is GetNotificationLoaded) {
      final currentState = state as GetNotificationLoaded;
      final updatedNotifications = <NotificationModel>[];
      
      for (int i = 0; i < currentState.notifications.length; i++) {
        if (!_selectedIndices.contains(i)) {
          updatedNotifications.add(currentState.notifications[i]);
        }
      }
      
      _selectedIndices.clear();
      final grouped = _groupNotificationsByDate(updatedNotifications);
      
      emit(GetNotificationLoaded(
        notifications: updatedNotifications,
        groupedNotifications: grouped,
        isEditMode: _isEditMode,
        selectedIndices: Set.from(_selectedIndices),
      ));
    }
  }
}
  
  