import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

class LifecycleElement extends ComponentElement {
  LifecycleWidget get widget => super.widget as LifecycleWidget;

  LifecycleElement(Widget widget) : super(widget);

  bool mounted = false;

  @override
  void mount(Element parent, newSlot) {
    super.mount(parent, newSlot);
    mounted = true;

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) widget.didMount(this);
    });
  }

  @override
  void update(LifecycleWidget newWidget) {
    final oldWidget = widget;
    super.update(newWidget);

    if (widget.shouldUpdate(this, oldWidget, newWidget)) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        if (mounted) widget.didUpdate(this, oldWidget, newWidget);
      });

      markNeedsBuild();
    }
  }

  @override
  void unmount() {
    mounted = false;
    widget.willUnmount();
    super.unmount();
  }

  @override
  Widget build() {
    return widget.build(this);
  }
}

@immutable
abstract class LifecycleWidget extends Widget {
  static bool debugLog = false;

  const LifecycleWidget({Key key}) : super(key: key);

  @override
  Element createElement() {
    return LifecycleElement(this);
  }

  bool shouldUpdate(
    BuildContext context,
    LifecycleWidget oldWidget,
    LifecycleWidget newWidget,
  ) {
    return true;
  }

  void didMount(BuildContext context) {
    assert(() {
      if (debugLog) {
        print('$runtimeType did mount');
      }

      return true;
    }());
  }

  void didUpdate(
    BuildContext context,
    LifecycleWidget oldWidget,
    LifecycleWidget widget,
  ) {
    assert(() {
      if (debugLog) {
        print('$runtimeType did update');
      }

      return true;
    }());
  }

  void willUnmount() {
    assert(() {
      if (debugLog) {
        print('$runtimeType will unmount');
      }

      return true;
    }());
  }

  Widget build(BuildContext context);
}