import 'package:cgm/cgm.dart';

class CharacterSpacing extends Command {
  late final double _additionalCharacterSpacing;

  CharacterSpacing(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    _additionalCharacterSpacing = makeFixedPoint();
  }

  @override
  void paint(CGMDisplay display) {
    display.additionalCharacterSpace = _additionalCharacterSpacing;
  }

  @override
  String toString() => 'CharacterSpacing -> { additional: $_additionalCharacterSpacing } ';
}
