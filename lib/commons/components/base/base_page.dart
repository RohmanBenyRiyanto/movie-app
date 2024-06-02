import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';

class BasePage extends StatefulWidget {
  const BasePage({
    super.key,
    required this.body,
    this.appBar,
    this.onInit,
    this.onDispose,
    this.onLoadMore,
    this.blocProviders,
  });

  final PreferredSizeWidget? Function(bool isScroll)? appBar;
  final Widget body;
  final VoidCallback? onInit;
  final VoidCallback? onDispose;
  final VoidCallback? onLoadMore;
  final List<SingleChildWidget>? blocProviders;

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  final ScrollController _scrollController = ScrollController();
  bool isScroll = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    widget.onInit?.call();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    widget.onDispose?.call();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      widget.onLoadMore?.call();
    }

    if (_scrollController.offset > 12.0 && !isScroll) {
      setState(() {
        isScroll = true;
      });
    } else if (_scrollController.offset <= 12.0 && isScroll) {
      setState(() {
        isScroll = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.blocProviders != null) {
      return MultiBlocProvider(
        providers: widget.blocProviders ?? [],
        child: _buildContent(),
      );
    } else {
      return _buildContent();
    }
  }

  Scaffold _buildContent() {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: widget.appBar?.call(isScroll),
      body: ListView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        children: [
          widget.body,
        ],
      ),
    );
  }
}
