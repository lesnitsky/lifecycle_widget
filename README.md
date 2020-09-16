# Lifecycle widget

Flutter widget with lifecycle methods

[![lesnitsky.dev](https://lesnitsky.dev/icons/shield.svg?hash=42)](https://lesnitsky.dev?utm_source=lifecycle_widget)
[![GitHub stars](https://img.shields.io/github/stars/lesnitsky/lifecycle_widget.svg?style=social)](https://github.com/lesnitsky/lifecycle_widget)
[![Twitter Follow](https://img.shields.io/twitter/follow/lesnitsky_dev.svg?label=Follow%20me&style=social)](https://twitter.com/lesnitsky_dev)

## Installation

Add dependency to `pubspec.yaml`

```yaml
dependencies:
  ...
  lifecycle_widget: ^0.0.1
```

Run in your terminal

```sh
flutter packages get
```

## Example

```dart
class TestWidget extends LifecycleWidget {
  final int number;

  const TestWidget({Key key, this.number}) : super(key: key);

  void notify(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }

  @override
  void didMount(BuildContext context) {
    notify(context, 'did mount');
    super.didMount(context);
  }

  @override
  void didUpdate(
    BuildContext context,
    covariant TestWidget oldWidget,
    covariant TestWidget widget,
  ) {
    notify(context, 'update ${oldWidget.number} => ${widget.number}');
    super.didUpdate(context, oldWidget, widget);
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("number is $number"));
  }
}
```

## License

MIT

[![lesnitsky.dev](https://lesnitsky.dev/icons/shield.svg?hash=42)](https://lesnitsky.dev?utm_source=lifecycle_widget)
[![GitHub stars](https://img.shields.io/github/stars/lesnitsky/lifecycle_widget.svg?style=social)](https://github.com/lesnitsky/lifecycle_widget)
[![Twitter Follow](https://img.shields.io/twitter/follow/lesnitsky_dev.svg?label=Follow%20me&style=social)](https://twitter.com/lesnitsky_dev)
