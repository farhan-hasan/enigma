import 'dart:io';

import 'package:enigma/src/core/network/remote/firebase/storage_directory_name.dart';
import 'package:enigma/src/features/chat/domain/entity/chat_entity.dart';
import 'package:enigma/src/features/chat/presentation/view-model/chat_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ChatScreenBottomBar extends ConsumerStatefulWidget {
  const ChatScreenBottomBar({super.key});

  @override
  ConsumerState<ChatScreenBottomBar> createState() =>
      _ChatScreenBottomBarState();
}

class _ChatScreenBottomBarState extends ConsumerState<ChatScreenBottomBar> {
  final ValueNotifier<TextEditingController> messageTextController =
      ValueNotifier(TextEditingController());

  File? file;
  String? url;

  void _showOptions(BuildContext context) {
    showBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            filesOption(
              title: "Camera",
              onTap: _pickCameraImage,
              icon: Icons.camera,
            ),
            filesOption(
              title: "Documents",
              subtitle: "Share your files",
              onTap: () {
                _pickDocuments(const [
                  'pdf',
                  'doc',
                  'docx',
                  'xls',
                  'xlsx',
                  'ppt',
                  'pptx',
                  'rar',
                  'zip',
                  'csv'
                ]);
              },
              icon: Icons.insert_drive_file_sharp,
            ),
            filesOption(
              title: "Create a Poll",
              subtitle: "Create a poll for any query",
              onTap: () {},
              icon: Icons.poll_outlined,
            ),
            filesOption(
              title: "Media",
              subtitle: "Share photos and videos",
              onTap: () {
                _pickDocuments(const [
                  'jpg',
                  'jpeg',
                  'png',
                  'svg',
                  'gif',
                  'webp',
                  'mp4',
                  'avi',
                  'mov',
                  'mkv',
                  'flv',
                  'wmv',
                ]);
              },
              icon: Icons.perm_media_outlined,
            ),
            filesOption(
              title: "Contract",
              subtitle: "Share your contacts",
              onTap: () {},
              icon: Icons.person,
            ),
            filesOption(
              title: "Location",
              subtitle: "Share your location",
              onTap: () {},
              icon: Icons.location_on_outlined,
            )
          ],
        );
      },
    );
  }

  void _pickCameraImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? getImage = await imagePicker.pickImage(source: ImageSource.camera);
    if (getImage != null) {
      file = File(getImage.path);
      if (file != null) {}
    } else {
      return;
    }
    return;
  }

  void _pickDocuments(List<String> extensions) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      allowedExtensions: extensions,
      type: FileType.custom,
    );
    if (result != null) {
      file = File(result.paths.first!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatController = ref.watch(chatProvider);
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            IconButton(
              onPressed: () => _showOptions(context),
              icon: Icon(
                Icons.attach_file,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Expanded(
              child: TextFormField(
                controller: messageTextController.value,
                decoration: InputDecoration(
                  filled: true,
                  fillColor:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                  hintText: "Write your message",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.file_copy_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: messageTextController.value,
              builder: (context, value, child) {
                if (value.text.trim().isEmpty) {
                  return Row(
                    children: [
                      IconButton(
                        onPressed: _pickCameraImage,
                        icon: Icon(
                          Icons.camera_alt_outlined,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.mic_none_outlined,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      )
                    ],
                  );
                } else {
                  return IconButton(
                    onPressed: () async {
                      Uuid uuid = const Uuid();
                      if (file != null) {
                        // debug(file!.path.split("/").last);
                        url =
                            await ref.read(chatProvider.notifier).addImageMedia(
                                  file: file!,
                                  directory:
                                      StorageDirectoryName.CHAT_MEDIA_DIRECTORY,
                                  fileName: file!.path.split("/").last,
                                );
                        file = null;
                        // BotToast.showText(text: "Success: $url");
                      }
                      if (messageTextController.value.text.trim().isNotEmpty) {
                        ChatEntity chatEntity = ChatEntity(
                          id: uuid.v4(),
                          content: messageTextController.value.text.trim(),
                          type: url != null ? MediaType.image : MediaType.text,
                          mediaLink: url,
                          timestamp: DateTime.now(),
                          receiver: "Y51bMMMKXAT1AQs0vPutTfVCkTB2",
                          sender: "SjKB4wFCutQyMOmrJUhXlX3eo5l1",
                        );
                        // print(chatEntity.toJson());
                        await ref
                            .read(chatProvider.notifier)
                            .addChat(chatEntity);
                        messageTextController.value.clear();
                        // debug("Success message");
                      }
                    },
                    icon: Icon(
                      Icons.send,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget filesOption({
  required String title,
  String subtitle = "",
  required Function() onTap,
  required IconData icon,
}) =>
    ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        child: Icon(icon),
        // backgroundColor: primary.withOpacity(0.5),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
    );
