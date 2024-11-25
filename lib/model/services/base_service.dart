abstract class BaseService {
  final String baseUrl = "https://bigcareer.co.in/php_api/";
  final String apiFreelancerUrl = "freelancers_api.php";
  final String apiProjectUrl = "freelancers_api.php";
  final String apiJobUrl = "freelancers_api.php";
  final String apiSearchFreelancerUrl = "search_freelancers_api.php";
  Future<dynamic> getApiResponse(String url, var body);
}