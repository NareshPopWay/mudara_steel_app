import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';


class AuthWidget extends GetResponsiveView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.displayWidget.value);
  }
}
