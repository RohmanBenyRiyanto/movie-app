import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';

import '../../../app/res/res.dart';
import '../../themes/themes.dart';

class CarouselDots extends StatefulWidget {
  const CarouselDots({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
  });

  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;

  @override
  State<CarouselDots> createState() => _CenterCarouselState();
}

class _CenterCarouselState extends State<CarouselDots> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          child: InfiniteCarousel.builder(
            center: true,
            itemCount: widget.itemCount,
            itemExtent: MediaQuery.of(context).size.width * 0.8,
            loop: true,
            onIndexChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            axisDirection: Axis.horizontal,
            itemBuilder: (context, itemIndex, realIndex) {
              return widget.itemBuilder(context, itemIndex);
            },
          ),
        ),
        const SizedBox(height: 10),
        _CarouselDots(
          itemCount: widget.itemCount,
          currentIndex: _currentIndex,
        ),
      ],
    );
  }
}

class _CarouselDots extends StatelessWidget {
  final int itemCount;
  final int currentIndex;

  const _CarouselDots({
    required this.itemCount,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (index) => _AnimatedDot(
          isActive: index == currentIndex % itemCount,
        ),
      ),
    );
  }
}

class _AnimatedDot extends StatelessWidget {
  final bool isActive;
  static const double _dotSize = AppDimens.s8;
  static const Color _activeColor = AppColor.primary;
  static final Color _inactiveColor = Colors.white.withOpacity(0.5);

  const _AnimatedDot({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Constant.app.animatedDuration,
      margin: const EdgeInsets.symmetric(horizontal: 3.0),
      width: isActive ? (_dotSize * 1.5) : _dotSize,
      height: _dotSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimens.roundedExtraLarge),
        color: isActive ? _activeColor : _inactiveColor,
      ),
    );
  }
}
