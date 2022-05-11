class BookFilterChipVO {
  String label;
  bool isSelected;

  BookFilterChipVO(this.label, this.isSelected);

  @override
  String toString() {
    return 'BookFilterChipVO{label: $label, isSelected: $isSelected}';
  }
}