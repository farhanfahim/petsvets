class BaseResponse<T> {
  final bool status;
  final String message;
  final T data;

  BaseResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json, T Function(dynamic) fromJson) {
    return BaseResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: fromJson(json['data']),
    );
  }
}