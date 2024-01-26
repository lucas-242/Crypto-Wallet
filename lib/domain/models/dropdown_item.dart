import 'package:equatable/equatable.dart';

class DropdownItem extends Equatable {
  const DropdownItem({String? label, required this.value})
      : label = label ?? value;

  final String label;
  final String value;

  @override
  List<Object?> get props => [label, value];
}
