double staggerDelayFor(
  int index,
  int itemCount, {
  double maxStep = 0.08,
  double maxDelay = 0.6,
}) {
  final step = itemCount > 0 ? (0.5 / itemCount).clamp(0.0, maxStep) : maxStep;
  return (index * step).clamp(0.0, maxDelay);
}
