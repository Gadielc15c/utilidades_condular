String stringForLogs(List l) {
  String result = "";
  for (int i = 0; i < l.length; i++) {
    if (i > 0) {
      result += ",";
    }
    result += "'${l[i]}'";
  }

  return result;
}
