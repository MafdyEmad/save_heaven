class FilterState {
  final String? gender;
  final String? ageGroup;
  final String? level;
  final String? orphanage;
  final String? religion;
  final String? skinTone;
  final String? hairType;

  const FilterState({
    this.gender,
    this.ageGroup,
    this.level,
    this.orphanage,
    this.religion,
    this.skinTone,
    this.hairType,
  });

  FilterState copyWith({
    String? gender,
    String? ageGroup,
    String? level,
    String? orphanage,
    String? religion,
    String? skinTone,
    String? hairType,
  }) {
    return FilterState(
      gender: gender ?? this.gender,
      ageGroup: ageGroup ?? this.ageGroup,
      level: level ?? this.level,
      orphanage: orphanage ?? this.orphanage,
      religion: religion ?? this.religion,
      skinTone: skinTone ?? this.skinTone,
      hairType: hairType ?? this.hairType,
    );
  }
}
