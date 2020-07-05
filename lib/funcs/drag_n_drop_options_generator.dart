const SCREENS_NUMBER = 10;

const VARS_PER_SCREEN = 4;

List<List<List<String>>> generateVariants(int minNumber, int maxNumber) {
  int top = maxNumber > 10 ? maxNumber : 10;

  List<List<List<String>>> resp = [];
  List<List<String>> temp = [];

  for (int i = 1; i <= top; i++) {
    for (int j = minNumber; j <= maxNumber; j++) {
      temp.add([(i * j).toString(), '$i \u00D7 $j']);
    }
  }

  while (temp.length < SCREENS_NUMBER * VARS_PER_SCREEN) {
    temp = temp + temp;
  }
  temp.shuffle();

  for (int i = 0; i < SCREENS_NUMBER; i++) {
    List<List<String>> temp2 = [];
    for (int j = 0; j < VARS_PER_SCREEN; j++) {
      temp2.add(temp[i * VARS_PER_SCREEN + j]);
    }
    resp.add(temp2);
  }

  return resp;
}
