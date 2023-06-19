//import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

const customcolor1 = Color(0xFF4E73FF);

CustomColors lightCustomColors = const CustomColors(
    sourceCustomcolor1: Color(0xFF4E73FF),
    customcolor1: Color(0xFF2450DD),
    onCustomcolor1: Color(0xFFFFFFFF),
    customcolor1Container: Color(0xFFDDE1FF),
    onCustomcolor1Container: Color(0xFF001454),
    good: Color.fromARGB(255, 1, 184, 71),
    wait: Color.fromARGB(255, 228, 175, 0),
    fail: Color.fromARGB(255, 214, 0, 0));

CustomColors darkCustomColors = const CustomColors(
    sourceCustomcolor1: Color(0xFF4E73FF),
    customcolor1: Color(0xFFB8C4FF),
    onCustomcolor1: Color(0xFF002585),
    customcolor1Container: Color(0xFF0037B9),
    onCustomcolor1Container: Color(0xFFDDE1FF),
    good: Color.fromARGB(255, 148, 255, 144),
    wait: Color.fromARGB(255, 255, 214, 80),
    fail: Color.fromARGB(255, 255, 107, 107));

/// Defines a set of custom colors, each comprised of 4 complementary tones.
///
/// See also:
///   * <https://m3.material.io/styles/color/the-color-system/custom-colors>
@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.sourceCustomcolor1,
    required this.customcolor1,
    required this.onCustomcolor1,
    required this.customcolor1Container,
    required this.onCustomcolor1Container,
    required this.good,
    required this.wait,
    required this.fail,
  });

  final Color? sourceCustomcolor1;
  final Color? customcolor1;
  final Color? onCustomcolor1;
  final Color? customcolor1Container;
  final Color? onCustomcolor1Container;
  final Color? good;
  final Color? wait;
  final Color? fail;

  @override
  CustomColors copyWith({
    Color? sourceCustomcolor1,
    Color? customcolor1,
    Color? onCustomcolor1,
    Color? customcolor1Container,
    Color? onCustomcolor1Container,
    Color? good,
    Color? wait,
    Color? fail,
  }) {
    return CustomColors(
      sourceCustomcolor1: sourceCustomcolor1 ?? this.sourceCustomcolor1,
      customcolor1: customcolor1 ?? this.customcolor1,
      onCustomcolor1: onCustomcolor1 ?? this.onCustomcolor1,
      customcolor1Container:
          customcolor1Container ?? this.customcolor1Container,
      onCustomcolor1Container:
          onCustomcolor1Container ?? this.onCustomcolor1Container,
      good: good ?? this.good,
      wait: wait ?? this.wait,
      fail: fail ?? this.fail,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
        sourceCustomcolor1:
            Color.lerp(sourceCustomcolor1, other.sourceCustomcolor1, t),
        customcolor1: Color.lerp(customcolor1, other.customcolor1, t),
        onCustomcolor1: Color.lerp(onCustomcolor1, other.onCustomcolor1, t),
        customcolor1Container:
            Color.lerp(customcolor1Container, other.customcolor1Container, t),
        onCustomcolor1Container: Color.lerp(
            onCustomcolor1Container, other.onCustomcolor1Container, t),
        good: Color.lerp(good, other.good, t),
        wait: Color.lerp(wait, other.wait, t),
        fail: Color.lerp(fail, other.fail, t));
  }

  /// Returns an instance of [CustomColors] in which the following custom
  /// colors are harmonized with [dynamic]'s [ColorScheme.primary].
  ///
  /// See also:
  ///   * <https://m3.material.io/styles/color/the-color-system/custom-colors#harmonization>
  CustomColors harmonized(ColorScheme dynamic) {
    return copyWith();
  }
}
