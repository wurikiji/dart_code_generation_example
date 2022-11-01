class Getter {
  const Getter({this.asMethod = false});
  final bool asMethod;
}

const getter = Getter();

class Setter {
  const Setter({this.asMethod = false});
  final bool asMethod;
}

const setter = Setter();
