class ServerTime {
    DateTime currentTime;

    ServerTime({
        this.currentTime,
    });

    factory ServerTime.fromJson(Map<String, dynamic> json) => new ServerTime(
        currentTime: DateTime.parse(json["currentTime"].toString()
          .replaceFirstMapped(RegExp(r"(\.\d{6})\d+"), (m) => m[1])),
    );

    Map<String, dynamic> toJson() => {
        "currentTime": currentTime.toIso8601String(),
    };
}
