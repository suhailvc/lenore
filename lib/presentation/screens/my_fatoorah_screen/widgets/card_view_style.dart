import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';

MFCardViewStyle cardViewStyl() {
  MFCardViewStyle style = MFCardViewStyle();
  style.cardHeight = 200;
  style.hideCardIcons = false;
  style.input?.inputMargin = 5;
  style.label?.display = true;
  style.input?.fontFamily = MFFontFamily.Monaco;
  style.label?.fontWeight = MFFontWeight.Heavy;
  return style;
}
