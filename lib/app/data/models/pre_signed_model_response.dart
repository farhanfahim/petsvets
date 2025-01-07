class PresignedUrlModelResponse {

  Result? result;
  String? url;
  String? name;

  PresignedUrlModelResponse({this.result, this.url});

  PresignedUrlModelResponse.fromJson(Map<String, dynamic> json) {
    result =
    json['result'] != null ? Result.fromJson(json['result']) : null;
    url = json['url'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    data['url'] = this.url;
    data['name'] = this.name;
    return data;
  }
}

class Result {
  String? url;
  Fields? fields;

  Result({this.url, this.fields});

  Result.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    fields =
    json['fields'] != null ? Fields.fromJson(json['fields']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = this.url;
    if (this.fields != null) {
      data['fields'] = this.fields!.toJson();
    }
    return data;
  }
}

class Fields {
  String? key;
  String? contentType;
  String? aCL;
  String? bucket;
  String? xAmzAlgorithm;
  String? xAmzCredential;
  String? xAmzDate;
  String? policy;
  String? xAmzSignature;

  Fields(
      {this.key,
        this.contentType,
        this.aCL,
        this.bucket,
        this.xAmzAlgorithm,
        this.xAmzCredential,
        this.xAmzDate,
        this.policy,
        this.xAmzSignature});

  Fields.fromJson(Map<String, dynamic> json) {
    key = json['Key'];
    contentType = json['Content-Type'];
    aCL = json['ACL'];
    bucket = json['bucket'];
    xAmzAlgorithm = json['X-Amz-Algorithm'];
    xAmzCredential = json['X-Amz-Credential'];
    xAmzDate = json['X-Amz-Date'];
    policy = json['Policy'];
    xAmzSignature = json['X-Amz-Signature'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Key'] = this.key;
    data['Content-Type'] = this.contentType;
    data['ACL'] = this.aCL;
    data['bucket'] = this.bucket;
    data['X-Amz-Algorithm'] = this.xAmzAlgorithm;
    data['X-Amz-Credential'] = this.xAmzCredential;
    data['X-Amz-Date'] = this.xAmzDate;
    data['Policy'] = this.policy;
    data['X-Amz-Signature'] = this.xAmzSignature;
    return data;
  }
}