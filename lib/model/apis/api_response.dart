class ApiResponse<T> {
  Status status;
  T? data;
  String? message;
  ApiResponse.initial(this.message) : status = Status.INITIAL;
  ApiResponse.loading(this.message) : status = Status.LOADING;
  ApiResponse.completed(this.data) : status = Status.COMPLETED;
  ApiResponse.error(this.message) : status = Status.ERROR;
  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}
class ApiResponseLatestJobHomePage<T> {
  Status status;
  T? data;
  String? message;
  ApiResponseLatestJobHomePage.initial(this.message) : status = Status.INITIAL;
  ApiResponseLatestJobHomePage.loading(this.message) : status = Status.LOADING;
  ApiResponseLatestJobHomePage.completed(this.data) : status = Status.COMPLETED;
  ApiResponseLatestJobHomePage.error(this.message) : status = Status.ERROR;
  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}
class ApiResponseJobHomePage<T> {
  Status status;
  T? data;
  String? message;
  ApiResponseJobHomePage.initial(this.message) : status = Status.INITIAL;
  ApiResponseJobHomePage.loading(this.message) : status = Status.LOADING;
  ApiResponseJobHomePage.completed(this.data) : status = Status.COMPLETED;
  ApiResponseJobHomePage.error(this.message) : status = Status.ERROR;
  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}
class ApiResponse2<T> {
  Status status;
  T? data;
  String? message;
  ApiResponse2.initial(this.message) : status = Status.INITIAL;
  ApiResponse2.loading(this.message) : status = Status.LOADING;
  ApiResponse2.completed(this.data) : status = Status.COMPLETED;
  ApiResponse2.error(this.message) : status = Status.ERROR;
  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}
class ApiResponse3<T> {
  Status status;
  T? data;
  String? message;
  ApiResponse3.initial(this.message) : status = Status.INITIAL;
  ApiResponse3.loading(this.message) : status = Status.LOADING;
  ApiResponse3.completed(this.data) : status = Status.COMPLETED;
  ApiResponse3.error(this.message) : status = Status.ERROR;
  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}
class ApiResponseJobs<T> {
  Status status;
  T? data;
  String? message;
  ApiResponseJobs.initial(this.message) : status = Status.INITIAL;
  ApiResponseJobs.loading(this.message) : status = Status.LOADING;
  ApiResponseJobs.completed(this.data) : status = Status.COMPLETED;
  ApiResponseJobs.error(this.message) : status = Status.ERROR;
  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}
class ApiResponseJobSearchKeywords<T> {
  Status status;
  T? data;
  String? message;
  ApiResponseJobSearchKeywords.initial(this.message) : status = Status.INITIAL;
  ApiResponseJobSearchKeywords.loading(this.message) : status = Status.LOADING;
  ApiResponseJobSearchKeywords.completed(this.data) : status = Status.COMPLETED;
  ApiResponseJobSearchKeywords.error(this.message) : status = Status.ERROR;
  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}
class ApiResponseJobSearch<T> {
  Status status;
  T? data;
  String? message;
  ApiResponseJobSearch.initial(this.message) : status = Status.INITIAL;
  ApiResponseJobSearch.loading(this.message) : status = Status.LOADING;
  ApiResponseJobSearch.completed(this.data) : status = Status.COMPLETED;
  ApiResponseJobSearch.error(this.message) : status = Status.ERROR;
  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}
class ApiResponseFilterJob<T> {
  Status status;
  T? data;
  String? message;
  ApiResponseFilterJob.initial(this.message) : status = Status.INITIAL;
  ApiResponseFilterJob.loading(this.message) : status = Status.LOADING;
  ApiResponseFilterJob.completed(this.data) : status = Status.COMPLETED;
  ApiResponseFilterJob.error(this.message) : status = Status.ERROR;
  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}
class ApiResponseFreelancer<T> {
  Status status;
  T? data;
  String? message;
  ApiResponseFreelancer.initial(this.message) : status = Status.INITIAL;
  ApiResponseFreelancer.loading(this.message) : status = Status.LOADING;
  ApiResponseFreelancer.completed(this.data) : status = Status.COMPLETED;
  ApiResponseFreelancer.error(this.message) : status = Status.ERROR;
  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}
class ApiResponseProjects<T> {
  Status status;
  T? data;
  String? message;
  ApiResponseProjects.initial(this.message) : status = Status.INITIAL;
  ApiResponseProjects.loading(this.message) : status = Status.LOADING;
  ApiResponseProjects.completed(this.data) : status = Status.COMPLETED;
  ApiResponseProjects.error(this.message) : status = Status.ERROR;
  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}
enum FromStatus { INITIAL, OPEN, CLOSED }
enum Status { INITIAL, LOADING, COMPLETED, ERROR }
