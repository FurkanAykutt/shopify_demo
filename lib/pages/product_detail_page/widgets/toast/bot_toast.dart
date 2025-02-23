import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/text_styles.dart';

enum ToastType {
  success,
  error,
}

Future<void> showToast(
  String msg, {
  ToastType toastType = ToastType.success,
  int seconds = 3,
}) async {
  BotToast.cleanAll();
  Color? color;
  String? image;

  switch (toastType) {
    case ToastType.success:
      image = icSuccess;
      color = AppColors.success;
      break;
    case ToastType.error:
      image = icError;
      color = AppColors.error;
      break;
  }

  final CancelFunc cancel = BotToast.showAnimationWidget(
    wrapToastAnimation: (AnimationController controller,
        VoidCallback cancelFunc, Widget widget) {
      final Animation<double> anim =
          Tween<double>(begin: -100, end: 15).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOutSine,
      ));
      return AnimatedBuilder(
        animation: anim,
        builder: (BuildContext context, Widget? child) {
          return Transform.translate(
            offset: Offset(0, anim.value),
            child: widget,
          );
        },
      );
    },
    toastBuilder: (VoidCallback cancelFunc) {
      return BotToastWidget(
        image: image,
        color: color,
        msg: msg,
        cancelFunc: cancelFunc,
      );
    },
    duration: Duration(seconds: seconds),
    animationDuration: const Duration(milliseconds: 400),
    animationReverseDuration: const Duration(milliseconds: 500),
  );
  Future<dynamic>.delayed(Duration(seconds: seconds), () {
    cancel();
  });
}

class BotToastWidget extends StatelessWidget {
  const BotToastWidget(
      {required this.msg,
      required this.cancelFunc,
      this.color,
      this.image,
      super.key});
  final Color? color;
  final String msg;
  final String? image;
  final Function() cancelFunc;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GestureDetector(
                onTap: cancelFunc,
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(color: color!.withOpacity(0.5), blurRadius: 6)
                    ],
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 6,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: Image.asset(
                            image ?? icError,
                            width: 24,
                            height: 24,
                            color: color,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            msg,
                            maxLines: 2,
                            style: AppTextStyle.bodyS,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
