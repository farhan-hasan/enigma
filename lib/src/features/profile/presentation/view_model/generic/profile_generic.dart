class ProfileGeneric {
  bool isLoading;

  ProfileGeneric({this.isLoading = false});

  ProfileGeneric update({bool? isLoading}) {
    return ProfileGeneric(isLoading: isLoading ?? this.isLoading);
  }
}
