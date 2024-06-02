import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';

abstract class BaseScrollPage extends StatefulWidget {
  const BaseScrollPage({super.key});

  @override
  BaseScrollPageState createState();
}

abstract class BaseScrollPageState<T extends BaseScrollPage> extends State<T> {
  final ScrollController _scrollController = ScrollController();
  bool isScroll = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    onInit();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    onDispose();
    super.dispose();
  }

  void onInit() {
    // Method to be overridden by subclasses for additional initialization.
  }

  void onDispose() {
    // Method to be overridden by subclasses for additional disposal.
  }

  void onLoadMore() {
    // Method to be overridden by subclasses for additional loading.
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      onLoadMore();
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
    return MultiBlocProvider(
      providers: blocProviders(context),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: buildAppBar(context, isScroll),
        body: ListView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          children: [
            buildBody(context, isScroll),
          ],
        ),
      ),
    );
  }

  List<SingleChildWidget> blocProviders(BuildContext context);

  PreferredSizeWidget buildAppBar(BuildContext context, bool isScroll);

  Widget buildBody(BuildContext context, bool isScroll);
}
