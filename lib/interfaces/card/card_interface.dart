
abstract class CardInterface {
  bool get isSelected;
  bool get canSelect;
  bool get isDiscarded;
  set canSelect(bool value);
  set isDiscarded(bool value);
  void updateCardSelectedStatus(bool status);
}