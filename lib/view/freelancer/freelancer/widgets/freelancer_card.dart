import 'package:flutter/material.dart';
import 'package:flutter_package1/components.dart';
import 'package:ows_bigcareer/model/firebase/firebase_service.dart';
import 'package:ows_bigcareer/view/freelancer/freelancer/hire_freelancer.dart';

class FreelancerCard extends StatefulWidget {
  const FreelancerCard(
      {Key? key, required this.freelancer, required this.userMobile})
      : super(key: key);
  final freelancer;
  final userMobile;

  @override
  State<FreelancerCard> createState() => _FreelancerCardState();
}

class _FreelancerCardState extends State<FreelancerCard> {
  FirebaseService firebaseServices = FirebaseService();
  bool doesFreelacerExistFlag = false;

  getFreelancerExist() async {
    doesFreelacerExistFlag = await firebaseServices.doesFreelancerExist(
        widget.userMobile, widget.freelancer);
    setState(() {});
  }

  @override
  void initState() {
    getFreelancerExist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 320,
        width: MediaQuery.of(context).size.width,
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(0),
              topLeft: Radius.circular(0),
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(0),
            ),
          ),
          color: Colors.white,
          elevation: 1,
          child: Column(
            children: [
              SizedBox(
                height: 260,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        color: Colors.white38,
                        width: double.infinity,
                        height: 80,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: SizedBox(
                                height: 60,
                                width: 60,
                                child: Image.network(
                                  widget.freelancer.image ?? '',
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, left: 8, right: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0),
                                    child: Text(
                                      widget.freelancer.name!,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0),
                                    child: Row(
                                      children: const [
                                        Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 16,
                                        ),
                                        Text(
                                          '5.0',
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0),
                                    child: Text(
                                      widget.freelancer.country!,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              child: IconButton(
                                  onPressed: () {
                                    firebaseServices.addAndRemoveFreelancers(
                                      doesFreelacerExistFlag,
                                        widget.userMobile!, widget.freelancer);
                                    getFreelancerExist();
                                  },
                                  icon: doesFreelacerExistFlag
                                      ? const Icon(
                                          Icons.bookmark,
                                        )
                                      : const Icon(
                                          Icons.bookmark_add_outlined,
                                        )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18.0, top: 10),
                        child: Row(
                          children: [
                            Text(
                              '${widget.freelancer.amount!} ${widget.freelancer.currency!} ',
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                            Text(
                              widget.freelancer.paymentMode!,
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18.0, top: 10),
                        child: Column(
                          children: [
                            Text(
                              widget.freelancer.title!,
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 0, right: 10, left: 18),
                        child: Text(
                          widget.freelancer.about!,
                          maxLines: 3,
                          style: const TextStyle(
                              fontSize: 12, color: Colors.black),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 18.0, top: 3.0, right: 0),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width * .29,
                            child: const Text(
                              'Skills',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.redAccent),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width * .50,
                            child: Text(
                              widget.freelancer.skills!
                                  .replaceAll('[', '')
                                  .replaceAll(']', ''),
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                  height: 35,
                  width: MediaQuery.of(context).size.width * .9,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(5)),
                          backgroundColor: Colors.indigo),
                      onPressed: () {
                        print(
                            '----onPressed----------------${widget.freelancer.id}-');
                        if (widget.userMobile == widget.freelancer.f_id) {
                          showToast(msg: "you wouldn't hire your self");
                        } else {
                          navigateTo(
                              context,
                              HireFreelancer(
                                userMobile: widget.userMobile,
                                freelancer: widget.freelancer,
                              ));
                        }
                      },
                      child: const Center(
                        child: Text(
                          'Hire',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
