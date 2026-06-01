class ResponseModel {
  final bool _isSuccess;
  final String _message;

  const ResponseModel(this._isSuccess, this._message);

  String get message => _message;
  bool get isSuccess => _isSuccess;

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      json['success'] as bool,
      json['message'] as String,
    );
  }

  @override
  String toString() => 'ResponseModel(success: $_isSuccess, message: $_message)';
}