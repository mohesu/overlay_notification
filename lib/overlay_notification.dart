library overlay_notification;

export 'src/notification/notification.dart';
export 'src/notification/overlay_notification.dart';
export 'src/overlay.dart';
export 'src/overlay_keys.dart' hide KeyedOverlay;
export 'src/theme.dart';
export 'src/toast/toast.dart';
export 'src/overlay_state_finder.dart'
    hide findOverlayState, OverlayNotificationState;

/// The length of time the notification is fully displayed.
Duration kNotificationDuration = const Duration(milliseconds: 2000);

/// Notification display or hidden animation duration.
Duration kNotificationSlideDuration = const Duration(milliseconds: 300);
