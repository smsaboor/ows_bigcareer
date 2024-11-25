import 'package:firebase_auth/firebase_auth.dart';
import 'package:ows_bigcareer/model/models/model_freelancers.dart';
import 'package:ows_bigcareer/model/models/model_jobs.dart';
import 'package:ows_bigcareer/model/models/model_jobs_final.dart';
import 'package:ows_bigcareer/model/models/model_jobs_homepage.dart';
import 'package:ows_bigcareer/model/models/model_display_all_projects.dart';

abstract class FirebaseBase {
  Future<dynamic> getAllJobs();
  totalLikedJob(String mobile, ModelJobsFinal jobs);
  Future addAndRemoveLikedJobs(bool isJobExist,String mobile, ModelJobsFinal jobs);
  Future<dynamic> getLikedJobs(String mobile);
  Future getLikedProjects(String mobile);
  Future getLikedFreelancers(String mobile);
  Future addAndRemoveFreelancers(bool freelancerExist, String mobile, ModelFreelancers freelancers);
  Future addProjects(String mobile,ModelDisplayAllProjects projects);
  Future deleteFreelancers(String mobile,String id);
  Future setImagePath(String mobile, String path);
}