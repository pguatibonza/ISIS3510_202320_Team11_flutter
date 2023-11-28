import 'dart:async';

//Observer pattern

abstract class Observer {
  void update();
}

// Subject Interface
abstract class Subject {
  void addObserver(Observer observer);
  void removeObserver(Observer observer);
  void notifyObservers();
}

class TimeController implements Subject {
  List<Observer> _observers = [];
  bool _isDarkMode;

  TimeController() : _isDarkMode = TimeController.isDarkModeNow() {
    timeStream().listen((hour) {
      bool wasDarkMode = _isDarkMode;
      _isDarkMode = TimeController.isDarkModeNow();
      if (wasDarkMode != _isDarkMode) {
        notifyObservers();
      }
    });
  }

  bool get isDarkMode => _isDarkMode;

  static bool isDarkModeNow() {
    final hour = DateTime.now().hour;
    return hour >= 18 || hour < 6;
  }

  @override
  void addObserver(Observer observer) {
    _observers.add(observer);
  }

  @override
  void removeObserver(Observer observer) {
    _observers.remove(observer);
  }

  @override
  void notifyObservers() {
    for (var observer in _observers) {
      observer.update();
    }
  }

  Stream<int> timeStream() async* {
    while (true) {
      await Future.delayed(Duration(seconds: 10));
      yield DateTime.now().hour;
    }
  }
}
