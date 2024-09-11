import 'package:flutter/material.dart';

class TimeLeftPanel extends StatelessWidget {
  const TimeLeftPanel({
    super.key,
    required this.timeStart,
    required this.timeEnd,
    this.timePanelTopPadding = 30,
    this.timeStartTextStyle,
    this.timeEndTextStyle
  });

  final TimeOfDay timeStart;
  final TimeOfDay timeEnd;
  final double timePanelTopPadding;
  final TextStyle? timeStartTextStyle;
  final TextStyle? timeEndTextStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: timePanelTopPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(timeStart.format(context), style: timeStartTextStyle),
          Text(timeEnd.format(context), style: timeEndTextStyle)
        ],
      ),
    );
  }
}

class CardWithTimeOnLeft extends StatefulWidget {
  const CardWithTimeOnLeft({
    super.key,
    required this.timeStart,
    required this.timeEnd,
    required this.dividerColor,
    required this.child,
    this.color,
    this.timePanelTopPadding = 30,
    this.timeStartTextStyle,
    this.timeEndTextStyle,
    this.indicatorInitPercentage = 0,
    this.indicatorDuration = Duration.zero,
    this.onIndicatorEnd,
    this.showIndicator = false,
    this.indicatorColor
  });

  final TimeOfDay timeStart;
  final TimeOfDay timeEnd;
  final Color dividerColor;
  final Widget child;
  final Color? color;
  final double timePanelTopPadding;
  final TextStyle? timeStartTextStyle;
  final TextStyle? timeEndTextStyle;

  final double indicatorInitPercentage;
  final Duration indicatorDuration;
  final VoidCallback? onIndicatorEnd;
  final bool showIndicator;
  final Color? indicatorColor;

  @override
  State<StatefulWidget> createState() => _CardWithTimeOnLeftState();
}


class _CardWithTimeOnLeftState extends State<CardWithTimeOnLeft> with TickerProviderStateMixin {

  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.indicatorDuration
    );

    _controller.addListener(() => setState(() {}));
    final percentage = _getPercentage();
    if (percentage != 0) {
      _controller.forward(from: percentage)
          .then((value) => widget.onIndicatorEnd?.call());
    }

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final valueColor = widget.indicatorColor ?? Theme.of(context).colorScheme.primary;
    return Card(
      color: widget.color,
      child: IntrinsicHeight(
        child: Stack(
          fit: StackFit.expand,
          children: [
            widget.showIndicator ? LinearProgressIndicator(
              value: _controller.value,
              borderRadius: BorderRadius.circular(10),
              valueColor: AlwaysStoppedAnimation<Color>(valueColor.withOpacity(0.1)),
              backgroundColor: widget.color ?? Theme.of(context).colorScheme.surface,
            ) : const SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: TimeLeftPanel(
                        timeStart: widget.timeStart,
                        timeEnd: widget.timeEnd,
                        timePanelTopPadding: widget.timePanelTopPadding,
                        timeStartTextStyle: widget.timeStartTextStyle,
                        timeEndTextStyle: widget.timeEndTextStyle,
                      )
                  ),
                  VerticalDivider(thickness: 1, color: widget.dividerColor),
                  Expanded(
                    flex: 5,
                    child: widget.child,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  double _getPercentage() {
    if (widget.indicatorInitPercentage < 0 || widget.indicatorInitPercentage > 1) return 0;
    return widget.indicatorInitPercentage;
  }
}