import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/app.dart';

Widget zoomButton(bool isButtonEnabled, String str, String position, int index,
    BuildContext context) {
  return Align(
    alignment: position == 'right'
        ? Alignment.centerRight
        : position == 'left'
            ? Alignment.centerLeft
            : Alignment.center,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 300),

      width: index == 1
          ? isButtonEnabled
              ? 50.w
              : 30.w
          : index == 2
              ? isButtonEnabled
                  ? 30.w
                  : 50.w
              : null,
      height: index == 1
          ? isButtonEnabled
              ? 7.h
              : 5.h
          : index == 2
              ? isButtonEnabled
                  ? 5.h
                  : 7.h
              : null,
      // width: isButtonEnabled ? 50.w : 30.w,
      // height: isButtonEnabled ? 7.h : 5.h,
      // transform: isButtonEnabled
      //     ? Matrix4.translationValues(
      //         0.0, 0.0, 0.0) // Di chuyển nút sang trái
      //     : Matrix4.translationValues(
      //         30.w, 0.0, 0.0),
      child: ElevatedButton(
        onPressed: index == 1
            ? isButtonEnabled
                ? () {
                    // Xử lý khi nút được nhấn
                    if (str == 'Login') {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => const App(),
                        ),
                      );
                    }
                  }
                : null
            : index == 2
                ? isButtonEnabled
                    ? null
                    : () {
                        // Xử lý khi nút được nhấn
                        print(isButtonEnabled);
                      }
                : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: index == 1
              ? isButtonEnabled
                  ? const Color.fromRGBO(81, 165, 243, 1)
                  : null
              : index == 2
                  ? isButtonEnabled
                      ? null
                      : const Color.fromRGBO(81, 165, 243, 1)
                  : null, // Màu nền của nút

          shape: position == 'right'
              ? const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100.0), // Bo tròn góc bên trái
                    bottomLeft:
                        Radius.circular(100.0), // Bo tròn góc bên trái dưới
                    topRight: Radius.zero, // Góc bên phải là vuông góc
                    bottomRight: Radius.zero, // Góc bên phải dưới là vuông góc
                  ),
                )
              : position == 'left'
                  ? const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.zero, // Bo tròn góc bên trái
                        bottomLeft: Radius.zero, // Bo tròn góc bên trái dưới
                        topRight:
                            Radius.circular(100.0), // Góc bên phải là vuông góc
                        bottomRight: Radius.circular(
                            100.0), // Góc bên phải dưới là vuông góc
                      ),
                    )
                  : position == 'center'
                      ? const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.zero, // Bo tròn góc bên trái
                            bottomLeft:
                                Radius.zero, // Bo tròn góc bên trái dưới
                            topRight: Radius.zero, // Góc bên phải là vuông góc
                            bottomRight:
                                Radius.zero, // Góc bên phải dưới là vuông góc
                          ),
                        )
                      : null,
        ),
        child: Text(
          str,
          style: TextStyle(
            color: index == 1
                ? isButtonEnabled
                    ? Colors.white
                    : null
                : index == 2
                    ? isButtonEnabled
                        ? null
                        : Colors.white
                    : null,

            fontSize: index == 1
                ? isButtonEnabled
                    ? 4.h
                    : 2.3.h
                : index == 2
                    ? isButtonEnabled
                        ? 2.3.h
                        : 4.h
                    : null,
            // fontSize: isButtonEnabled ? 4.h : 2.3.h,
          ),
        ),
      ),
    ),
  );
}
