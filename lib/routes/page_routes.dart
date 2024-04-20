import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:mudara_steel_app/binders/VendorLoginBinders/apply_job_binder.dart';
import 'package:mudara_steel_app/binders/VendorLoginBinders/my_allocated_job_binder.dart';
import 'package:mudara_steel_app/binders/VendorLoginBinders/my_bid_binder.dart';
import 'package:mudara_steel_app/binders/VendorLoginBinders/my_job_binder.dart';
import 'package:mudara_steel_app/binders/auth_binder.dart';
import 'package:mudara_steel_app/binders/AdminLoginBinders/bid_list_binder.dart';
import 'package:mudara_steel_app/binders/AdminLoginBinders/create_job_allocation_binder.dart';
import 'package:mudara_steel_app/binders/AdminLoginBinders/create_job_binder.dart';
import 'package:mudara_steel_app/binders/AdminLoginBinders/job_allocation_list_binder.dart';
import 'package:mudara_steel_app/binders/AdminLoginBinders/job_list_binder.dart';
import 'package:mudara_steel_app/binders/login_binder.dart';
import 'package:mudara_steel_app/binders/AdminLoginBinders/register_vendor_binder.dart';
import 'package:mudara_steel_app/binders/AdminLoginBinders/vendor_list_binder.dart';
import 'package:mudara_steel_app/binders/vendor_profile_binder.dart';
import 'package:mudara_steel_app/binders/vendor_reg_binder.dart';
import 'package:mudara_steel_app/ui/drawer/AdminLogin/Job/job_list_screen.dart';
import 'package:mudara_steel_app/ui/drawer/VendorLogin/my_allocated_job_screen.dart';
import 'package:mudara_steel_app/ui/drawer/VendorLogin/my_bid_screen.dart';
import 'package:mudara_steel_app/ui/drawer/VendorLogin/my_job_screen.dart';
import 'package:mudara_steel_app/ui/drawer/AdminLogin/bid_list.dart';
import 'package:mudara_steel_app/ui/drawer/VendorLogin/apply_job_screen.dart';
import 'package:mudara_steel_app/ui/drawer/AdminLogin/create_job.dart';
import 'package:mudara_steel_app/ui/drawer/AdminLogin/create_job_allocation.dart';
import 'package:mudara_steel_app/ui/drawer/AdminLogin/job_allocation_list.dart';
import 'package:mudara_steel_app/ui/drawer/AdminLogin/Job/open_job_list.dart';
import 'package:mudara_steel_app/ui/drawer/AdminLogin/vendor/register_vendor.dart';
import 'package:mudara_steel_app/ui/drawer/AdminLogin/vendor/vendor_list.dart';
import 'package:mudara_steel_app/ui/login_screen.dart';
import 'package:mudara_steel_app/ui/vendor_profile.dart';
import 'package:mudara_steel_app/ui/vendor_reg_screen.dart';
import '../common/widget/auth_widget.dart';
import 'app_routes.dart';

class PageRoutes {
  static const initial = Routes.root;

  static final routes = <GetPage>[
    GetPage(
      name: Routes.root,
      page: () => AuthWidget(),
      binding: AuthBinder(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginScreen(),
      binding: LoginBinder(),
    ),
    GetPage(
      name: Routes.vendorReg,
      page: () => const VendorRegScreen(),
      binding: VendorRegBinder(),
    ),
    GetPage(
      name: Routes.registerVendor,
      page: () => const RegisterVendorScreen(),
      binding: RegisterVendorBinder(),
    ),
    GetPage(
      name: Routes.vendorList,
      page: () =>  VendorListScreen(),
      binding: VendorListBinder(),
    ),
    GetPage(
      name: Routes.createJob,
      page: () =>  const CreateJobScreen(),
      binding: CreateJobBinder(),
    ),
    GetPage(
      name: Routes.applyJob,
      page: () =>  const ApplyJobScreen(),
      binding: ApplyJobBinder(),
    ),
    GetPage(
      name: Routes.createJobAllocation,
      page: () =>  const CreateJobAllocationScreen(),
      binding: CreateJobAllocationBinder(),
    ),
    GetPage(
      name: Routes.jobList,
      page: () =>   const JobListScreen(),
      binding: JobListBinder(),
    ),
    GetPage(
      name: Routes.myJob,
      page: () =>   MyJobScreen(),
      binding: MyJobBinder(),
    ),
    GetPage(
      name: Routes.myBid,
      page: () =>   MyBidScreen(),
      binding: MyBidBinder(),
    ),
    GetPage(
      name: Routes.bidList,
      page: () =>   BidListScreen(),
      binding: BidListBinder(),
    ),
    GetPage(
      name: Routes.jobAllocationList,
      page: () =>   JobAllocationListScreen(),
      binding: JobAllocationListBinder(),
    ),
    GetPage(
      name: Routes.myAllocatedJob,
      page: () =>   MyAllocatedJobScreen(),
      binding: MyAllocatedJobBinder(),
    ),
    GetPage(
      name: Routes.vendorProfile,
      page: () =>   const VendorProfileScreen(),
      binding: VendorProfileBinder(),
    ),
  ];
}
