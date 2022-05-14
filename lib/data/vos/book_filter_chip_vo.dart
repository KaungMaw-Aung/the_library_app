class BookFilterChipVO {
  String label;
  bool isSelected;

  BookFilterChipVO(this.label, this.isSelected);

  @override
  String toString() {
    return 'BookFilterChipVO{label: $label, isSelected: $isSelected}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookFilterChipVO &&
          runtimeType == other.runtimeType &&
          label == other.label &&
          isSelected == other.isSelected;

  @override
  int get hashCode => label.hashCode ^ isSelected.hashCode;
}