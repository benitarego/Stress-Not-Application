class Tweets {
  final int statVal;
  final String statName;
  final String colorVal;
  Tweets(this.statVal, this.statName,this.colorVal);

  Tweets.fromMap(Map<String, dynamic> map)
      : assert(map['statVal'] != null),
        assert(map['statName'] != null),
        assert(map['colorVal'] != null),
        statVal = map['statVal'],
        colorVal = map['colorVal'],
        statName = map['statName'];

  @override
  String toString() => "Record<$statVal:$statName:$colorVal>";
}