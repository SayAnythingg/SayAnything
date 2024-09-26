
class SettingsPageController {
  bool _locationPermission = false;
  bool _cameraPermission = false;
  bool _microphonePermission = false;
  bool _storagePermission = false;
  bool _notificationPermission = false;
  bool _contactsPermission = false;
  bool _calendarPermission = false;
  bool _healthDataPermission = false;

  bool get locationPermission => _locationPermission;
  bool get cameraPermission => _cameraPermission;
  bool get microphonePermission => _microphonePermission;
  bool get storagePermission => _storagePermission;
  bool get notificationPermission => _notificationPermission;
  bool get contactsPermission => _contactsPermission;
  bool get calendarPermission => _calendarPermission;
  bool get healthDataPermission => _healthDataPermission;

  void setLocationPermission(bool value) {
    _locationPermission = value;
  }

  void setCameraPermission(bool value) {
    _cameraPermission = value;
  }

  void setMicrophonePermission(bool value) {
    _microphonePermission = value;
  }

  void setStoragePermission(bool value) {
    _storagePermission = value;
  }

  void setNotificationPermission(bool value) {
    _notificationPermission = value;
  }

  void setContactsPermission(bool value) {
    _contactsPermission = value;
  }

  void setCalendarPermission(bool value) {
    _calendarPermission = value;
  }

  void setHealthDataPermission(bool value) {
    _healthDataPermission = value;
  }
}