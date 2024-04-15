import 'package:flutter/widgets.dart';
import 'package:mudara_steel_app/common/scale_factors.dart';
import 'package:mudara_steel_app/common/screen_size.dart';
import 'package:mudara_steel_app/common/spacing.dart';


import 'breakpoints.dart';


typedef ResponsiveLayoutWidgetBuilder = Widget Function(BuildContext, Widget?);

class ResponsiveLayoutBuilder extends StatelessWidget {
  const ResponsiveLayoutBuilder({
    Key? key,
    required this.small,
    required this.medium,
    required this.large,
    required this.xLarge,
    this.child,
  }) : super(key: key);
  final ResponsiveLayoutWidgetBuilder small;
  final ResponsiveLayoutWidgetBuilder medium;
  final ResponsiveLayoutWidgetBuilder large;
  final ResponsiveLayoutWidgetBuilder xLarge;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < DeviceBreakpoints.small) {
          DeviceScreenSize.screenSize = ScreenSize.small;
          AppSpacings.scaleFactor = DeviceScaleFactors.smallScaleFactor;
          return small(context, child);
        } else if (constraints.maxWidth < DeviceBreakpoints.medium) {
          DeviceScreenSize.screenSize = ScreenSize.medium;
          AppSpacings.scaleFactor = DeviceScaleFactors.mediumScaleFactor;
          return medium(context, child);
        } else if (constraints.maxWidth < DeviceBreakpoints.large) {
          DeviceScreenSize.screenSize = ScreenSize.large;
          AppSpacings.scaleFactor = DeviceScaleFactors.largeScaleFactor;
          return large(context, child);
        } else {
          DeviceScreenSize.screenSize = ScreenSize.xLarge;
          AppSpacings.scaleFactor = DeviceScaleFactors.xLargeScaleFactor;
          return xLarge(context, child);
        }
      },
    );
  }
}
