import 'package:cgm/cgm.dart';

class EdgeWidthSpecificationMode extends Command {
  EdgeWidthSpecificationMode(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    final index = makeEnum();
    final mode = SpecificationMode.getMode(index);
    cgm.edgeWidthSpecificationMode = mode;
  }

  @override
  String toString() => 'Edge Width Specification Mode -> ${cgm.edgeWidthSpecificationMode}';
}
