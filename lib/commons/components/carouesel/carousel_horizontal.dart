import 'dart:async';

import 'package:flutter/material.dart';

import '../../../app/res/res.dart';
import '../../themes/themes.dart';

class CarouselHorizontal extends StatefulWidget {
  final Widget Function(BuildContext, int) itemBuilder;
  final int itemCount;
  final double mainAxisSpacing;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? scrollPhysics;
  final Future<dynamic> Function()? onLoadMore;
  final bool hasMore;
  final Offset? offsetLoading;

  const CarouselHorizontal({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
    this.mainAxisSpacing = AppDimens.s10,
    this.padding =
        const EdgeInsets.symmetric(horizontal: AppDimens.marginMedium),
    this.scrollPhysics = const BouncingScrollPhysics(),
    this.onLoadMore,
    this.hasMore = false,
    this.offsetLoading,
  });

  @override
  State<CarouselHorizontal> createState() => _CarouselHorizontalState();
}

class _CarouselHorizontalState extends State<CarouselHorizontal> {
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadMore() async {
    final completer = Completer<void>();

    setState(() {
      isLoading = true;
    });

    try {
      if (widget.onLoadMore == null) return;
      await widget.onLoadMore!();
      setState(() {
        isLoading = false;
      });
      completer.complete();
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      completer.completeError(error);
    }

    return completer.future;
  }

  void _onScroll() {
    final maxExtent = _scrollController.position.maxScrollExtent;
    if (_scrollController.position.pixels >= maxExtent) {
      if (widget.hasMore && !isLoading) {
        _loadMore();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: _scrollController,
      physics: widget.scrollPhysics,
      padding: widget.padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          widget.itemCount,
          (index) => Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? 0 : widget.mainAxisSpacing,
                ),
                child: widget.itemBuilder(context, index),
              ),
              if (isLoading && index == widget.itemCount - 1) ...[
                _buildLoader(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoader() {
    return Transform.translate(
      offset: widget.offsetLoading ?? Offset.zero,
      child: AnimatedContainer(
        duration: Constant.app.animatedDuration,
        height: isLoading ? AppDimens.s16 : 0,
        width: isLoading ? AppDimens.s16 : 0,
        margin: EdgeInsets.symmetric(horizontal: isLoading ? AppDimens.s24 : 0),
        child: const Center(
          child: CircularProgressIndicator.adaptive(
            strokeWidth: AppDimens.s2,
          ),
        ),
      ),
    );
  }
}
