import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../app/res/assets.gen.dart';
import '../../../app/res/res.dart';
import '../../themes/themes.dart';

class FormSearch extends StatefulWidget {
  const FormSearch({
    super.key,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onFieldSubmitted,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;

  @override
  State<FormSearch> createState() => _FormSearchState();
}

class _FormSearchState extends State<FormSearch> {
  late bool _showClearIcon;

  @override
  void initState() {
    super.initState();
    _showClearIcon = widget.controller?.text.isNotEmpty ?? false;
    widget.controller?.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _showClearIcon = widget.controller?.text.isNotEmpty ?? false;
    });
  }

  void _onClear() {
    widget.controller?.clear();
    widget.onChanged?.call('');
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: true,
      enableSuggestions: true,
      autofocus: true,
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      cursorErrorColor: AppColor.error,
      cursorWidth: AppDimens.s2,
      cursorOpacityAnimates: true,
      cursorRadius: const Radius.circular(AppDimens.s4),
      style: AppTextStyle.label3Light,
      maxLines: 1,
      controller: widget.controller,
      focusNode: widget.focusNode,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      inputFormatters: [
        //! Anticipate database injection
        LengthLimitingTextInputFormatter(128),
        FilteringTextInputFormatter.allow(
          RegExp(r'[a-zA-Z0-9\s\.\,\!\?\-\@\#\$\&\*\(\)]'),
        ),
      ],
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        filled: true,
        isDense: true,
        hintText: 'Search Movie',
        hintStyle: AppTextStyle.label3Light,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimens.s10,
          vertical: AppDimens.s10,
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: AppDimens.s36,
          minHeight: AppDimens.s18,
          maxWidth: AppDimens.s36,
          maxHeight: AppDimens.s18,
        ),
        prefixIcon: SizedBox(
          child: AppAssets.icons.common.icSearch.svg(
            colorFilter: const ColorFilter.mode(
              AppColor.textPrimary,
              BlendMode.srcIn,
            ),
          ),
        ),
        suffixIconConstraints: const BoxConstraints(
          minWidth: AppDimens.s36,
          minHeight: AppDimens.s16,
          maxWidth: AppDimens.s36,
          maxHeight: AppDimens.s16,
        ),
        suffixIcon: Visibility(
          visible: _showClearIcon,
          child: InkWell(
            onTap: _onClear,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.textDisabled,
              ),
              child: AppAssets.icons.common.icClose.svg(
                colorFilter: const ColorFilter.mode(
                  AppColor.textPrimary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimens.roundedMedium),
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 1,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimens.roundedMedium),
          borderSide: const BorderSide(
            color: AppColor.secondaryLight,
            width: 1,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimens.roundedMedium),
          borderSide: const BorderSide(
            color: AppColor.error,
            width: 1,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimens.roundedMedium),
          borderSide: const BorderSide(
            color: AppColor.textDisabled,
            width: 1,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
      ),
    );
  }
}
