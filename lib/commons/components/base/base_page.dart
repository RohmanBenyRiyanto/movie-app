import 'package:flutter/material.dart';

abstract class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  BasePageState createState();
}

abstract class BasePageState<T extends BasePage> extends State<T> {
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

  void _scrollListener() {
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
    return Scaffold(
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
    );
  }

  PreferredSizeWidget buildAppBar(BuildContext context, bool isScroll);

  Widget buildBody(BuildContext context, bool isScroll);
}
