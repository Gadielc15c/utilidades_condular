double spacingHeight(
    {required double contextHeight,
    required double minContextHeightSize,
    required double maxContextHeightSize,
    required double maxSpacing}) {
  double sizedBoxHeight = ((contextHeight - minContextHeightSize) /
          ((maxContextHeightSize - minContextHeightSize) / maxSpacing))
      .clamp(1, maxSpacing);
  return sizedBoxHeight;
}
