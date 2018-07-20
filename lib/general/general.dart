clamp(value, min, max) {
  return (value < min) ? (min) : ((value > max) ? (max) : (value));
}

clampUp(value, max) {
  return value > max ? max : value;
}

clampDown(value, min) {
  return value < min ? min : value;
}

lerp(value, min, max) {
  return min + value * (max - min);
}
