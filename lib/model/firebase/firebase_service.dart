import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_package1/components.dart';
import 'package:ows_bigcareer/model/models/model_freelancers.dart';
import 'package:ows_bigcareer/model/models/model_jobs_final.dart';
import 'package:ows_bigcareer/model/models/model_jobs_homepage.dart';
import 'package:ows_bigcareer/model/models/model_display_all_projects.dart';
import 'firebase_base.dart';

class FirebaseService extends FirebaseBase {
  @override
  Future getAllJobs() async {
    // TODO: implement sendOTP
  }

  Future<bool> doesJobExist(String mobile, var job) async =>
      FirebaseFirestore.instance
          .collection("likedJobs")
          .doc(mobile)
          .collection(mobile)
          .doc(job.jobId)
          .get()
          .then((value) => value.exists);

  Future<int> totalLikedOnJob(String jobId) async {
    int total = 0;
    final docRef =
        FirebaseFirestore.instance.collection("totalLikedOnJob").doc(jobId);
    DocumentSnapshot doc = await docRef.get();
    var data;
    if (doc.exists) {
      total = 0;
      data = doc.data() as Map<String, dynamic>;
      total = int.parse(data['total']);
    } else {
      FirebaseFirestore.instance
          .collection("totalLikedOnJob")
          .doc(jobId)
          .set({"total": '0'}).then((value) => value);
    }
    return total;
  }

  Future<int> totalCommentsOnJob(String jobId) async {
    int total = 0;
    final docRef =
        FirebaseFirestore.instance.collection("totalCommentsOnJob").doc(jobId);
    DocumentSnapshot doc = await docRef.get();
    var data;
    if (doc.exists) {
      total = 0;
      data = doc.data() as Map<String, dynamic>;
      total = int.parse(data['total']);
    } else {
      FirebaseFirestore.instance
          .collection("totalCommentsOnJob")
          .doc(jobId)
          .set({"total": '0'}).then((value) => value);
    }
    return total;
  }

  Future<int> totalShareOnJob(String jobId) async {
    int total = 0;
    final docRef =
        FirebaseFirestore.instance.collection("totalShareOnJob").doc(jobId);
    DocumentSnapshot doc = await docRef.get();
    var data;
    if (doc.exists) {
      total = 0;
      data = doc.data() as Map<String, dynamic>;
      total = int.parse(data['total']);
    } else {
      FirebaseFirestore.instance
          .collection("totalShareOnJob")
          .doc(jobId)
          .set({"total": '0'}).then((value) => value);
    }
    return total;
  }

  Future incrementAndDecrementOnLikedJob(int total, String jobId) async {
    print(
        '--incrementAndDecrementOnLikedJob-------jobId:$jobId------total---${total}');
    FirebaseFirestore.instance
        .collection("totalLikedOnJob")
        .doc(jobId)
        .update({"total": total.toString()}).then((value) => value);
  }


  @override
  Future addAndRemoveLikedJobs(
      bool isJobExist, String mobile, ModelJobsFinal jobs) async {
    print(
        '-addAndRemoveLikedJobs----isJobExist:$isJobExist--mobile:$mobile---jobs:$jobs');
    if (isJobExist) {
      await FirebaseFirestore.instance
          .collection("likedJobs")
          .doc(mobile)
          .collection(mobile)
          .doc(jobs.jobId)
          .delete()
          .then((value) {
        showToast(msg: 'job removed !');
      }).catchError((e) {
        showToast(msg: '$e oops job not removed !');
      });
    } else {
      await FirebaseFirestore.instance
          .collection("likedJobs")
          .doc(mobile)
          .collection(mobile)
          .doc(jobs.jobId)
          .set(jobs.toJson())
          .then((value) {
        showToast(msg: 'job added');
      }).catchError((e) {
        showToast(msg: '$e job not added');
      });
    }
  }

  @override
  Future setImagePath(String mobile, String path) async {
    print('setImagePath-----------${mobile}---------${path}');
    await FirebaseFirestore.instance
        .collection("users")
        .doc(mobile)
        .update({"image": path}).then((value) {
      showToast(msg: 'image updated');
    }).catchError((e) {
      showToast(msg: '$e image not updated');
    });
  }

  @override
  Future totalLikedJob(String mobile, ModelJobsFinal jobs) async {
    await FirebaseFirestore.instance
        .collection("likedJobs")
        .doc(mobile)
        .collection(mobile)
        .doc(jobs.jobId)
        .set(jobs.toJson())
        .then((value) {
      showToast(msg: 'job added');
    }).catchError((e) {
      showToast(msg: '$e job not added');
    });
  }

  @override
  Future addAndRemoveFreelancers(
      bool freelancerExist, String mobile, ModelFreelancers freelancers) async {
    if (freelancerExist) {
      await FirebaseFirestore.instance
          .collection("favoriteFreelancers")
          .doc(mobile)
          .collection(mobile)
          .doc(freelancers.id)
          .delete()
          .then((value) {
        showToast(msg: 'freelancer removed');
      }).catchError((e) {
        showToast(msg: '$e freelancer not removed');
      });
    } else {
      await FirebaseFirestore.instance
          .collection("favoriteFreelancers")
          .doc(mobile)
          .collection(mobile)
          .doc(freelancers.id)
          .set(freelancers.toJson())
          .then((value) {
        showToast(msg: 'freelancer added');
      }).catchError((e) {
        showToast(msg: '$e freelancer not added');
      });
    }
  }

  Future<bool> doesFreelancerExist(String mobile, var freelancer) async =>
      FirebaseFirestore.instance
          .collection("favoriteFreelancers")
          .doc(mobile)
          .collection(mobile)
          .doc(freelancer.id)
          .get()
          .then((value) => value.exists);

  @override
  Future addProjects(String mobile, ModelDisplayAllProjects projects) async {
    await FirebaseFirestore.instance
        .collection("favoriteProjects")
        .doc(mobile)
        .collection(mobile)
        .doc(projects.userId)
        .set(projects.toJson())
        .then((value) {
      showToast(msg: 'Project added');
    }).catchError((e) {
      showToast(msg: '$e Project not added');
    });
  }

  @override
  Future getLikedJobs(String mobile) async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("likedJobs")
        .doc(mobile)
        .collection(mobile)
        .get();
    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Future getLikedProjects(String mobile) async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("favoriteProjects")
        .doc(mobile)
        .collection(mobile)
        .get();
    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Future getLikedFreelancers(String mobile) async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("favoriteFreelancers")
        .doc(mobile)
        .collection(mobile)
        .get();
    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Future deleteFreelancers(String mobile, String id) async {
    print('-----------------$mobile--------$id');
    await FirebaseFirestore.instance
        .collection("favoriteFreelancers")
        .doc(mobile)
        .collection(mobile)
        .doc(id)
        .delete()
        .then((value) {
      showToast(msg: 'freelancer deleted');
    }).catchError((e) {
      showToast(msg: '$e freelancer not deleted');
    });
  }

  Future deleteProjects(String mobile, String id) async {
    print('-----------------$mobile--------$id');
    await FirebaseFirestore.instance
        .collection("favoriteProjects")
        .doc(mobile)
        .collection(mobile)
        .doc(id)
        .delete()
        .then((value) {
      showToast(msg: 'Project removed');
    }).catchError((e) {
      showToast(msg: '$e Project not removed');
    });
  }

  Future deleteJobs(String mobile, String id) async {
    print('-----------------$mobile--------$id');
    await FirebaseFirestore.instance
        .collection("likedJobs")
        .doc(mobile)
        .collection(mobile)
        .doc(id)
        .delete()
        .then((value) {
      showToast(msg: 'Jobs removed');
    }).catchError((e) {
      showToast(msg: '$e Jobs not removed');
    });
  }
}
