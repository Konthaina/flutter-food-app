class ProfileModel {
  String? name;
  String? email;
  String? avatarPath;
  String? phoneNumber;

  ProfileModel({
    required this.name,
    required this.email,
    required this.avatarPath,
    this.phoneNumber,
  });

  static List<ProfileModel> getDefaultProfile() {
    List<ProfileModel> profileList = [];
    profileList.add(
      ProfileModel(
        name: 'profile_name',
        email: 'thaina@example.com',
        avatarPath: 'assets/icons/avatar.svg',
        phoneNumber: '+855 12 345 678',
      ),
    );
    return profileList;
  }
}
