import 'package:flutter/material.dart';

class AnimationCore {
  double value = 0.0;
  AnimationController _controller;
  Animation<double> animation;
  Curve _curve;
  Duration _duration;
  SingleTickerProviderStateMixin _stateWithTickerProvider;

  AnimationCore(SingleTickerProviderStateMixin stateWithTickerProvider,
      this._duration, this._curve) {
    _stateWithTickerProvider = stateWithTickerProvider;
    _controller = new AnimationController(
        duration: _duration, vsync: stateWithTickerProvider);
    animation = new CurvedAnimation(parent: _controller, curve: _curve);
    animation.addStatusListener((AnimationStatus status) {});
  }

  AnimationCore.defaultListener(
      SingleTickerProviderStateMixin stateWithTickerProvider,
      this._duration,
      this._curve) {
    _stateWithTickerProvider = stateWithTickerProvider;
    _controller = new AnimationController(
        duration: _duration, vsync: stateWithTickerProvider);
    animation = new CurvedAnimation(parent: _controller, curve: _curve);
    animation.addListener(() {
      if (value != animation.value) {
        value = animation.value;
        _stateWithTickerProvider.setState(() {});
      }
    });
    animation.addStatusListener((AnimationStatus status) {});
  }

  void addBeforeDefaultListener(VoidCallback listener) {
    animation.addListener(() {
      listener();

      if (value != animation.value) {
        value = animation.value;

        _stateWithTickerProvider.setState(() {});
      }
    });
  }

  double get animatedValue => animation.value;

  bool get isCompleted => animation.isCompleted;

  void addListener(VoidCallback listener) {
    animation.addListener(listener);
  }

  void duration(Duration duration) {
    _controller.duration = duration;
  }

  void reset() {
    _controller.reset();
  }

  void forward() {
    _controller.forward();
  }

  void repeat() {
    _controller.repeat();
  }

  void reverse() {
    _controller.reverse();
  }

  void dispose() {
    _controller.dispose();
  }
}
