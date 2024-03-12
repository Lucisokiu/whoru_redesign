import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class Filter {

 ColorFilter identity =const ColorFilter.matrix(<double>[
  1, 0, 0, 0, 0,
  0, 1, 0, 0, 0,
  0, 0, 1, 0, 0,
  0, 0, 0, 1, 0,
]);
 ColorFilter invert = const ColorFilter.matrix(<double>[
  -1,  0,  0, 0, 255,
   0, -1,  0, 0, 255,
   0,  0, -1, 0, 255,
   0,  0,  0, 1,   0,
]);
 ColorFilter sepia = const ColorFilter.matrix(<double>[
  0.393, 0.769, 0.189, 0, 0,
  0.349, 0.686, 0.168, 0, 0,
  0.272, 0.534, 0.131, 0, 0,
  0,     0,     0,     1, 0,
]);
 ColorFilter greyscale = const ColorFilter.matrix(<double>[
  0.2126, 0.7152, 0.0722, 0, 0,
  0.2126, 0.7152, 0.0722, 0, 0,
  0.2126, 0.7152, 0.0722, 0, 0,
  0,      0,      0,      1, 0,
]);

 ColorFilter brightness =const ColorFilter.matrix(<double>[
  1.2, 0, 0, 0, 0,
  0, 1.2, 0, 0, 0,
  0, 0, 1.2, 0, 0,
  0, 0, 0, 1, 0,
]);


ColorFilter contrast = const ColorFilter.matrix(<double>[
  2, 0, 0, 0, -255,
  0, 2, 0, 0, -255,
  0, 0, 2, 0, -255,
  0, 0, 0, 1, 0,
]);

ColorFilter saturate = const ColorFilter.matrix(<double>[
  1.5, 0, 0, 0, 0,
  0, 1.5, 0, 0, 0,
  0, 0, 1.5, 0, 0,
  0, 0, 0, 1, 0,
]);

ColorFilter hueRotate(double angle) {
  double cosA = cos(angle);
  double sinA = sin(angle);
  return ColorFilter.matrix(<double>[
    0.213 + cosA * 0.787 - sinA * 0.213, 0.715 - cosA * 0.715 - sinA * 0.715, 0.072 - cosA * 0.072 + sinA * 0.928, 0, 0,
    0.213 - cosA * 0.213 + sinA * 0.143, 0.715 + cosA * 0.285 + sinA * 0.140, 0.072 - cosA * 0.072 - sinA * 0.283, 0, 0,
    0.213 - cosA * 0.213 - sinA * 0.787, 0.715 - cosA * 0.715 + sinA * 0.715, 0.072 + cosA * 0.928 + sinA * 0.072, 0, 0,
    0, 0, 0, 1, 0,
  ]);
}

ColorFilter blurMatrix = const ColorFilter.matrix(<double>[
  0.1, 0.1, 0.1, 0, 0,
  0.1, 0.1, 0.1, 0, 0,
  0.1, 0.1, 0.1, 0, 0,
  0, 0, 0, 1, 0,
]);



List<ColorFilter> getFilters() {
  return [identity, invert, sepia, greyscale, brightness, contrast, saturate, hueRotate(pi / 6), blurMatrix];
}
}
