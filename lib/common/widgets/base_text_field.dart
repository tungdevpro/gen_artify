
import 'package:core/common/duration_provider.dart';
import 'package:express_cart/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/app_size.dart';

class CustomTextField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final String? errorText;
  final ValueChanged<String?>? onChanged;
  final TextStyle? hintStyle;
  const CustomTextField({super.key, this.labelText, this.hintText, this.controller, this.obscureText = false, this.errorText, this.onChanged, this.hintStyle});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;
  late ValueNotifier<bool> hasClearNotifier;
  late TextEditingController _controller;
  late ValueNotifier<bool> _obscureNotifier;
  late ValueNotifier<String?> _labelNotifier;

  @override
  void initState() {
    _focusNode = FocusNode()..addListener(_onListener);
    hasClearNotifier = ValueNotifier(false);
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_onTextEditingListener);
    _obscureNotifier = ValueNotifier(widget.obscureText);
    _labelNotifier = ValueNotifier(null);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomTextField oldWidget) {
    if (oldWidget.controller != widget.controller) {
      _controller = widget.controller ?? TextEditingController();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _obscureNotifier.dispose();
    _labelNotifier.dispose();
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _onTap,
          child: Container(
            height: 63,
            decoration: BoxDecoration(
                color: Color(0x26EAEAEA),
                border: Border.all(width: 1, color: widget.errorText != null && widget.errorText != '' ? AppColor.errorDefault : AppColor.secondaryLight300),
                borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(vertical: AppSize.padding - 6, horizontal: AppSize.paddingLG),
            child: ValueListenableBuilder<String?>(
              valueListenable: _labelNotifier,
              builder: (context, label, child) {
                bool isOk = label != null && label != '';
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (isOk) Text(label, style: const TextStyle(fontSize: 14, color: AppColor.secondaryLight300)),
                    // ValueListenableBuilder<String?>(
                    //   valueListenable: _labelNotifier,
                    //   builder: (context, label, child) {
                    //     if (label != null && label != '') {
                    //       return Text(label,
                    //           style: const TextStyle(
                    //             fontSize: AppSizings.tSm,
                    //             color: AppColors.labelInputColor,
                    //             height: 19.60 / AppSizings.tSm,
                    //           ));
                    //     }
                    //     return const SizedBox.shrink();
                    //   },
                    // ),
                    // if (widget.labelText != null && widget.labelText != '')
                    // Text(widget.labelText!, style: const TextStyle(fontSize: 12, color: AppColors.labelInputColor)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ValueListenableBuilder<bool>(
                          valueListenable: _obscureNotifier,
                          builder: (context, obscure, child) => Expanded(
                            child: TextFormField(
                              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                              focusNode: _focusNode,
                              controller: _controller,
                              obscureText: obscure,
                              obscuringCharacter: '●',
                              onChanged: widget.onChanged,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.fromLTRB(0, isOk ? 0 : 10, 5, 0),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                hintText: widget.hintText,
                                hintStyle: widget.hintStyle ??
                                    const TextStyle(
                                        color: AppColor.secondaryDefault, fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        ValueListenableBuilder<bool>(
                          valueListenable: hasClearNotifier,
                          builder: (context, hasClear, child) => InkWell(
                            onTap: _onClearText,
                            child: AnimatedSwitcher(
                              duration: const ShortDuration(),
                              transitionBuilder: (Widget child, Animation<double> animation) => ScaleTransition(scale: animation, child: child),
                              child: !hasClear ? const SizedBox.shrink() : const Icon(Icons.clear, size: 16),
                            ),
                          ),
                        ),
                        if (widget.obscureText)
                          ValueListenableBuilder<bool>(
                              valueListenable: hasClearNotifier,
                              builder: (context, hasClear, child) {
                                if (!hasClear) return const SizedBox.shrink();
                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(width: 4),
                                    InkWell(
                                      onTap: _onToggleVisibility,
                                      child: ValueListenableBuilder<bool>(
                                        valueListenable: _obscureNotifier,
                                        builder: (context, obscure, child) => AnimatedSwitcher(
                                          duration: const ShortDuration(),
                                          transitionBuilder: (Widget child, Animation<double> animation) => FadeTransition(opacity: animation, child: child),
                                          child: SvgPicture.asset(IconResource.eyeUslash),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              }),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        if (widget.errorText != null && widget.errorText != '') ...[
          const SizedBox(height: AppSize.paddingSM),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // const SvgViewer(AppIcons.icErrorMessage),
              // const SizedBox(width: 5),
              Expanded(
                child: Text(
                  widget.errorText!,
                  style: const TextStyle(color: AppColor.errorDefault, fontSize: 12, fontWeight: FontWeight.w500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ],
    );
  }

  void _onTap() {
    if (_focusNode.hasFocus) return;
    _focusNode.requestFocus();
  }

  void _onTextEditingListener() {
    hasClearNotifier.value = _controller.text.trim().isNotEmpty;
  }

  void _onClearText() {
    _controller.clear();
    // _focusNode.unfocus();
  }

  void _onToggleVisibility() {
    _obscureNotifier.value = !_obscureNotifier.value;
  }

  void _onListener() {
    _labelNotifier.value = widget.labelText;
  }
}
