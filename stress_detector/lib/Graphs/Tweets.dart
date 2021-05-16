
class Tweets {
    double statVal;
    String statName;
    String colorVal;

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

// class Tweets {
//     Map<String, double> result;
//     DateTime timestamp;
//     String user_id;
//
//     Tweets(this.result, this.timestamp, this.user_id);
//
//     Tweets.fromMap(Map<String, dynamic> map)
//         : assert(map['result'] != null),
//             assert(map['timestamp'] != null),
//             assert(map['user_id'] != null),
//             result = map['result'],
//             timestamp = map['timestamp'],
//             user_id = map['user_id'];
//
//     @override
//     String toString() => "Record<$result:$timestamp:$user_id>";
// }