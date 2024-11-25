class AppStrings {
  static String getFixedString(String text, int textLength, maxValue) {
    print(
        '---getFixedString------text: ${text}----textLength: ${textLength}--------maxValue: ${maxValue}--textLength < maxValue(${textLength < maxValue})-');
    if (textLength < maxValue) {
      return text.substring(0, textLength);
    } else {
      return text.substring(0, maxValue);
    }
  }
}
