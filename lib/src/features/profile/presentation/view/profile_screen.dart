import 'dart:convert';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:enigma/src/core/database/local/shared_preference/shared_preference_keys.dart';
import 'package:enigma/src/core/database/local/shared_preference/shared_preference_manager.dart';
import 'package:enigma/src/core/utils/extension/context_extension.dart';
import 'package:enigma/src/features/auth/presentation/logout/view_model/logout_controller.dart';
import 'package:enigma/src/features/profile/presentation/view_model/controller/profile_controller.dart';
import 'package:enigma/src/shared/dependency_injection/dependency_injection.dart';
import 'package:enigma/src/shared/widgets/shared_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  static const route = "/profile";

  static setRoute() => "/profile";

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  SharedPreferenceManager sp = sl.get<SharedPreferenceManager>();

  readProfile() {
    ref
        .read(profileProvider.notifier)
        .readProfile(sp.getValue(key: SharedPreferenceKeys.USER_UID));
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback(
      (t) => readProfile(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileController = ref.watch(profileProvider);
    print(jsonEncode(profileController.profileEntity));
    return Scaffold(
      appBar: SharedAppbar(
        trailingWidgets: [
          GestureDetector(
            onTap: () {
              ref.read(logoutProvider.notifier).logout();
            },
            child: Container(
              height: context.height * .15,
              width: context.width * .137,
              padding: const EdgeInsets.all(8),
              child: const Icon(Icons.logout),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                height: context.width * 0.4,
                width: context.width * 0.4,
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // Set the shape to circle
                  border: Border.all(),
                ),
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: profileController.profileEntity?.avatarUrl ?? "",
                    errorWidget: (context, url, error) => Icon(
                      Icons.person,
                      size: context.width * 0.1,
                    ),
                    fit: BoxFit
                        .cover, // Use BoxFit.cover to ensure the image covers the entire container
                  ),
                ),
              ),
              Text(
                "${profileController.profileEntity?.name}",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                "Email: ${profileController.profileEntity?.email}",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              if (profileController.profileEntity?.phoneNumber != null)
                Text(
                  "Mobile: ${profileController.profileEntity?.phoneNumber}",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              SizedBox(
                height: context.height * 0.15,
                width: context.width * 0.3,
                child: BarcodeWidget(
                  barcode: Barcode.qrCode(),
                  data: jsonEncode(profileController.profileEntity),
                  drawText: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
