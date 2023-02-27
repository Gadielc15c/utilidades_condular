List<int> findListInListOfList(List<List> listOfList, List someList) {
  List<int> toRemove = [];
  String temp = "";
  for (int i = 0; i < listOfList.length; i++) {
    temp = listOfList[i].join();
    if (someList.contains(temp)) {
      toRemove.add(i);
    }
  }
  return toRemove;
}

List<List> removeElementByIndeces(List indeces, List<List> someList) {
  indeces.sort();
  indeces = indeces.reversed.toList();
  if (someList.isNotEmpty) {
    for (int index in indeces) {
      someList.removeAt(index);
    }
  }
  return someList;
}

List<List> findListInListOfListAndRemoveIt(
    List<List> listOfList, List someList) {
  List<int> toRemove = findListInListOfList(listOfList, someList);
  listOfList = removeElementByIndeces(toRemove, listOfList);
  return listOfList;
}
