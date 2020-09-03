class Reward {
  String _name;
  String _description;

  //----------- constructor -----------//
  Reward(
    this._name,
    this._description,
  );

  //----------- Getters -----------//
  List<Object> get props => [_name, _description];
  String get name => _name;
  String get description => _description;
}
