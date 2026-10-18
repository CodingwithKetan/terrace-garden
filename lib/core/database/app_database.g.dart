// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $GardensTable extends Gardens with TableInfo<$GardensTable, GardenRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GardensTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 60,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SpaceType, String> spaceType =
      GeneratedColumn<String>(
        'space_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<SpaceType>($GardensTable.$converterspaceType);
  static const VerificationMeta _cityNameMeta = const VerificationMeta(
    'cityName',
  );
  @override
  late final GeneratedColumn<String> cityName = GeneratedColumn<String>(
    'city_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<GrowingRegion?, String> region =
      GeneratedColumn<String>(
        'region',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<GrowingRegion?>($GardensTable.$converterregionn);
  static const VerificationMeta _lengthCmMeta = const VerificationMeta(
    'lengthCm',
  );
  @override
  late final GeneratedColumn<double> lengthCm = GeneratedColumn<double>(
    'length_cm',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _widthCmMeta = const VerificationMeta(
    'widthCm',
  );
  @override
  late final GeneratedColumn<double> widthCm = GeneratedColumn<double>(
    'width_cm',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SunExposure, String> sun =
      GeneratedColumn<String>(
        'sun',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<SunExposure>($GardensTable.$convertersun);
  @override
  late final GeneratedColumnWithTypeConverter<Facing, String> facing =
      GeneratedColumn<String>(
        'facing',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Facing>($GardensTable.$converterfacing);
  @override
  late final GeneratedColumnWithTypeConverter<WindExposure, String> wind =
      GeneratedColumn<String>(
        'wind',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<WindExposure>($GardensTable.$converterwind);
  @override
  late final GeneratedColumnWithTypeConverter<WaterAccess, String> water =
      GeneratedColumn<String>(
        'water',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<WaterAccess>($GardensTable.$converterwater);
  static const VerificationMeta _goalsMeta = const VerificationMeta('goals');
  @override
  late final GeneratedColumn<String> goals = GeneratedColumn<String>(
    'goals',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  late final GeneratedColumnWithTypeConverter<GardenStyle?, String> style =
      GeneratedColumn<String>(
        'style',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<GardenStyle?>($GardensTable.$converterstylen);
  @override
  late final GeneratedColumnWithTypeConverter<ExperienceLevel?, String>
  experience = GeneratedColumn<String>(
    'experience',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<ExperienceLevel?>($GardensTable.$converterexperiencen);
  @override
  late final GeneratedColumnWithTypeConverter<WeeklyTime, String> weeklyTime =
      GeneratedColumn<String>(
        'weekly_time',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<WeeklyTime>($GardensTable.$converterweeklyTime);
  @override
  late final GeneratedColumnWithTypeConverter<BudgetBand, String> budget =
      GeneratedColumn<String>(
        'budget',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<BudgetBand>($GardensTable.$converterbudget);
  static const VerificationMeta _coverPhotoIdMeta = const VerificationMeta(
    'coverPhotoId',
  );
  @override
  late final GeneratedColumn<String> coverPhotoId = GeneratedColumn<String>(
    'cover_photo_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    spaceType,
    cityName,
    region,
    lengthCm,
    widthCm,
    sun,
    facing,
    wind,
    water,
    goals,
    style,
    experience,
    weeklyTime,
    budget,
    coverPhotoId,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'gardens';
  @override
  VerificationContext validateIntegrity(
    Insertable<GardenRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('city_name')) {
      context.handle(
        _cityNameMeta,
        cityName.isAcceptableOrUnknown(data['city_name']!, _cityNameMeta),
      );
    }
    if (data.containsKey('length_cm')) {
      context.handle(
        _lengthCmMeta,
        lengthCm.isAcceptableOrUnknown(data['length_cm']!, _lengthCmMeta),
      );
    }
    if (data.containsKey('width_cm')) {
      context.handle(
        _widthCmMeta,
        widthCm.isAcceptableOrUnknown(data['width_cm']!, _widthCmMeta),
      );
    }
    if (data.containsKey('goals')) {
      context.handle(
        _goalsMeta,
        goals.isAcceptableOrUnknown(data['goals']!, _goalsMeta),
      );
    }
    if (data.containsKey('cover_photo_id')) {
      context.handle(
        _coverPhotoIdMeta,
        coverPhotoId.isAcceptableOrUnknown(
          data['cover_photo_id']!,
          _coverPhotoIdMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GardenRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GardenRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      spaceType: $GardensTable.$converterspaceType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}space_type'],
        )!,
      ),
      cityName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}city_name'],
      ),
      region: $GardensTable.$converterregionn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}region'],
        ),
      ),
      lengthCm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}length_cm'],
      ),
      widthCm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}width_cm'],
      ),
      sun: $GardensTable.$convertersun.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}sun'],
        )!,
      ),
      facing: $GardensTable.$converterfacing.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}facing'],
        )!,
      ),
      wind: $GardensTable.$converterwind.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}wind'],
        )!,
      ),
      water: $GardensTable.$converterwater.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}water'],
        )!,
      ),
      goals: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}goals'],
      )!,
      style: $GardensTable.$converterstylen.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}style'],
        ),
      ),
      experience: $GardensTable.$converterexperiencen.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}experience'],
        ),
      ),
      weeklyTime: $GardensTable.$converterweeklyTime.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}weekly_time'],
        )!,
      ),
      budget: $GardensTable.$converterbudget.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}budget'],
        )!,
      ),
      coverPhotoId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cover_photo_id'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $GardensTable createAlias(String alias) {
    return $GardensTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SpaceType, String, String> $converterspaceType =
      const EnumNameConverter<SpaceType>(SpaceType.values);
  static JsonTypeConverter2<GrowingRegion, String, String> $converterregion =
      const EnumNameConverter<GrowingRegion>(GrowingRegion.values);
  static JsonTypeConverter2<GrowingRegion?, String?, String?>
  $converterregionn = JsonTypeConverter2.asNullable($converterregion);
  static JsonTypeConverter2<SunExposure, String, String> $convertersun =
      const EnumNameConverter<SunExposure>(SunExposure.values);
  static JsonTypeConverter2<Facing, String, String> $converterfacing =
      const EnumNameConverter<Facing>(Facing.values);
  static JsonTypeConverter2<WindExposure, String, String> $converterwind =
      const EnumNameConverter<WindExposure>(WindExposure.values);
  static JsonTypeConverter2<WaterAccess, String, String> $converterwater =
      const EnumNameConverter<WaterAccess>(WaterAccess.values);
  static JsonTypeConverter2<GardenStyle, String, String> $converterstyle =
      const EnumNameConverter<GardenStyle>(GardenStyle.values);
  static JsonTypeConverter2<GardenStyle?, String?, String?> $converterstylen =
      JsonTypeConverter2.asNullable($converterstyle);
  static JsonTypeConverter2<ExperienceLevel, String, String>
  $converterexperience = const EnumNameConverter<ExperienceLevel>(
    ExperienceLevel.values,
  );
  static JsonTypeConverter2<ExperienceLevel?, String?, String?>
  $converterexperiencen = JsonTypeConverter2.asNullable($converterexperience);
  static JsonTypeConverter2<WeeklyTime, String, String> $converterweeklyTime =
      const EnumNameConverter<WeeklyTime>(WeeklyTime.values);
  static JsonTypeConverter2<BudgetBand, String, String> $converterbudget =
      const EnumNameConverter<BudgetBand>(BudgetBand.values);
}

class GardenRow extends DataClass implements Insertable<GardenRow> {
  final String id;
  final String name;
  final SpaceType spaceType;
  final String? cityName;
  final GrowingRegion? region;
  final double? lengthCm;
  final double? widthCm;
  final SunExposure sun;
  final Facing facing;
  final WindExposure wind;
  final WaterAccess water;

  /// Comma-separated `GardenGoal` names (a small, closed set).
  final String goals;
  final GardenStyle? style;
  final ExperienceLevel? experience;
  final WeeklyTime weeklyTime;
  final BudgetBand budget;
  final String? coverPhotoId;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const GardenRow({
    required this.id,
    required this.name,
    required this.spaceType,
    this.cityName,
    this.region,
    this.lengthCm,
    this.widthCm,
    required this.sun,
    required this.facing,
    required this.wind,
    required this.water,
    required this.goals,
    this.style,
    this.experience,
    required this.weeklyTime,
    required this.budget,
    this.coverPhotoId,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    {
      map['space_type'] = Variable<String>(
        $GardensTable.$converterspaceType.toSql(spaceType),
      );
    }
    if (!nullToAbsent || cityName != null) {
      map['city_name'] = Variable<String>(cityName);
    }
    if (!nullToAbsent || region != null) {
      map['region'] = Variable<String>(
        $GardensTable.$converterregionn.toSql(region),
      );
    }
    if (!nullToAbsent || lengthCm != null) {
      map['length_cm'] = Variable<double>(lengthCm);
    }
    if (!nullToAbsent || widthCm != null) {
      map['width_cm'] = Variable<double>(widthCm);
    }
    {
      map['sun'] = Variable<String>($GardensTable.$convertersun.toSql(sun));
    }
    {
      map['facing'] = Variable<String>(
        $GardensTable.$converterfacing.toSql(facing),
      );
    }
    {
      map['wind'] = Variable<String>($GardensTable.$converterwind.toSql(wind));
    }
    {
      map['water'] = Variable<String>(
        $GardensTable.$converterwater.toSql(water),
      );
    }
    map['goals'] = Variable<String>(goals);
    if (!nullToAbsent || style != null) {
      map['style'] = Variable<String>(
        $GardensTable.$converterstylen.toSql(style),
      );
    }
    if (!nullToAbsent || experience != null) {
      map['experience'] = Variable<String>(
        $GardensTable.$converterexperiencen.toSql(experience),
      );
    }
    {
      map['weekly_time'] = Variable<String>(
        $GardensTable.$converterweeklyTime.toSql(weeklyTime),
      );
    }
    {
      map['budget'] = Variable<String>(
        $GardensTable.$converterbudget.toSql(budget),
      );
    }
    if (!nullToAbsent || coverPhotoId != null) {
      map['cover_photo_id'] = Variable<String>(coverPhotoId);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  GardensCompanion toCompanion(bool nullToAbsent) {
    return GardensCompanion(
      id: Value(id),
      name: Value(name),
      spaceType: Value(spaceType),
      cityName: cityName == null && nullToAbsent
          ? const Value.absent()
          : Value(cityName),
      region: region == null && nullToAbsent
          ? const Value.absent()
          : Value(region),
      lengthCm: lengthCm == null && nullToAbsent
          ? const Value.absent()
          : Value(lengthCm),
      widthCm: widthCm == null && nullToAbsent
          ? const Value.absent()
          : Value(widthCm),
      sun: Value(sun),
      facing: Value(facing),
      wind: Value(wind),
      water: Value(water),
      goals: Value(goals),
      style: style == null && nullToAbsent
          ? const Value.absent()
          : Value(style),
      experience: experience == null && nullToAbsent
          ? const Value.absent()
          : Value(experience),
      weeklyTime: Value(weeklyTime),
      budget: Value(budget),
      coverPhotoId: coverPhotoId == null && nullToAbsent
          ? const Value.absent()
          : Value(coverPhotoId),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory GardenRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GardenRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      spaceType: $GardensTable.$converterspaceType.fromJson(
        serializer.fromJson<String>(json['spaceType']),
      ),
      cityName: serializer.fromJson<String?>(json['cityName']),
      region: $GardensTable.$converterregionn.fromJson(
        serializer.fromJson<String?>(json['region']),
      ),
      lengthCm: serializer.fromJson<double?>(json['lengthCm']),
      widthCm: serializer.fromJson<double?>(json['widthCm']),
      sun: $GardensTable.$convertersun.fromJson(
        serializer.fromJson<String>(json['sun']),
      ),
      facing: $GardensTable.$converterfacing.fromJson(
        serializer.fromJson<String>(json['facing']),
      ),
      wind: $GardensTable.$converterwind.fromJson(
        serializer.fromJson<String>(json['wind']),
      ),
      water: $GardensTable.$converterwater.fromJson(
        serializer.fromJson<String>(json['water']),
      ),
      goals: serializer.fromJson<String>(json['goals']),
      style: $GardensTable.$converterstylen.fromJson(
        serializer.fromJson<String?>(json['style']),
      ),
      experience: $GardensTable.$converterexperiencen.fromJson(
        serializer.fromJson<String?>(json['experience']),
      ),
      weeklyTime: $GardensTable.$converterweeklyTime.fromJson(
        serializer.fromJson<String>(json['weeklyTime']),
      ),
      budget: $GardensTable.$converterbudget.fromJson(
        serializer.fromJson<String>(json['budget']),
      ),
      coverPhotoId: serializer.fromJson<String?>(json['coverPhotoId']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'spaceType': serializer.toJson<String>(
        $GardensTable.$converterspaceType.toJson(spaceType),
      ),
      'cityName': serializer.toJson<String?>(cityName),
      'region': serializer.toJson<String?>(
        $GardensTable.$converterregionn.toJson(region),
      ),
      'lengthCm': serializer.toJson<double?>(lengthCm),
      'widthCm': serializer.toJson<double?>(widthCm),
      'sun': serializer.toJson<String>($GardensTable.$convertersun.toJson(sun)),
      'facing': serializer.toJson<String>(
        $GardensTable.$converterfacing.toJson(facing),
      ),
      'wind': serializer.toJson<String>(
        $GardensTable.$converterwind.toJson(wind),
      ),
      'water': serializer.toJson<String>(
        $GardensTable.$converterwater.toJson(water),
      ),
      'goals': serializer.toJson<String>(goals),
      'style': serializer.toJson<String?>(
        $GardensTable.$converterstylen.toJson(style),
      ),
      'experience': serializer.toJson<String?>(
        $GardensTable.$converterexperiencen.toJson(experience),
      ),
      'weeklyTime': serializer.toJson<String>(
        $GardensTable.$converterweeklyTime.toJson(weeklyTime),
      ),
      'budget': serializer.toJson<String>(
        $GardensTable.$converterbudget.toJson(budget),
      ),
      'coverPhotoId': serializer.toJson<String?>(coverPhotoId),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  GardenRow copyWith({
    String? id,
    String? name,
    SpaceType? spaceType,
    Value<String?> cityName = const Value.absent(),
    Value<GrowingRegion?> region = const Value.absent(),
    Value<double?> lengthCm = const Value.absent(),
    Value<double?> widthCm = const Value.absent(),
    SunExposure? sun,
    Facing? facing,
    WindExposure? wind,
    WaterAccess? water,
    String? goals,
    Value<GardenStyle?> style = const Value.absent(),
    Value<ExperienceLevel?> experience = const Value.absent(),
    WeeklyTime? weeklyTime,
    BudgetBand? budget,
    Value<String?> coverPhotoId = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => GardenRow(
    id: id ?? this.id,
    name: name ?? this.name,
    spaceType: spaceType ?? this.spaceType,
    cityName: cityName.present ? cityName.value : this.cityName,
    region: region.present ? region.value : this.region,
    lengthCm: lengthCm.present ? lengthCm.value : this.lengthCm,
    widthCm: widthCm.present ? widthCm.value : this.widthCm,
    sun: sun ?? this.sun,
    facing: facing ?? this.facing,
    wind: wind ?? this.wind,
    water: water ?? this.water,
    goals: goals ?? this.goals,
    style: style.present ? style.value : this.style,
    experience: experience.present ? experience.value : this.experience,
    weeklyTime: weeklyTime ?? this.weeklyTime,
    budget: budget ?? this.budget,
    coverPhotoId: coverPhotoId.present ? coverPhotoId.value : this.coverPhotoId,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  GardenRow copyWithCompanion(GardensCompanion data) {
    return GardenRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      spaceType: data.spaceType.present ? data.spaceType.value : this.spaceType,
      cityName: data.cityName.present ? data.cityName.value : this.cityName,
      region: data.region.present ? data.region.value : this.region,
      lengthCm: data.lengthCm.present ? data.lengthCm.value : this.lengthCm,
      widthCm: data.widthCm.present ? data.widthCm.value : this.widthCm,
      sun: data.sun.present ? data.sun.value : this.sun,
      facing: data.facing.present ? data.facing.value : this.facing,
      wind: data.wind.present ? data.wind.value : this.wind,
      water: data.water.present ? data.water.value : this.water,
      goals: data.goals.present ? data.goals.value : this.goals,
      style: data.style.present ? data.style.value : this.style,
      experience: data.experience.present
          ? data.experience.value
          : this.experience,
      weeklyTime: data.weeklyTime.present
          ? data.weeklyTime.value
          : this.weeklyTime,
      budget: data.budget.present ? data.budget.value : this.budget,
      coverPhotoId: data.coverPhotoId.present
          ? data.coverPhotoId.value
          : this.coverPhotoId,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GardenRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('spaceType: $spaceType, ')
          ..write('cityName: $cityName, ')
          ..write('region: $region, ')
          ..write('lengthCm: $lengthCm, ')
          ..write('widthCm: $widthCm, ')
          ..write('sun: $sun, ')
          ..write('facing: $facing, ')
          ..write('wind: $wind, ')
          ..write('water: $water, ')
          ..write('goals: $goals, ')
          ..write('style: $style, ')
          ..write('experience: $experience, ')
          ..write('weeklyTime: $weeklyTime, ')
          ..write('budget: $budget, ')
          ..write('coverPhotoId: $coverPhotoId, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    spaceType,
    cityName,
    region,
    lengthCm,
    widthCm,
    sun,
    facing,
    wind,
    water,
    goals,
    style,
    experience,
    weeklyTime,
    budget,
    coverPhotoId,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GardenRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.spaceType == this.spaceType &&
          other.cityName == this.cityName &&
          other.region == this.region &&
          other.lengthCm == this.lengthCm &&
          other.widthCm == this.widthCm &&
          other.sun == this.sun &&
          other.facing == this.facing &&
          other.wind == this.wind &&
          other.water == this.water &&
          other.goals == this.goals &&
          other.style == this.style &&
          other.experience == this.experience &&
          other.weeklyTime == this.weeklyTime &&
          other.budget == this.budget &&
          other.coverPhotoId == this.coverPhotoId &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class GardensCompanion extends UpdateCompanion<GardenRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<SpaceType> spaceType;
  final Value<String?> cityName;
  final Value<GrowingRegion?> region;
  final Value<double?> lengthCm;
  final Value<double?> widthCm;
  final Value<SunExposure> sun;
  final Value<Facing> facing;
  final Value<WindExposure> wind;
  final Value<WaterAccess> water;
  final Value<String> goals;
  final Value<GardenStyle?> style;
  final Value<ExperienceLevel?> experience;
  final Value<WeeklyTime> weeklyTime;
  final Value<BudgetBand> budget;
  final Value<String?> coverPhotoId;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const GardensCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.spaceType = const Value.absent(),
    this.cityName = const Value.absent(),
    this.region = const Value.absent(),
    this.lengthCm = const Value.absent(),
    this.widthCm = const Value.absent(),
    this.sun = const Value.absent(),
    this.facing = const Value.absent(),
    this.wind = const Value.absent(),
    this.water = const Value.absent(),
    this.goals = const Value.absent(),
    this.style = const Value.absent(),
    this.experience = const Value.absent(),
    this.weeklyTime = const Value.absent(),
    this.budget = const Value.absent(),
    this.coverPhotoId = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GardensCompanion.insert({
    required String id,
    required String name,
    required SpaceType spaceType,
    this.cityName = const Value.absent(),
    this.region = const Value.absent(),
    this.lengthCm = const Value.absent(),
    this.widthCm = const Value.absent(),
    required SunExposure sun,
    required Facing facing,
    required WindExposure wind,
    required WaterAccess water,
    this.goals = const Value.absent(),
    this.style = const Value.absent(),
    this.experience = const Value.absent(),
    required WeeklyTime weeklyTime,
    required BudgetBand budget,
    this.coverPhotoId = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       spaceType = Value(spaceType),
       sun = Value(sun),
       facing = Value(facing),
       wind = Value(wind),
       water = Value(water),
       weeklyTime = Value(weeklyTime),
       budget = Value(budget),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<GardenRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? spaceType,
    Expression<String>? cityName,
    Expression<String>? region,
    Expression<double>? lengthCm,
    Expression<double>? widthCm,
    Expression<String>? sun,
    Expression<String>? facing,
    Expression<String>? wind,
    Expression<String>? water,
    Expression<String>? goals,
    Expression<String>? style,
    Expression<String>? experience,
    Expression<String>? weeklyTime,
    Expression<String>? budget,
    Expression<String>? coverPhotoId,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (spaceType != null) 'space_type': spaceType,
      if (cityName != null) 'city_name': cityName,
      if (region != null) 'region': region,
      if (lengthCm != null) 'length_cm': lengthCm,
      if (widthCm != null) 'width_cm': widthCm,
      if (sun != null) 'sun': sun,
      if (facing != null) 'facing': facing,
      if (wind != null) 'wind': wind,
      if (water != null) 'water': water,
      if (goals != null) 'goals': goals,
      if (style != null) 'style': style,
      if (experience != null) 'experience': experience,
      if (weeklyTime != null) 'weekly_time': weeklyTime,
      if (budget != null) 'budget': budget,
      if (coverPhotoId != null) 'cover_photo_id': coverPhotoId,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GardensCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<SpaceType>? spaceType,
    Value<String?>? cityName,
    Value<GrowingRegion?>? region,
    Value<double?>? lengthCm,
    Value<double?>? widthCm,
    Value<SunExposure>? sun,
    Value<Facing>? facing,
    Value<WindExposure>? wind,
    Value<WaterAccess>? water,
    Value<String>? goals,
    Value<GardenStyle?>? style,
    Value<ExperienceLevel?>? experience,
    Value<WeeklyTime>? weeklyTime,
    Value<BudgetBand>? budget,
    Value<String?>? coverPhotoId,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return GardensCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      spaceType: spaceType ?? this.spaceType,
      cityName: cityName ?? this.cityName,
      region: region ?? this.region,
      lengthCm: lengthCm ?? this.lengthCm,
      widthCm: widthCm ?? this.widthCm,
      sun: sun ?? this.sun,
      facing: facing ?? this.facing,
      wind: wind ?? this.wind,
      water: water ?? this.water,
      goals: goals ?? this.goals,
      style: style ?? this.style,
      experience: experience ?? this.experience,
      weeklyTime: weeklyTime ?? this.weeklyTime,
      budget: budget ?? this.budget,
      coverPhotoId: coverPhotoId ?? this.coverPhotoId,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (spaceType.present) {
      map['space_type'] = Variable<String>(
        $GardensTable.$converterspaceType.toSql(spaceType.value),
      );
    }
    if (cityName.present) {
      map['city_name'] = Variable<String>(cityName.value);
    }
    if (region.present) {
      map['region'] = Variable<String>(
        $GardensTable.$converterregionn.toSql(region.value),
      );
    }
    if (lengthCm.present) {
      map['length_cm'] = Variable<double>(lengthCm.value);
    }
    if (widthCm.present) {
      map['width_cm'] = Variable<double>(widthCm.value);
    }
    if (sun.present) {
      map['sun'] = Variable<String>(
        $GardensTable.$convertersun.toSql(sun.value),
      );
    }
    if (facing.present) {
      map['facing'] = Variable<String>(
        $GardensTable.$converterfacing.toSql(facing.value),
      );
    }
    if (wind.present) {
      map['wind'] = Variable<String>(
        $GardensTable.$converterwind.toSql(wind.value),
      );
    }
    if (water.present) {
      map['water'] = Variable<String>(
        $GardensTable.$converterwater.toSql(water.value),
      );
    }
    if (goals.present) {
      map['goals'] = Variable<String>(goals.value);
    }
    if (style.present) {
      map['style'] = Variable<String>(
        $GardensTable.$converterstylen.toSql(style.value),
      );
    }
    if (experience.present) {
      map['experience'] = Variable<String>(
        $GardensTable.$converterexperiencen.toSql(experience.value),
      );
    }
    if (weeklyTime.present) {
      map['weekly_time'] = Variable<String>(
        $GardensTable.$converterweeklyTime.toSql(weeklyTime.value),
      );
    }
    if (budget.present) {
      map['budget'] = Variable<String>(
        $GardensTable.$converterbudget.toSql(budget.value),
      );
    }
    if (coverPhotoId.present) {
      map['cover_photo_id'] = Variable<String>(coverPhotoId.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GardensCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('spaceType: $spaceType, ')
          ..write('cityName: $cityName, ')
          ..write('region: $region, ')
          ..write('lengthCm: $lengthCm, ')
          ..write('widthCm: $widthCm, ')
          ..write('sun: $sun, ')
          ..write('facing: $facing, ')
          ..write('wind: $wind, ')
          ..write('water: $water, ')
          ..write('goals: $goals, ')
          ..write('style: $style, ')
          ..write('experience: $experience, ')
          ..write('weeklyTime: $weeklyTime, ')
          ..write('budget: $budget, ')
          ..write('coverPhotoId: $coverPhotoId, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GardenPhotosTable extends GardenPhotos
    with TableInfo<$GardenPhotosTable, GardenPhotoRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GardenPhotosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gardenIdMeta = const VerificationMeta(
    'gardenId',
  );
  @override
  late final GeneratedColumn<String> gardenId = GeneratedColumn<String>(
    'garden_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES gardens (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _relativePathMeta = const VerificationMeta(
    'relativePath',
  );
  @override
  late final GeneratedColumn<String> relativePath = GeneratedColumn<String>(
    'relative_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _thumbnailPathMeta = const VerificationMeta(
    'thumbnailPath',
  );
  @override
  late final GeneratedColumn<String> thumbnailPath = GeneratedColumn<String>(
    'thumbnail_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _captionMeta = const VerificationMeta(
    'caption',
  );
  @override
  late final GeneratedColumn<String> caption = GeneratedColumn<String>(
    'caption',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _widthMeta = const VerificationMeta('width');
  @override
  late final GeneratedColumn<int> width = GeneratedColumn<int>(
    'width',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<int> height = GeneratedColumn<int>(
    'height',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _takenAtMeta = const VerificationMeta(
    'takenAt',
  );
  @override
  late final GeneratedColumn<DateTime> takenAt = GeneratedColumn<DateTime>(
    'taken_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    gardenId,
    relativePath,
    thumbnailPath,
    caption,
    width,
    height,
    takenAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'garden_photos';
  @override
  VerificationContext validateIntegrity(
    Insertable<GardenPhotoRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('garden_id')) {
      context.handle(
        _gardenIdMeta,
        gardenId.isAcceptableOrUnknown(data['garden_id']!, _gardenIdMeta),
      );
    } else if (isInserting) {
      context.missing(_gardenIdMeta);
    }
    if (data.containsKey('relative_path')) {
      context.handle(
        _relativePathMeta,
        relativePath.isAcceptableOrUnknown(
          data['relative_path']!,
          _relativePathMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_relativePathMeta);
    }
    if (data.containsKey('thumbnail_path')) {
      context.handle(
        _thumbnailPathMeta,
        thumbnailPath.isAcceptableOrUnknown(
          data['thumbnail_path']!,
          _thumbnailPathMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_thumbnailPathMeta);
    }
    if (data.containsKey('caption')) {
      context.handle(
        _captionMeta,
        caption.isAcceptableOrUnknown(data['caption']!, _captionMeta),
      );
    }
    if (data.containsKey('width')) {
      context.handle(
        _widthMeta,
        width.isAcceptableOrUnknown(data['width']!, _widthMeta),
      );
    } else if (isInserting) {
      context.missing(_widthMeta);
    }
    if (data.containsKey('height')) {
      context.handle(
        _heightMeta,
        height.isAcceptableOrUnknown(data['height']!, _heightMeta),
      );
    } else if (isInserting) {
      context.missing(_heightMeta);
    }
    if (data.containsKey('taken_at')) {
      context.handle(
        _takenAtMeta,
        takenAt.isAcceptableOrUnknown(data['taken_at']!, _takenAtMeta),
      );
    } else if (isInserting) {
      context.missing(_takenAtMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GardenPhotoRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GardenPhotoRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      gardenId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}garden_id'],
      )!,
      relativePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}relative_path'],
      )!,
      thumbnailPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}thumbnail_path'],
      )!,
      caption: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}caption'],
      ),
      width: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}width'],
      )!,
      height: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}height'],
      )!,
      takenAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}taken_at'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $GardenPhotosTable createAlias(String alias) {
    return $GardenPhotosTable(attachedDatabase, alias);
  }
}

class GardenPhotoRow extends DataClass implements Insertable<GardenPhotoRow> {
  final String id;
  final String gardenId;

  /// Paths relative to the app documents directory.
  final String relativePath;
  final String thumbnailPath;
  final String? caption;
  final int width;
  final int height;
  final DateTime takenAt;
  final DateTime createdAt;
  const GardenPhotoRow({
    required this.id,
    required this.gardenId,
    required this.relativePath,
    required this.thumbnailPath,
    this.caption,
    required this.width,
    required this.height,
    required this.takenAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['garden_id'] = Variable<String>(gardenId);
    map['relative_path'] = Variable<String>(relativePath);
    map['thumbnail_path'] = Variable<String>(thumbnailPath);
    if (!nullToAbsent || caption != null) {
      map['caption'] = Variable<String>(caption);
    }
    map['width'] = Variable<int>(width);
    map['height'] = Variable<int>(height);
    map['taken_at'] = Variable<DateTime>(takenAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  GardenPhotosCompanion toCompanion(bool nullToAbsent) {
    return GardenPhotosCompanion(
      id: Value(id),
      gardenId: Value(gardenId),
      relativePath: Value(relativePath),
      thumbnailPath: Value(thumbnailPath),
      caption: caption == null && nullToAbsent
          ? const Value.absent()
          : Value(caption),
      width: Value(width),
      height: Value(height),
      takenAt: Value(takenAt),
      createdAt: Value(createdAt),
    );
  }

  factory GardenPhotoRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GardenPhotoRow(
      id: serializer.fromJson<String>(json['id']),
      gardenId: serializer.fromJson<String>(json['gardenId']),
      relativePath: serializer.fromJson<String>(json['relativePath']),
      thumbnailPath: serializer.fromJson<String>(json['thumbnailPath']),
      caption: serializer.fromJson<String?>(json['caption']),
      width: serializer.fromJson<int>(json['width']),
      height: serializer.fromJson<int>(json['height']),
      takenAt: serializer.fromJson<DateTime>(json['takenAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'gardenId': serializer.toJson<String>(gardenId),
      'relativePath': serializer.toJson<String>(relativePath),
      'thumbnailPath': serializer.toJson<String>(thumbnailPath),
      'caption': serializer.toJson<String?>(caption),
      'width': serializer.toJson<int>(width),
      'height': serializer.toJson<int>(height),
      'takenAt': serializer.toJson<DateTime>(takenAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  GardenPhotoRow copyWith({
    String? id,
    String? gardenId,
    String? relativePath,
    String? thumbnailPath,
    Value<String?> caption = const Value.absent(),
    int? width,
    int? height,
    DateTime? takenAt,
    DateTime? createdAt,
  }) => GardenPhotoRow(
    id: id ?? this.id,
    gardenId: gardenId ?? this.gardenId,
    relativePath: relativePath ?? this.relativePath,
    thumbnailPath: thumbnailPath ?? this.thumbnailPath,
    caption: caption.present ? caption.value : this.caption,
    width: width ?? this.width,
    height: height ?? this.height,
    takenAt: takenAt ?? this.takenAt,
    createdAt: createdAt ?? this.createdAt,
  );
  GardenPhotoRow copyWithCompanion(GardenPhotosCompanion data) {
    return GardenPhotoRow(
      id: data.id.present ? data.id.value : this.id,
      gardenId: data.gardenId.present ? data.gardenId.value : this.gardenId,
      relativePath: data.relativePath.present
          ? data.relativePath.value
          : this.relativePath,
      thumbnailPath: data.thumbnailPath.present
          ? data.thumbnailPath.value
          : this.thumbnailPath,
      caption: data.caption.present ? data.caption.value : this.caption,
      width: data.width.present ? data.width.value : this.width,
      height: data.height.present ? data.height.value : this.height,
      takenAt: data.takenAt.present ? data.takenAt.value : this.takenAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GardenPhotoRow(')
          ..write('id: $id, ')
          ..write('gardenId: $gardenId, ')
          ..write('relativePath: $relativePath, ')
          ..write('thumbnailPath: $thumbnailPath, ')
          ..write('caption: $caption, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('takenAt: $takenAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    gardenId,
    relativePath,
    thumbnailPath,
    caption,
    width,
    height,
    takenAt,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GardenPhotoRow &&
          other.id == this.id &&
          other.gardenId == this.gardenId &&
          other.relativePath == this.relativePath &&
          other.thumbnailPath == this.thumbnailPath &&
          other.caption == this.caption &&
          other.width == this.width &&
          other.height == this.height &&
          other.takenAt == this.takenAt &&
          other.createdAt == this.createdAt);
}

class GardenPhotosCompanion extends UpdateCompanion<GardenPhotoRow> {
  final Value<String> id;
  final Value<String> gardenId;
  final Value<String> relativePath;
  final Value<String> thumbnailPath;
  final Value<String?> caption;
  final Value<int> width;
  final Value<int> height;
  final Value<DateTime> takenAt;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const GardenPhotosCompanion({
    this.id = const Value.absent(),
    this.gardenId = const Value.absent(),
    this.relativePath = const Value.absent(),
    this.thumbnailPath = const Value.absent(),
    this.caption = const Value.absent(),
    this.width = const Value.absent(),
    this.height = const Value.absent(),
    this.takenAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GardenPhotosCompanion.insert({
    required String id,
    required String gardenId,
    required String relativePath,
    required String thumbnailPath,
    this.caption = const Value.absent(),
    required int width,
    required int height,
    required DateTime takenAt,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       gardenId = Value(gardenId),
       relativePath = Value(relativePath),
       thumbnailPath = Value(thumbnailPath),
       width = Value(width),
       height = Value(height),
       takenAt = Value(takenAt),
       createdAt = Value(createdAt);
  static Insertable<GardenPhotoRow> custom({
    Expression<String>? id,
    Expression<String>? gardenId,
    Expression<String>? relativePath,
    Expression<String>? thumbnailPath,
    Expression<String>? caption,
    Expression<int>? width,
    Expression<int>? height,
    Expression<DateTime>? takenAt,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (gardenId != null) 'garden_id': gardenId,
      if (relativePath != null) 'relative_path': relativePath,
      if (thumbnailPath != null) 'thumbnail_path': thumbnailPath,
      if (caption != null) 'caption': caption,
      if (width != null) 'width': width,
      if (height != null) 'height': height,
      if (takenAt != null) 'taken_at': takenAt,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GardenPhotosCompanion copyWith({
    Value<String>? id,
    Value<String>? gardenId,
    Value<String>? relativePath,
    Value<String>? thumbnailPath,
    Value<String?>? caption,
    Value<int>? width,
    Value<int>? height,
    Value<DateTime>? takenAt,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return GardenPhotosCompanion(
      id: id ?? this.id,
      gardenId: gardenId ?? this.gardenId,
      relativePath: relativePath ?? this.relativePath,
      thumbnailPath: thumbnailPath ?? this.thumbnailPath,
      caption: caption ?? this.caption,
      width: width ?? this.width,
      height: height ?? this.height,
      takenAt: takenAt ?? this.takenAt,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (gardenId.present) {
      map['garden_id'] = Variable<String>(gardenId.value);
    }
    if (relativePath.present) {
      map['relative_path'] = Variable<String>(relativePath.value);
    }
    if (thumbnailPath.present) {
      map['thumbnail_path'] = Variable<String>(thumbnailPath.value);
    }
    if (caption.present) {
      map['caption'] = Variable<String>(caption.value);
    }
    if (width.present) {
      map['width'] = Variable<int>(width.value);
    }
    if (height.present) {
      map['height'] = Variable<int>(height.value);
    }
    if (takenAt.present) {
      map['taken_at'] = Variable<DateTime>(takenAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GardenPhotosCompanion(')
          ..write('id: $id, ')
          ..write('gardenId: $gardenId, ')
          ..write('relativePath: $relativePath, ')
          ..write('thumbnailPath: $thumbnailPath, ')
          ..write('caption: $caption, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('takenAt: $takenAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LayoutElementsTable extends LayoutElements
    with TableInfo<$LayoutElementsTable, LayoutElementRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LayoutElementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gardenIdMeta = const VerificationMeta(
    'gardenId',
  );
  @override
  late final GeneratedColumn<String> gardenId = GeneratedColumn<String>(
    'garden_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES gardens (id) ON DELETE CASCADE',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<ElementKind, String> kind =
      GeneratedColumn<String>(
        'kind',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<ElementKind>($LayoutElementsTable.$converterkind);
  static const VerificationMeta _centerXMeta = const VerificationMeta(
    'centerX',
  );
  @override
  late final GeneratedColumn<double> centerX = GeneratedColumn<double>(
    'center_x',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _centerYMeta = const VerificationMeta(
    'centerY',
  );
  @override
  late final GeneratedColumn<double> centerY = GeneratedColumn<double>(
    'center_y',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _widthMeta = const VerificationMeta('width');
  @override
  late final GeneratedColumn<double> width = GeneratedColumn<double>(
    'width',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<double> height = GeneratedColumn<double>(
    'height',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rotationDegMeta = const VerificationMeta(
    'rotationDeg',
  );
  @override
  late final GeneratedColumn<double> rotationDeg = GeneratedColumn<double>(
    'rotation_deg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _depthCmMeta = const VerificationMeta(
    'depthCm',
  );
  @override
  late final GeneratedColumn<double> depthCm = GeneratedColumn<double>(
    'depth_cm',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _zIndexMeta = const VerificationMeta('zIndex');
  @override
  late final GeneratedColumn<int> zIndex = GeneratedColumn<int>(
    'z_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    gardenId,
    kind,
    centerX,
    centerY,
    width,
    height,
    rotationDeg,
    depthCm,
    label,
    zIndex,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'layout_elements';
  @override
  VerificationContext validateIntegrity(
    Insertable<LayoutElementRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('garden_id')) {
      context.handle(
        _gardenIdMeta,
        gardenId.isAcceptableOrUnknown(data['garden_id']!, _gardenIdMeta),
      );
    } else if (isInserting) {
      context.missing(_gardenIdMeta);
    }
    if (data.containsKey('center_x')) {
      context.handle(
        _centerXMeta,
        centerX.isAcceptableOrUnknown(data['center_x']!, _centerXMeta),
      );
    } else if (isInserting) {
      context.missing(_centerXMeta);
    }
    if (data.containsKey('center_y')) {
      context.handle(
        _centerYMeta,
        centerY.isAcceptableOrUnknown(data['center_y']!, _centerYMeta),
      );
    } else if (isInserting) {
      context.missing(_centerYMeta);
    }
    if (data.containsKey('width')) {
      context.handle(
        _widthMeta,
        width.isAcceptableOrUnknown(data['width']!, _widthMeta),
      );
    } else if (isInserting) {
      context.missing(_widthMeta);
    }
    if (data.containsKey('height')) {
      context.handle(
        _heightMeta,
        height.isAcceptableOrUnknown(data['height']!, _heightMeta),
      );
    } else if (isInserting) {
      context.missing(_heightMeta);
    }
    if (data.containsKey('rotation_deg')) {
      context.handle(
        _rotationDegMeta,
        rotationDeg.isAcceptableOrUnknown(
          data['rotation_deg']!,
          _rotationDegMeta,
        ),
      );
    }
    if (data.containsKey('depth_cm')) {
      context.handle(
        _depthCmMeta,
        depthCm.isAcceptableOrUnknown(data['depth_cm']!, _depthCmMeta),
      );
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    }
    if (data.containsKey('z_index')) {
      context.handle(
        _zIndexMeta,
        zIndex.isAcceptableOrUnknown(data['z_index']!, _zIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_zIndexMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LayoutElementRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LayoutElementRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      gardenId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}garden_id'],
      )!,
      kind: $LayoutElementsTable.$converterkind.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}kind'],
        )!,
      ),
      centerX: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}center_x'],
      )!,
      centerY: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}center_y'],
      )!,
      width: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}width'],
      )!,
      height: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}height'],
      )!,
      rotationDeg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rotation_deg'],
      )!,
      depthCm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}depth_cm'],
      ),
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      ),
      zIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}z_index'],
      )!,
    );
  }

  @override
  $LayoutElementsTable createAlias(String alias) {
    return $LayoutElementsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ElementKind, String, String> $converterkind =
      const EnumNameConverter<ElementKind>(ElementKind.values);
}

class LayoutElementRow extends DataClass
    implements Insertable<LayoutElementRow> {
  final String id;
  final String gardenId;
  final ElementKind kind;
  final double centerX;
  final double centerY;
  final double width;
  final double height;
  final double rotationDeg;
  final double? depthCm;
  final String? label;

  /// Drawing order: higher draws on top.
  final int zIndex;
  const LayoutElementRow({
    required this.id,
    required this.gardenId,
    required this.kind,
    required this.centerX,
    required this.centerY,
    required this.width,
    required this.height,
    required this.rotationDeg,
    this.depthCm,
    this.label,
    required this.zIndex,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['garden_id'] = Variable<String>(gardenId);
    {
      map['kind'] = Variable<String>(
        $LayoutElementsTable.$converterkind.toSql(kind),
      );
    }
    map['center_x'] = Variable<double>(centerX);
    map['center_y'] = Variable<double>(centerY);
    map['width'] = Variable<double>(width);
    map['height'] = Variable<double>(height);
    map['rotation_deg'] = Variable<double>(rotationDeg);
    if (!nullToAbsent || depthCm != null) {
      map['depth_cm'] = Variable<double>(depthCm);
    }
    if (!nullToAbsent || label != null) {
      map['label'] = Variable<String>(label);
    }
    map['z_index'] = Variable<int>(zIndex);
    return map;
  }

  LayoutElementsCompanion toCompanion(bool nullToAbsent) {
    return LayoutElementsCompanion(
      id: Value(id),
      gardenId: Value(gardenId),
      kind: Value(kind),
      centerX: Value(centerX),
      centerY: Value(centerY),
      width: Value(width),
      height: Value(height),
      rotationDeg: Value(rotationDeg),
      depthCm: depthCm == null && nullToAbsent
          ? const Value.absent()
          : Value(depthCm),
      label: label == null && nullToAbsent
          ? const Value.absent()
          : Value(label),
      zIndex: Value(zIndex),
    );
  }

  factory LayoutElementRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LayoutElementRow(
      id: serializer.fromJson<String>(json['id']),
      gardenId: serializer.fromJson<String>(json['gardenId']),
      kind: $LayoutElementsTable.$converterkind.fromJson(
        serializer.fromJson<String>(json['kind']),
      ),
      centerX: serializer.fromJson<double>(json['centerX']),
      centerY: serializer.fromJson<double>(json['centerY']),
      width: serializer.fromJson<double>(json['width']),
      height: serializer.fromJson<double>(json['height']),
      rotationDeg: serializer.fromJson<double>(json['rotationDeg']),
      depthCm: serializer.fromJson<double?>(json['depthCm']),
      label: serializer.fromJson<String?>(json['label']),
      zIndex: serializer.fromJson<int>(json['zIndex']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'gardenId': serializer.toJson<String>(gardenId),
      'kind': serializer.toJson<String>(
        $LayoutElementsTable.$converterkind.toJson(kind),
      ),
      'centerX': serializer.toJson<double>(centerX),
      'centerY': serializer.toJson<double>(centerY),
      'width': serializer.toJson<double>(width),
      'height': serializer.toJson<double>(height),
      'rotationDeg': serializer.toJson<double>(rotationDeg),
      'depthCm': serializer.toJson<double?>(depthCm),
      'label': serializer.toJson<String?>(label),
      'zIndex': serializer.toJson<int>(zIndex),
    };
  }

  LayoutElementRow copyWith({
    String? id,
    String? gardenId,
    ElementKind? kind,
    double? centerX,
    double? centerY,
    double? width,
    double? height,
    double? rotationDeg,
    Value<double?> depthCm = const Value.absent(),
    Value<String?> label = const Value.absent(),
    int? zIndex,
  }) => LayoutElementRow(
    id: id ?? this.id,
    gardenId: gardenId ?? this.gardenId,
    kind: kind ?? this.kind,
    centerX: centerX ?? this.centerX,
    centerY: centerY ?? this.centerY,
    width: width ?? this.width,
    height: height ?? this.height,
    rotationDeg: rotationDeg ?? this.rotationDeg,
    depthCm: depthCm.present ? depthCm.value : this.depthCm,
    label: label.present ? label.value : this.label,
    zIndex: zIndex ?? this.zIndex,
  );
  LayoutElementRow copyWithCompanion(LayoutElementsCompanion data) {
    return LayoutElementRow(
      id: data.id.present ? data.id.value : this.id,
      gardenId: data.gardenId.present ? data.gardenId.value : this.gardenId,
      kind: data.kind.present ? data.kind.value : this.kind,
      centerX: data.centerX.present ? data.centerX.value : this.centerX,
      centerY: data.centerY.present ? data.centerY.value : this.centerY,
      width: data.width.present ? data.width.value : this.width,
      height: data.height.present ? data.height.value : this.height,
      rotationDeg: data.rotationDeg.present
          ? data.rotationDeg.value
          : this.rotationDeg,
      depthCm: data.depthCm.present ? data.depthCm.value : this.depthCm,
      label: data.label.present ? data.label.value : this.label,
      zIndex: data.zIndex.present ? data.zIndex.value : this.zIndex,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LayoutElementRow(')
          ..write('id: $id, ')
          ..write('gardenId: $gardenId, ')
          ..write('kind: $kind, ')
          ..write('centerX: $centerX, ')
          ..write('centerY: $centerY, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('rotationDeg: $rotationDeg, ')
          ..write('depthCm: $depthCm, ')
          ..write('label: $label, ')
          ..write('zIndex: $zIndex')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    gardenId,
    kind,
    centerX,
    centerY,
    width,
    height,
    rotationDeg,
    depthCm,
    label,
    zIndex,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LayoutElementRow &&
          other.id == this.id &&
          other.gardenId == this.gardenId &&
          other.kind == this.kind &&
          other.centerX == this.centerX &&
          other.centerY == this.centerY &&
          other.width == this.width &&
          other.height == this.height &&
          other.rotationDeg == this.rotationDeg &&
          other.depthCm == this.depthCm &&
          other.label == this.label &&
          other.zIndex == this.zIndex);
}

class LayoutElementsCompanion extends UpdateCompanion<LayoutElementRow> {
  final Value<String> id;
  final Value<String> gardenId;
  final Value<ElementKind> kind;
  final Value<double> centerX;
  final Value<double> centerY;
  final Value<double> width;
  final Value<double> height;
  final Value<double> rotationDeg;
  final Value<double?> depthCm;
  final Value<String?> label;
  final Value<int> zIndex;
  final Value<int> rowid;
  const LayoutElementsCompanion({
    this.id = const Value.absent(),
    this.gardenId = const Value.absent(),
    this.kind = const Value.absent(),
    this.centerX = const Value.absent(),
    this.centerY = const Value.absent(),
    this.width = const Value.absent(),
    this.height = const Value.absent(),
    this.rotationDeg = const Value.absent(),
    this.depthCm = const Value.absent(),
    this.label = const Value.absent(),
    this.zIndex = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LayoutElementsCompanion.insert({
    required String id,
    required String gardenId,
    required ElementKind kind,
    required double centerX,
    required double centerY,
    required double width,
    required double height,
    this.rotationDeg = const Value.absent(),
    this.depthCm = const Value.absent(),
    this.label = const Value.absent(),
    required int zIndex,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       gardenId = Value(gardenId),
       kind = Value(kind),
       centerX = Value(centerX),
       centerY = Value(centerY),
       width = Value(width),
       height = Value(height),
       zIndex = Value(zIndex);
  static Insertable<LayoutElementRow> custom({
    Expression<String>? id,
    Expression<String>? gardenId,
    Expression<String>? kind,
    Expression<double>? centerX,
    Expression<double>? centerY,
    Expression<double>? width,
    Expression<double>? height,
    Expression<double>? rotationDeg,
    Expression<double>? depthCm,
    Expression<String>? label,
    Expression<int>? zIndex,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (gardenId != null) 'garden_id': gardenId,
      if (kind != null) 'kind': kind,
      if (centerX != null) 'center_x': centerX,
      if (centerY != null) 'center_y': centerY,
      if (width != null) 'width': width,
      if (height != null) 'height': height,
      if (rotationDeg != null) 'rotation_deg': rotationDeg,
      if (depthCm != null) 'depth_cm': depthCm,
      if (label != null) 'label': label,
      if (zIndex != null) 'z_index': zIndex,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LayoutElementsCompanion copyWith({
    Value<String>? id,
    Value<String>? gardenId,
    Value<ElementKind>? kind,
    Value<double>? centerX,
    Value<double>? centerY,
    Value<double>? width,
    Value<double>? height,
    Value<double>? rotationDeg,
    Value<double?>? depthCm,
    Value<String?>? label,
    Value<int>? zIndex,
    Value<int>? rowid,
  }) {
    return LayoutElementsCompanion(
      id: id ?? this.id,
      gardenId: gardenId ?? this.gardenId,
      kind: kind ?? this.kind,
      centerX: centerX ?? this.centerX,
      centerY: centerY ?? this.centerY,
      width: width ?? this.width,
      height: height ?? this.height,
      rotationDeg: rotationDeg ?? this.rotationDeg,
      depthCm: depthCm ?? this.depthCm,
      label: label ?? this.label,
      zIndex: zIndex ?? this.zIndex,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (gardenId.present) {
      map['garden_id'] = Variable<String>(gardenId.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(
        $LayoutElementsTable.$converterkind.toSql(kind.value),
      );
    }
    if (centerX.present) {
      map['center_x'] = Variable<double>(centerX.value);
    }
    if (centerY.present) {
      map['center_y'] = Variable<double>(centerY.value);
    }
    if (width.present) {
      map['width'] = Variable<double>(width.value);
    }
    if (height.present) {
      map['height'] = Variable<double>(height.value);
    }
    if (rotationDeg.present) {
      map['rotation_deg'] = Variable<double>(rotationDeg.value);
    }
    if (depthCm.present) {
      map['depth_cm'] = Variable<double>(depthCm.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (zIndex.present) {
      map['z_index'] = Variable<int>(zIndex.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LayoutElementsCompanion(')
          ..write('id: $id, ')
          ..write('gardenId: $gardenId, ')
          ..write('kind: $kind, ')
          ..write('centerX: $centerX, ')
          ..write('centerY: $centerY, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('rotationDeg: $rotationDeg, ')
          ..write('depthCm: $depthCm, ')
          ..write('label: $label, ')
          ..write('zIndex: $zIndex, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlantingsTable extends Plantings
    with TableInfo<$PlantingsTable, PlantingRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlantingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gardenIdMeta = const VerificationMeta(
    'gardenId',
  );
  @override
  late final GeneratedColumn<String> gardenId = GeneratedColumn<String>(
    'garden_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES gardens (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _speciesIdMeta = const VerificationMeta(
    'speciesId',
  );
  @override
  late final GeneratedColumn<String> speciesId = GeneratedColumn<String>(
    'species_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _elementIdMeta = const VerificationMeta(
    'elementId',
  );
  @override
  late final GeneratedColumn<String> elementId = GeneratedColumn<String>(
    'element_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _plantedOnMeta = const VerificationMeta(
    'plantedOn',
  );
  @override
  late final GeneratedColumn<String> plantedOn = GeneratedColumn<String>(
    'planted_on',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<PlantingStart, String>
  startedFrom = GeneratedColumn<String>(
    'started_from',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<PlantingStart>($PlantingsTable.$converterstartedFrom);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    gardenId,
    speciesId,
    elementId,
    quantity,
    plantedOn,
    startedFrom,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'plantings';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlantingRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('garden_id')) {
      context.handle(
        _gardenIdMeta,
        gardenId.isAcceptableOrUnknown(data['garden_id']!, _gardenIdMeta),
      );
    } else if (isInserting) {
      context.missing(_gardenIdMeta);
    }
    if (data.containsKey('species_id')) {
      context.handle(
        _speciesIdMeta,
        speciesId.isAcceptableOrUnknown(data['species_id']!, _speciesIdMeta),
      );
    } else if (isInserting) {
      context.missing(_speciesIdMeta);
    }
    if (data.containsKey('element_id')) {
      context.handle(
        _elementIdMeta,
        elementId.isAcceptableOrUnknown(data['element_id']!, _elementIdMeta),
      );
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('planted_on')) {
      context.handle(
        _plantedOnMeta,
        plantedOn.isAcceptableOrUnknown(data['planted_on']!, _plantedOnMeta),
      );
    } else if (isInserting) {
      context.missing(_plantedOnMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlantingRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlantingRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      gardenId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}garden_id'],
      )!,
      speciesId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}species_id'],
      )!,
      elementId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}element_id'],
      ),
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      plantedOn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}planted_on'],
      )!,
      startedFrom: $PlantingsTable.$converterstartedFrom.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}started_from'],
        )!,
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $PlantingsTable createAlias(String alias) {
    return $PlantingsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<PlantingStart, String, String>
  $converterstartedFrom = const EnumNameConverter<PlantingStart>(
    PlantingStart.values,
  );
}

class PlantingRow extends DataClass implements Insertable<PlantingRow> {
  final String id;
  final String gardenId;
  final String speciesId;
  final String? elementId;
  final int quantity;

  /// `yyyy-MM-dd` (a calendar date, not an instant).
  final String plantedOn;
  final PlantingStart startedFrom;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const PlantingRow({
    required this.id,
    required this.gardenId,
    required this.speciesId,
    this.elementId,
    required this.quantity,
    required this.plantedOn,
    required this.startedFrom,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['garden_id'] = Variable<String>(gardenId);
    map['species_id'] = Variable<String>(speciesId);
    if (!nullToAbsent || elementId != null) {
      map['element_id'] = Variable<String>(elementId);
    }
    map['quantity'] = Variable<int>(quantity);
    map['planted_on'] = Variable<String>(plantedOn);
    {
      map['started_from'] = Variable<String>(
        $PlantingsTable.$converterstartedFrom.toSql(startedFrom),
      );
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PlantingsCompanion toCompanion(bool nullToAbsent) {
    return PlantingsCompanion(
      id: Value(id),
      gardenId: Value(gardenId),
      speciesId: Value(speciesId),
      elementId: elementId == null && nullToAbsent
          ? const Value.absent()
          : Value(elementId),
      quantity: Value(quantity),
      plantedOn: Value(plantedOn),
      startedFrom: Value(startedFrom),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory PlantingRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlantingRow(
      id: serializer.fromJson<String>(json['id']),
      gardenId: serializer.fromJson<String>(json['gardenId']),
      speciesId: serializer.fromJson<String>(json['speciesId']),
      elementId: serializer.fromJson<String?>(json['elementId']),
      quantity: serializer.fromJson<int>(json['quantity']),
      plantedOn: serializer.fromJson<String>(json['plantedOn']),
      startedFrom: $PlantingsTable.$converterstartedFrom.fromJson(
        serializer.fromJson<String>(json['startedFrom']),
      ),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'gardenId': serializer.toJson<String>(gardenId),
      'speciesId': serializer.toJson<String>(speciesId),
      'elementId': serializer.toJson<String?>(elementId),
      'quantity': serializer.toJson<int>(quantity),
      'plantedOn': serializer.toJson<String>(plantedOn),
      'startedFrom': serializer.toJson<String>(
        $PlantingsTable.$converterstartedFrom.toJson(startedFrom),
      ),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PlantingRow copyWith({
    String? id,
    String? gardenId,
    String? speciesId,
    Value<String?> elementId = const Value.absent(),
    int? quantity,
    String? plantedOn,
    PlantingStart? startedFrom,
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => PlantingRow(
    id: id ?? this.id,
    gardenId: gardenId ?? this.gardenId,
    speciesId: speciesId ?? this.speciesId,
    elementId: elementId.present ? elementId.value : this.elementId,
    quantity: quantity ?? this.quantity,
    plantedOn: plantedOn ?? this.plantedOn,
    startedFrom: startedFrom ?? this.startedFrom,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  PlantingRow copyWithCompanion(PlantingsCompanion data) {
    return PlantingRow(
      id: data.id.present ? data.id.value : this.id,
      gardenId: data.gardenId.present ? data.gardenId.value : this.gardenId,
      speciesId: data.speciesId.present ? data.speciesId.value : this.speciesId,
      elementId: data.elementId.present ? data.elementId.value : this.elementId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      plantedOn: data.plantedOn.present ? data.plantedOn.value : this.plantedOn,
      startedFrom: data.startedFrom.present
          ? data.startedFrom.value
          : this.startedFrom,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlantingRow(')
          ..write('id: $id, ')
          ..write('gardenId: $gardenId, ')
          ..write('speciesId: $speciesId, ')
          ..write('elementId: $elementId, ')
          ..write('quantity: $quantity, ')
          ..write('plantedOn: $plantedOn, ')
          ..write('startedFrom: $startedFrom, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    gardenId,
    speciesId,
    elementId,
    quantity,
    plantedOn,
    startedFrom,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlantingRow &&
          other.id == this.id &&
          other.gardenId == this.gardenId &&
          other.speciesId == this.speciesId &&
          other.elementId == this.elementId &&
          other.quantity == this.quantity &&
          other.plantedOn == this.plantedOn &&
          other.startedFrom == this.startedFrom &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PlantingsCompanion extends UpdateCompanion<PlantingRow> {
  final Value<String> id;
  final Value<String> gardenId;
  final Value<String> speciesId;
  final Value<String?> elementId;
  final Value<int> quantity;
  final Value<String> plantedOn;
  final Value<PlantingStart> startedFrom;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const PlantingsCompanion({
    this.id = const Value.absent(),
    this.gardenId = const Value.absent(),
    this.speciesId = const Value.absent(),
    this.elementId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.plantedOn = const Value.absent(),
    this.startedFrom = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlantingsCompanion.insert({
    required String id,
    required String gardenId,
    required String speciesId,
    this.elementId = const Value.absent(),
    required int quantity,
    required String plantedOn,
    required PlantingStart startedFrom,
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       gardenId = Value(gardenId),
       speciesId = Value(speciesId),
       quantity = Value(quantity),
       plantedOn = Value(plantedOn),
       startedFrom = Value(startedFrom),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<PlantingRow> custom({
    Expression<String>? id,
    Expression<String>? gardenId,
    Expression<String>? speciesId,
    Expression<String>? elementId,
    Expression<int>? quantity,
    Expression<String>? plantedOn,
    Expression<String>? startedFrom,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (gardenId != null) 'garden_id': gardenId,
      if (speciesId != null) 'species_id': speciesId,
      if (elementId != null) 'element_id': elementId,
      if (quantity != null) 'quantity': quantity,
      if (plantedOn != null) 'planted_on': plantedOn,
      if (startedFrom != null) 'started_from': startedFrom,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlantingsCompanion copyWith({
    Value<String>? id,
    Value<String>? gardenId,
    Value<String>? speciesId,
    Value<String?>? elementId,
    Value<int>? quantity,
    Value<String>? plantedOn,
    Value<PlantingStart>? startedFrom,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return PlantingsCompanion(
      id: id ?? this.id,
      gardenId: gardenId ?? this.gardenId,
      speciesId: speciesId ?? this.speciesId,
      elementId: elementId ?? this.elementId,
      quantity: quantity ?? this.quantity,
      plantedOn: plantedOn ?? this.plantedOn,
      startedFrom: startedFrom ?? this.startedFrom,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (gardenId.present) {
      map['garden_id'] = Variable<String>(gardenId.value);
    }
    if (speciesId.present) {
      map['species_id'] = Variable<String>(speciesId.value);
    }
    if (elementId.present) {
      map['element_id'] = Variable<String>(elementId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (plantedOn.present) {
      map['planted_on'] = Variable<String>(plantedOn.value);
    }
    if (startedFrom.present) {
      map['started_from'] = Variable<String>(
        $PlantingsTable.$converterstartedFrom.toSql(startedFrom.value),
      );
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlantingsCompanion(')
          ..write('id: $id, ')
          ..write('gardenId: $gardenId, ')
          ..write('speciesId: $speciesId, ')
          ..write('elementId: $elementId, ')
          ..write('quantity: $quantity, ')
          ..write('plantedOn: $plantedOn, ')
          ..write('startedFrom: $startedFrom, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ShortlistEntriesTable extends ShortlistEntries
    with TableInfo<$ShortlistEntriesTable, ShortlistRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShortlistEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _gardenIdMeta = const VerificationMeta(
    'gardenId',
  );
  @override
  late final GeneratedColumn<String> gardenId = GeneratedColumn<String>(
    'garden_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES gardens (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _speciesIdMeta = const VerificationMeta(
    'speciesId',
  );
  @override
  late final GeneratedColumn<String> speciesId = GeneratedColumn<String>(
    'species_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [gardenId, speciesId, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shortlist_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<ShortlistRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('garden_id')) {
      context.handle(
        _gardenIdMeta,
        gardenId.isAcceptableOrUnknown(data['garden_id']!, _gardenIdMeta),
      );
    } else if (isInserting) {
      context.missing(_gardenIdMeta);
    }
    if (data.containsKey('species_id')) {
      context.handle(
        _speciesIdMeta,
        speciesId.isAcceptableOrUnknown(data['species_id']!, _speciesIdMeta),
      );
    } else if (isInserting) {
      context.missing(_speciesIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {gardenId, speciesId};
  @override
  ShortlistRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShortlistRow(
      gardenId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}garden_id'],
      )!,
      speciesId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}species_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ShortlistEntriesTable createAlias(String alias) {
    return $ShortlistEntriesTable(attachedDatabase, alias);
  }
}

class ShortlistRow extends DataClass implements Insertable<ShortlistRow> {
  final String gardenId;
  final String speciesId;
  final DateTime createdAt;
  const ShortlistRow({
    required this.gardenId,
    required this.speciesId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['garden_id'] = Variable<String>(gardenId);
    map['species_id'] = Variable<String>(speciesId);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ShortlistEntriesCompanion toCompanion(bool nullToAbsent) {
    return ShortlistEntriesCompanion(
      gardenId: Value(gardenId),
      speciesId: Value(speciesId),
      createdAt: Value(createdAt),
    );
  }

  factory ShortlistRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShortlistRow(
      gardenId: serializer.fromJson<String>(json['gardenId']),
      speciesId: serializer.fromJson<String>(json['speciesId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'gardenId': serializer.toJson<String>(gardenId),
      'speciesId': serializer.toJson<String>(speciesId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ShortlistRow copyWith({
    String? gardenId,
    String? speciesId,
    DateTime? createdAt,
  }) => ShortlistRow(
    gardenId: gardenId ?? this.gardenId,
    speciesId: speciesId ?? this.speciesId,
    createdAt: createdAt ?? this.createdAt,
  );
  ShortlistRow copyWithCompanion(ShortlistEntriesCompanion data) {
    return ShortlistRow(
      gardenId: data.gardenId.present ? data.gardenId.value : this.gardenId,
      speciesId: data.speciesId.present ? data.speciesId.value : this.speciesId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ShortlistRow(')
          ..write('gardenId: $gardenId, ')
          ..write('speciesId: $speciesId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(gardenId, speciesId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShortlistRow &&
          other.gardenId == this.gardenId &&
          other.speciesId == this.speciesId &&
          other.createdAt == this.createdAt);
}

class ShortlistEntriesCompanion extends UpdateCompanion<ShortlistRow> {
  final Value<String> gardenId;
  final Value<String> speciesId;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ShortlistEntriesCompanion({
    this.gardenId = const Value.absent(),
    this.speciesId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ShortlistEntriesCompanion.insert({
    required String gardenId,
    required String speciesId,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : gardenId = Value(gardenId),
       speciesId = Value(speciesId),
       createdAt = Value(createdAt);
  static Insertable<ShortlistRow> custom({
    Expression<String>? gardenId,
    Expression<String>? speciesId,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (gardenId != null) 'garden_id': gardenId,
      if (speciesId != null) 'species_id': speciesId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ShortlistEntriesCompanion copyWith({
    Value<String>? gardenId,
    Value<String>? speciesId,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return ShortlistEntriesCompanion(
      gardenId: gardenId ?? this.gardenId,
      speciesId: speciesId ?? this.speciesId,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (gardenId.present) {
      map['garden_id'] = Variable<String>(gardenId.value);
    }
    if (speciesId.present) {
      map['species_id'] = Variable<String>(speciesId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShortlistEntriesCompanion(')
          ..write('gardenId: $gardenId, ')
          ..write('speciesId: $speciesId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $GardensTable gardens = $GardensTable(this);
  late final $GardenPhotosTable gardenPhotos = $GardenPhotosTable(this);
  late final $LayoutElementsTable layoutElements = $LayoutElementsTable(this);
  late final $PlantingsTable plantings = $PlantingsTable(this);
  late final $ShortlistEntriesTable shortlistEntries = $ShortlistEntriesTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    gardens,
    gardenPhotos,
    layoutElements,
    plantings,
    shortlistEntries,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'gardens',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('garden_photos', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'gardens',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('layout_elements', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'gardens',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('plantings', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'gardens',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('shortlist_entries', kind: UpdateKind.delete)],
    ),
  ]);
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef $$GardensTableCreateCompanionBuilder =
    GardensCompanion Function({
      required String id,
      required String name,
      required SpaceType spaceType,
      Value<String?> cityName,
      Value<GrowingRegion?> region,
      Value<double?> lengthCm,
      Value<double?> widthCm,
      required SunExposure sun,
      required Facing facing,
      required WindExposure wind,
      required WaterAccess water,
      Value<String> goals,
      Value<GardenStyle?> style,
      Value<ExperienceLevel?> experience,
      required WeeklyTime weeklyTime,
      required BudgetBand budget,
      Value<String?> coverPhotoId,
      Value<String?> notes,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$GardensTableUpdateCompanionBuilder =
    GardensCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<SpaceType> spaceType,
      Value<String?> cityName,
      Value<GrowingRegion?> region,
      Value<double?> lengthCm,
      Value<double?> widthCm,
      Value<SunExposure> sun,
      Value<Facing> facing,
      Value<WindExposure> wind,
      Value<WaterAccess> water,
      Value<String> goals,
      Value<GardenStyle?> style,
      Value<ExperienceLevel?> experience,
      Value<WeeklyTime> weeklyTime,
      Value<BudgetBand> budget,
      Value<String?> coverPhotoId,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$GardensTableReferences
    extends BaseReferences<_$AppDatabase, $GardensTable, GardenRow> {
  $$GardensTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$GardenPhotosTable, List<GardenPhotoRow>>
  _gardenPhotosRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.gardenPhotos,
    aliasName: $_aliasNameGenerator(db.gardens.id, db.gardenPhotos.gardenId),
  );

  $$GardenPhotosTableProcessedTableManager get gardenPhotosRefs {
    final manager = $$GardenPhotosTableTableManager(
      $_db,
      $_db.gardenPhotos,
    ).filter((f) => f.gardenId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_gardenPhotosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LayoutElementsTable, List<LayoutElementRow>>
  _layoutElementsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.layoutElements,
    aliasName: $_aliasNameGenerator(db.gardens.id, db.layoutElements.gardenId),
  );

  $$LayoutElementsTableProcessedTableManager get layoutElementsRefs {
    final manager = $$LayoutElementsTableTableManager(
      $_db,
      $_db.layoutElements,
    ).filter((f) => f.gardenId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_layoutElementsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PlantingsTable, List<PlantingRow>>
  _plantingsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.plantings,
    aliasName: $_aliasNameGenerator(db.gardens.id, db.plantings.gardenId),
  );

  $$PlantingsTableProcessedTableManager get plantingsRefs {
    final manager = $$PlantingsTableTableManager(
      $_db,
      $_db.plantings,
    ).filter((f) => f.gardenId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_plantingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ShortlistEntriesTable, List<ShortlistRow>>
  _shortlistEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.shortlistEntries,
    aliasName: $_aliasNameGenerator(
      db.gardens.id,
      db.shortlistEntries.gardenId,
    ),
  );

  $$ShortlistEntriesTableProcessedTableManager get shortlistEntriesRefs {
    final manager = $$ShortlistEntriesTableTableManager(
      $_db,
      $_db.shortlistEntries,
    ).filter((f) => f.gardenId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _shortlistEntriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$GardensTableFilterComposer
    extends Composer<_$AppDatabase, $GardensTable> {
  $$GardensTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SpaceType, SpaceType, String> get spaceType =>
      $composableBuilder(
        column: $table.spaceType,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get cityName => $composableBuilder(
    column: $table.cityName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<GrowingRegion?, GrowingRegion, String>
  get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<double> get lengthCm => $composableBuilder(
    column: $table.lengthCm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get widthCm => $composableBuilder(
    column: $table.widthCm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SunExposure, SunExposure, String> get sun =>
      $composableBuilder(
        column: $table.sun,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<Facing, Facing, String> get facing =>
      $composableBuilder(
        column: $table.facing,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<WindExposure, WindExposure, String> get wind =>
      $composableBuilder(
        column: $table.wind,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<WaterAccess, WaterAccess, String> get water =>
      $composableBuilder(
        column: $table.water,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get goals => $composableBuilder(
    column: $table.goals,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<GardenStyle?, GardenStyle, String> get style =>
      $composableBuilder(
        column: $table.style,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<ExperienceLevel?, ExperienceLevel, String>
  get experience => $composableBuilder(
    column: $table.experience,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<WeeklyTime, WeeklyTime, String>
  get weeklyTime => $composableBuilder(
    column: $table.weeklyTime,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<BudgetBand, BudgetBand, String> get budget =>
      $composableBuilder(
        column: $table.budget,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get coverPhotoId => $composableBuilder(
    column: $table.coverPhotoId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> gardenPhotosRefs(
    Expression<bool> Function($$GardenPhotosTableFilterComposer f) f,
  ) {
    final $$GardenPhotosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.gardenPhotos,
      getReferencedColumn: (t) => t.gardenId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GardenPhotosTableFilterComposer(
            $db: $db,
            $table: $db.gardenPhotos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> layoutElementsRefs(
    Expression<bool> Function($$LayoutElementsTableFilterComposer f) f,
  ) {
    final $$LayoutElementsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.layoutElements,
      getReferencedColumn: (t) => t.gardenId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LayoutElementsTableFilterComposer(
            $db: $db,
            $table: $db.layoutElements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> plantingsRefs(
    Expression<bool> Function($$PlantingsTableFilterComposer f) f,
  ) {
    final $$PlantingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.plantings,
      getReferencedColumn: (t) => t.gardenId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlantingsTableFilterComposer(
            $db: $db,
            $table: $db.plantings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> shortlistEntriesRefs(
    Expression<bool> Function($$ShortlistEntriesTableFilterComposer f) f,
  ) {
    final $$ShortlistEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.shortlistEntries,
      getReferencedColumn: (t) => t.gardenId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShortlistEntriesTableFilterComposer(
            $db: $db,
            $table: $db.shortlistEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GardensTableOrderingComposer
    extends Composer<_$AppDatabase, $GardensTable> {
  $$GardensTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get spaceType => $composableBuilder(
    column: $table.spaceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cityName => $composableBuilder(
    column: $table.cityName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lengthCm => $composableBuilder(
    column: $table.lengthCm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get widthCm => $composableBuilder(
    column: $table.widthCm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sun => $composableBuilder(
    column: $table.sun,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get facing => $composableBuilder(
    column: $table.facing,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get wind => $composableBuilder(
    column: $table.wind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get water => $composableBuilder(
    column: $table.water,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get goals => $composableBuilder(
    column: $table.goals,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get style => $composableBuilder(
    column: $table.style,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get experience => $composableBuilder(
    column: $table.experience,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get weeklyTime => $composableBuilder(
    column: $table.weeklyTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get budget => $composableBuilder(
    column: $table.budget,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get coverPhotoId => $composableBuilder(
    column: $table.coverPhotoId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GardensTableAnnotationComposer
    extends Composer<_$AppDatabase, $GardensTable> {
  $$GardensTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SpaceType, String> get spaceType =>
      $composableBuilder(column: $table.spaceType, builder: (column) => column);

  GeneratedColumn<String> get cityName =>
      $composableBuilder(column: $table.cityName, builder: (column) => column);

  GeneratedColumnWithTypeConverter<GrowingRegion?, String> get region =>
      $composableBuilder(column: $table.region, builder: (column) => column);

  GeneratedColumn<double> get lengthCm =>
      $composableBuilder(column: $table.lengthCm, builder: (column) => column);

  GeneratedColumn<double> get widthCm =>
      $composableBuilder(column: $table.widthCm, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SunExposure, String> get sun =>
      $composableBuilder(column: $table.sun, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Facing, String> get facing =>
      $composableBuilder(column: $table.facing, builder: (column) => column);

  GeneratedColumnWithTypeConverter<WindExposure, String> get wind =>
      $composableBuilder(column: $table.wind, builder: (column) => column);

  GeneratedColumnWithTypeConverter<WaterAccess, String> get water =>
      $composableBuilder(column: $table.water, builder: (column) => column);

  GeneratedColumn<String> get goals =>
      $composableBuilder(column: $table.goals, builder: (column) => column);

  GeneratedColumnWithTypeConverter<GardenStyle?, String> get style =>
      $composableBuilder(column: $table.style, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ExperienceLevel?, String> get experience =>
      $composableBuilder(
        column: $table.experience,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<WeeklyTime, String> get weeklyTime =>
      $composableBuilder(
        column: $table.weeklyTime,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<BudgetBand, String> get budget =>
      $composableBuilder(column: $table.budget, builder: (column) => column);

  GeneratedColumn<String> get coverPhotoId => $composableBuilder(
    column: $table.coverPhotoId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> gardenPhotosRefs<T extends Object>(
    Expression<T> Function($$GardenPhotosTableAnnotationComposer a) f,
  ) {
    final $$GardenPhotosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.gardenPhotos,
      getReferencedColumn: (t) => t.gardenId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GardenPhotosTableAnnotationComposer(
            $db: $db,
            $table: $db.gardenPhotos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> layoutElementsRefs<T extends Object>(
    Expression<T> Function($$LayoutElementsTableAnnotationComposer a) f,
  ) {
    final $$LayoutElementsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.layoutElements,
      getReferencedColumn: (t) => t.gardenId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LayoutElementsTableAnnotationComposer(
            $db: $db,
            $table: $db.layoutElements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> plantingsRefs<T extends Object>(
    Expression<T> Function($$PlantingsTableAnnotationComposer a) f,
  ) {
    final $$PlantingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.plantings,
      getReferencedColumn: (t) => t.gardenId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlantingsTableAnnotationComposer(
            $db: $db,
            $table: $db.plantings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> shortlistEntriesRefs<T extends Object>(
    Expression<T> Function($$ShortlistEntriesTableAnnotationComposer a) f,
  ) {
    final $$ShortlistEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.shortlistEntries,
      getReferencedColumn: (t) => t.gardenId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShortlistEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.shortlistEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GardensTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GardensTable,
          GardenRow,
          $$GardensTableFilterComposer,
          $$GardensTableOrderingComposer,
          $$GardensTableAnnotationComposer,
          $$GardensTableCreateCompanionBuilder,
          $$GardensTableUpdateCompanionBuilder,
          (GardenRow, $$GardensTableReferences),
          GardenRow,
          PrefetchHooks Function({
            bool gardenPhotosRefs,
            bool layoutElementsRefs,
            bool plantingsRefs,
            bool shortlistEntriesRefs,
          })
        > {
  $$GardensTableTableManager(_$AppDatabase db, $GardensTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GardensTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GardensTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GardensTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<SpaceType> spaceType = const Value.absent(),
                Value<String?> cityName = const Value.absent(),
                Value<GrowingRegion?> region = const Value.absent(),
                Value<double?> lengthCm = const Value.absent(),
                Value<double?> widthCm = const Value.absent(),
                Value<SunExposure> sun = const Value.absent(),
                Value<Facing> facing = const Value.absent(),
                Value<WindExposure> wind = const Value.absent(),
                Value<WaterAccess> water = const Value.absent(),
                Value<String> goals = const Value.absent(),
                Value<GardenStyle?> style = const Value.absent(),
                Value<ExperienceLevel?> experience = const Value.absent(),
                Value<WeeklyTime> weeklyTime = const Value.absent(),
                Value<BudgetBand> budget = const Value.absent(),
                Value<String?> coverPhotoId = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GardensCompanion(
                id: id,
                name: name,
                spaceType: spaceType,
                cityName: cityName,
                region: region,
                lengthCm: lengthCm,
                widthCm: widthCm,
                sun: sun,
                facing: facing,
                wind: wind,
                water: water,
                goals: goals,
                style: style,
                experience: experience,
                weeklyTime: weeklyTime,
                budget: budget,
                coverPhotoId: coverPhotoId,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required SpaceType spaceType,
                Value<String?> cityName = const Value.absent(),
                Value<GrowingRegion?> region = const Value.absent(),
                Value<double?> lengthCm = const Value.absent(),
                Value<double?> widthCm = const Value.absent(),
                required SunExposure sun,
                required Facing facing,
                required WindExposure wind,
                required WaterAccess water,
                Value<String> goals = const Value.absent(),
                Value<GardenStyle?> style = const Value.absent(),
                Value<ExperienceLevel?> experience = const Value.absent(),
                required WeeklyTime weeklyTime,
                required BudgetBand budget,
                Value<String?> coverPhotoId = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => GardensCompanion.insert(
                id: id,
                name: name,
                spaceType: spaceType,
                cityName: cityName,
                region: region,
                lengthCm: lengthCm,
                widthCm: widthCm,
                sun: sun,
                facing: facing,
                wind: wind,
                water: water,
                goals: goals,
                style: style,
                experience: experience,
                weeklyTime: weeklyTime,
                budget: budget,
                coverPhotoId: coverPhotoId,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$GardensTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                gardenPhotosRefs = false,
                layoutElementsRefs = false,
                plantingsRefs = false,
                shortlistEntriesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (gardenPhotosRefs) db.gardenPhotos,
                    if (layoutElementsRefs) db.layoutElements,
                    if (plantingsRefs) db.plantings,
                    if (shortlistEntriesRefs) db.shortlistEntries,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (gardenPhotosRefs)
                        await $_getPrefetchedData<
                          GardenRow,
                          $GardensTable,
                          GardenPhotoRow
                        >(
                          currentTable: table,
                          referencedTable: $$GardensTableReferences
                              ._gardenPhotosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GardensTableReferences(
                                db,
                                table,
                                p0,
                              ).gardenPhotosRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.gardenId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (layoutElementsRefs)
                        await $_getPrefetchedData<
                          GardenRow,
                          $GardensTable,
                          LayoutElementRow
                        >(
                          currentTable: table,
                          referencedTable: $$GardensTableReferences
                              ._layoutElementsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GardensTableReferences(
                                db,
                                table,
                                p0,
                              ).layoutElementsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.gardenId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (plantingsRefs)
                        await $_getPrefetchedData<
                          GardenRow,
                          $GardensTable,
                          PlantingRow
                        >(
                          currentTable: table,
                          referencedTable: $$GardensTableReferences
                              ._plantingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GardensTableReferences(
                                db,
                                table,
                                p0,
                              ).plantingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.gardenId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (shortlistEntriesRefs)
                        await $_getPrefetchedData<
                          GardenRow,
                          $GardensTable,
                          ShortlistRow
                        >(
                          currentTable: table,
                          referencedTable: $$GardensTableReferences
                              ._shortlistEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GardensTableReferences(
                                db,
                                table,
                                p0,
                              ).shortlistEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.gardenId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$GardensTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GardensTable,
      GardenRow,
      $$GardensTableFilterComposer,
      $$GardensTableOrderingComposer,
      $$GardensTableAnnotationComposer,
      $$GardensTableCreateCompanionBuilder,
      $$GardensTableUpdateCompanionBuilder,
      (GardenRow, $$GardensTableReferences),
      GardenRow,
      PrefetchHooks Function({
        bool gardenPhotosRefs,
        bool layoutElementsRefs,
        bool plantingsRefs,
        bool shortlistEntriesRefs,
      })
    >;
typedef $$GardenPhotosTableCreateCompanionBuilder =
    GardenPhotosCompanion Function({
      required String id,
      required String gardenId,
      required String relativePath,
      required String thumbnailPath,
      Value<String?> caption,
      required int width,
      required int height,
      required DateTime takenAt,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$GardenPhotosTableUpdateCompanionBuilder =
    GardenPhotosCompanion Function({
      Value<String> id,
      Value<String> gardenId,
      Value<String> relativePath,
      Value<String> thumbnailPath,
      Value<String?> caption,
      Value<int> width,
      Value<int> height,
      Value<DateTime> takenAt,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$GardenPhotosTableReferences
    extends BaseReferences<_$AppDatabase, $GardenPhotosTable, GardenPhotoRow> {
  $$GardenPhotosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $GardensTable _gardenIdTable(_$AppDatabase db) =>
      db.gardens.createAlias(
        $_aliasNameGenerator(db.gardenPhotos.gardenId, db.gardens.id),
      );

  $$GardensTableProcessedTableManager get gardenId {
    final $_column = $_itemColumn<String>('garden_id')!;

    final manager = $$GardensTableTableManager(
      $_db,
      $_db.gardens,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_gardenIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$GardenPhotosTableFilterComposer
    extends Composer<_$AppDatabase, $GardenPhotosTable> {
  $$GardenPhotosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get thumbnailPath => $composableBuilder(
    column: $table.thumbnailPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get caption => $composableBuilder(
    column: $table.caption,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get width => $composableBuilder(
    column: $table.width,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get takenAt => $composableBuilder(
    column: $table.takenAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$GardensTableFilterComposer get gardenId {
    final $$GardensTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gardenId,
      referencedTable: $db.gardens,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GardensTableFilterComposer(
            $db: $db,
            $table: $db.gardens,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GardenPhotosTableOrderingComposer
    extends Composer<_$AppDatabase, $GardenPhotosTable> {
  $$GardenPhotosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get thumbnailPath => $composableBuilder(
    column: $table.thumbnailPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get caption => $composableBuilder(
    column: $table.caption,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get width => $composableBuilder(
    column: $table.width,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get takenAt => $composableBuilder(
    column: $table.takenAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$GardensTableOrderingComposer get gardenId {
    final $$GardensTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gardenId,
      referencedTable: $db.gardens,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GardensTableOrderingComposer(
            $db: $db,
            $table: $db.gardens,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GardenPhotosTableAnnotationComposer
    extends Composer<_$AppDatabase, $GardenPhotosTable> {
  $$GardenPhotosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get thumbnailPath => $composableBuilder(
    column: $table.thumbnailPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get caption =>
      $composableBuilder(column: $table.caption, builder: (column) => column);

  GeneratedColumn<int> get width =>
      $composableBuilder(column: $table.width, builder: (column) => column);

  GeneratedColumn<int> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<DateTime> get takenAt =>
      $composableBuilder(column: $table.takenAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$GardensTableAnnotationComposer get gardenId {
    final $$GardensTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gardenId,
      referencedTable: $db.gardens,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GardensTableAnnotationComposer(
            $db: $db,
            $table: $db.gardens,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GardenPhotosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GardenPhotosTable,
          GardenPhotoRow,
          $$GardenPhotosTableFilterComposer,
          $$GardenPhotosTableOrderingComposer,
          $$GardenPhotosTableAnnotationComposer,
          $$GardenPhotosTableCreateCompanionBuilder,
          $$GardenPhotosTableUpdateCompanionBuilder,
          (GardenPhotoRow, $$GardenPhotosTableReferences),
          GardenPhotoRow,
          PrefetchHooks Function({bool gardenId})
        > {
  $$GardenPhotosTableTableManager(_$AppDatabase db, $GardenPhotosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GardenPhotosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GardenPhotosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GardenPhotosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> gardenId = const Value.absent(),
                Value<String> relativePath = const Value.absent(),
                Value<String> thumbnailPath = const Value.absent(),
                Value<String?> caption = const Value.absent(),
                Value<int> width = const Value.absent(),
                Value<int> height = const Value.absent(),
                Value<DateTime> takenAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GardenPhotosCompanion(
                id: id,
                gardenId: gardenId,
                relativePath: relativePath,
                thumbnailPath: thumbnailPath,
                caption: caption,
                width: width,
                height: height,
                takenAt: takenAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String gardenId,
                required String relativePath,
                required String thumbnailPath,
                Value<String?> caption = const Value.absent(),
                required int width,
                required int height,
                required DateTime takenAt,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => GardenPhotosCompanion.insert(
                id: id,
                gardenId: gardenId,
                relativePath: relativePath,
                thumbnailPath: thumbnailPath,
                caption: caption,
                width: width,
                height: height,
                takenAt: takenAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$GardenPhotosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({gardenId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (gardenId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.gardenId,
                                referencedTable: $$GardenPhotosTableReferences
                                    ._gardenIdTable(db),
                                referencedColumn: $$GardenPhotosTableReferences
                                    ._gardenIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$GardenPhotosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GardenPhotosTable,
      GardenPhotoRow,
      $$GardenPhotosTableFilterComposer,
      $$GardenPhotosTableOrderingComposer,
      $$GardenPhotosTableAnnotationComposer,
      $$GardenPhotosTableCreateCompanionBuilder,
      $$GardenPhotosTableUpdateCompanionBuilder,
      (GardenPhotoRow, $$GardenPhotosTableReferences),
      GardenPhotoRow,
      PrefetchHooks Function({bool gardenId})
    >;
typedef $$LayoutElementsTableCreateCompanionBuilder =
    LayoutElementsCompanion Function({
      required String id,
      required String gardenId,
      required ElementKind kind,
      required double centerX,
      required double centerY,
      required double width,
      required double height,
      Value<double> rotationDeg,
      Value<double?> depthCm,
      Value<String?> label,
      required int zIndex,
      Value<int> rowid,
    });
typedef $$LayoutElementsTableUpdateCompanionBuilder =
    LayoutElementsCompanion Function({
      Value<String> id,
      Value<String> gardenId,
      Value<ElementKind> kind,
      Value<double> centerX,
      Value<double> centerY,
      Value<double> width,
      Value<double> height,
      Value<double> rotationDeg,
      Value<double?> depthCm,
      Value<String?> label,
      Value<int> zIndex,
      Value<int> rowid,
    });

final class $$LayoutElementsTableReferences
    extends
        BaseReferences<_$AppDatabase, $LayoutElementsTable, LayoutElementRow> {
  $$LayoutElementsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $GardensTable _gardenIdTable(_$AppDatabase db) =>
      db.gardens.createAlias(
        $_aliasNameGenerator(db.layoutElements.gardenId, db.gardens.id),
      );

  $$GardensTableProcessedTableManager get gardenId {
    final $_column = $_itemColumn<String>('garden_id')!;

    final manager = $$GardensTableTableManager(
      $_db,
      $_db.gardens,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_gardenIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LayoutElementsTableFilterComposer
    extends Composer<_$AppDatabase, $LayoutElementsTable> {
  $$LayoutElementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ElementKind, ElementKind, String> get kind =>
      $composableBuilder(
        column: $table.kind,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<double> get centerX => $composableBuilder(
    column: $table.centerX,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get centerY => $composableBuilder(
    column: $table.centerY,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get width => $composableBuilder(
    column: $table.width,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rotationDeg => $composableBuilder(
    column: $table.rotationDeg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get depthCm => $composableBuilder(
    column: $table.depthCm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get zIndex => $composableBuilder(
    column: $table.zIndex,
    builder: (column) => ColumnFilters(column),
  );

  $$GardensTableFilterComposer get gardenId {
    final $$GardensTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gardenId,
      referencedTable: $db.gardens,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GardensTableFilterComposer(
            $db: $db,
            $table: $db.gardens,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LayoutElementsTableOrderingComposer
    extends Composer<_$AppDatabase, $LayoutElementsTable> {
  $$LayoutElementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get centerX => $composableBuilder(
    column: $table.centerX,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get centerY => $composableBuilder(
    column: $table.centerY,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get width => $composableBuilder(
    column: $table.width,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rotationDeg => $composableBuilder(
    column: $table.rotationDeg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get depthCm => $composableBuilder(
    column: $table.depthCm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get zIndex => $composableBuilder(
    column: $table.zIndex,
    builder: (column) => ColumnOrderings(column),
  );

  $$GardensTableOrderingComposer get gardenId {
    final $$GardensTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gardenId,
      referencedTable: $db.gardens,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GardensTableOrderingComposer(
            $db: $db,
            $table: $db.gardens,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LayoutElementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LayoutElementsTable> {
  $$LayoutElementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ElementKind, String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<double> get centerX =>
      $composableBuilder(column: $table.centerX, builder: (column) => column);

  GeneratedColumn<double> get centerY =>
      $composableBuilder(column: $table.centerY, builder: (column) => column);

  GeneratedColumn<double> get width =>
      $composableBuilder(column: $table.width, builder: (column) => column);

  GeneratedColumn<double> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<double> get rotationDeg => $composableBuilder(
    column: $table.rotationDeg,
    builder: (column) => column,
  );

  GeneratedColumn<double> get depthCm =>
      $composableBuilder(column: $table.depthCm, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<int> get zIndex =>
      $composableBuilder(column: $table.zIndex, builder: (column) => column);

  $$GardensTableAnnotationComposer get gardenId {
    final $$GardensTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gardenId,
      referencedTable: $db.gardens,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GardensTableAnnotationComposer(
            $db: $db,
            $table: $db.gardens,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LayoutElementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LayoutElementsTable,
          LayoutElementRow,
          $$LayoutElementsTableFilterComposer,
          $$LayoutElementsTableOrderingComposer,
          $$LayoutElementsTableAnnotationComposer,
          $$LayoutElementsTableCreateCompanionBuilder,
          $$LayoutElementsTableUpdateCompanionBuilder,
          (LayoutElementRow, $$LayoutElementsTableReferences),
          LayoutElementRow,
          PrefetchHooks Function({bool gardenId})
        > {
  $$LayoutElementsTableTableManager(
    _$AppDatabase db,
    $LayoutElementsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LayoutElementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LayoutElementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LayoutElementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> gardenId = const Value.absent(),
                Value<ElementKind> kind = const Value.absent(),
                Value<double> centerX = const Value.absent(),
                Value<double> centerY = const Value.absent(),
                Value<double> width = const Value.absent(),
                Value<double> height = const Value.absent(),
                Value<double> rotationDeg = const Value.absent(),
                Value<double?> depthCm = const Value.absent(),
                Value<String?> label = const Value.absent(),
                Value<int> zIndex = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LayoutElementsCompanion(
                id: id,
                gardenId: gardenId,
                kind: kind,
                centerX: centerX,
                centerY: centerY,
                width: width,
                height: height,
                rotationDeg: rotationDeg,
                depthCm: depthCm,
                label: label,
                zIndex: zIndex,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String gardenId,
                required ElementKind kind,
                required double centerX,
                required double centerY,
                required double width,
                required double height,
                Value<double> rotationDeg = const Value.absent(),
                Value<double?> depthCm = const Value.absent(),
                Value<String?> label = const Value.absent(),
                required int zIndex,
                Value<int> rowid = const Value.absent(),
              }) => LayoutElementsCompanion.insert(
                id: id,
                gardenId: gardenId,
                kind: kind,
                centerX: centerX,
                centerY: centerY,
                width: width,
                height: height,
                rotationDeg: rotationDeg,
                depthCm: depthCm,
                label: label,
                zIndex: zIndex,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LayoutElementsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({gardenId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (gardenId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.gardenId,
                                referencedTable: $$LayoutElementsTableReferences
                                    ._gardenIdTable(db),
                                referencedColumn:
                                    $$LayoutElementsTableReferences
                                        ._gardenIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$LayoutElementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LayoutElementsTable,
      LayoutElementRow,
      $$LayoutElementsTableFilterComposer,
      $$LayoutElementsTableOrderingComposer,
      $$LayoutElementsTableAnnotationComposer,
      $$LayoutElementsTableCreateCompanionBuilder,
      $$LayoutElementsTableUpdateCompanionBuilder,
      (LayoutElementRow, $$LayoutElementsTableReferences),
      LayoutElementRow,
      PrefetchHooks Function({bool gardenId})
    >;
typedef $$PlantingsTableCreateCompanionBuilder =
    PlantingsCompanion Function({
      required String id,
      required String gardenId,
      required String speciesId,
      Value<String?> elementId,
      required int quantity,
      required String plantedOn,
      required PlantingStart startedFrom,
      Value<String?> notes,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$PlantingsTableUpdateCompanionBuilder =
    PlantingsCompanion Function({
      Value<String> id,
      Value<String> gardenId,
      Value<String> speciesId,
      Value<String?> elementId,
      Value<int> quantity,
      Value<String> plantedOn,
      Value<PlantingStart> startedFrom,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$PlantingsTableReferences
    extends BaseReferences<_$AppDatabase, $PlantingsTable, PlantingRow> {
  $$PlantingsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $GardensTable _gardenIdTable(_$AppDatabase db) => db.gardens
      .createAlias($_aliasNameGenerator(db.plantings.gardenId, db.gardens.id));

  $$GardensTableProcessedTableManager get gardenId {
    final $_column = $_itemColumn<String>('garden_id')!;

    final manager = $$GardensTableTableManager(
      $_db,
      $_db.gardens,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_gardenIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PlantingsTableFilterComposer
    extends Composer<_$AppDatabase, $PlantingsTable> {
  $$PlantingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get speciesId => $composableBuilder(
    column: $table.speciesId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get elementId => $composableBuilder(
    column: $table.elementId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get plantedOn => $composableBuilder(
    column: $table.plantedOn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<PlantingStart, PlantingStart, String>
  get startedFrom => $composableBuilder(
    column: $table.startedFrom,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$GardensTableFilterComposer get gardenId {
    final $$GardensTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gardenId,
      referencedTable: $db.gardens,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GardensTableFilterComposer(
            $db: $db,
            $table: $db.gardens,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlantingsTableOrderingComposer
    extends Composer<_$AppDatabase, $PlantingsTable> {
  $$PlantingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get speciesId => $composableBuilder(
    column: $table.speciesId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get elementId => $composableBuilder(
    column: $table.elementId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get plantedOn => $composableBuilder(
    column: $table.plantedOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get startedFrom => $composableBuilder(
    column: $table.startedFrom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$GardensTableOrderingComposer get gardenId {
    final $$GardensTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gardenId,
      referencedTable: $db.gardens,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GardensTableOrderingComposer(
            $db: $db,
            $table: $db.gardens,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlantingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlantingsTable> {
  $$PlantingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get speciesId =>
      $composableBuilder(column: $table.speciesId, builder: (column) => column);

  GeneratedColumn<String> get elementId =>
      $composableBuilder(column: $table.elementId, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get plantedOn =>
      $composableBuilder(column: $table.plantedOn, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PlantingStart, String> get startedFrom =>
      $composableBuilder(
        column: $table.startedFrom,
        builder: (column) => column,
      );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$GardensTableAnnotationComposer get gardenId {
    final $$GardensTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gardenId,
      referencedTable: $db.gardens,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GardensTableAnnotationComposer(
            $db: $db,
            $table: $db.gardens,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlantingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlantingsTable,
          PlantingRow,
          $$PlantingsTableFilterComposer,
          $$PlantingsTableOrderingComposer,
          $$PlantingsTableAnnotationComposer,
          $$PlantingsTableCreateCompanionBuilder,
          $$PlantingsTableUpdateCompanionBuilder,
          (PlantingRow, $$PlantingsTableReferences),
          PlantingRow,
          PrefetchHooks Function({bool gardenId})
        > {
  $$PlantingsTableTableManager(_$AppDatabase db, $PlantingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlantingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlantingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlantingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> gardenId = const Value.absent(),
                Value<String> speciesId = const Value.absent(),
                Value<String?> elementId = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<String> plantedOn = const Value.absent(),
                Value<PlantingStart> startedFrom = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlantingsCompanion(
                id: id,
                gardenId: gardenId,
                speciesId: speciesId,
                elementId: elementId,
                quantity: quantity,
                plantedOn: plantedOn,
                startedFrom: startedFrom,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String gardenId,
                required String speciesId,
                Value<String?> elementId = const Value.absent(),
                required int quantity,
                required String plantedOn,
                required PlantingStart startedFrom,
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => PlantingsCompanion.insert(
                id: id,
                gardenId: gardenId,
                speciesId: speciesId,
                elementId: elementId,
                quantity: quantity,
                plantedOn: plantedOn,
                startedFrom: startedFrom,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PlantingsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({gardenId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (gardenId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.gardenId,
                                referencedTable: $$PlantingsTableReferences
                                    ._gardenIdTable(db),
                                referencedColumn: $$PlantingsTableReferences
                                    ._gardenIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PlantingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlantingsTable,
      PlantingRow,
      $$PlantingsTableFilterComposer,
      $$PlantingsTableOrderingComposer,
      $$PlantingsTableAnnotationComposer,
      $$PlantingsTableCreateCompanionBuilder,
      $$PlantingsTableUpdateCompanionBuilder,
      (PlantingRow, $$PlantingsTableReferences),
      PlantingRow,
      PrefetchHooks Function({bool gardenId})
    >;
typedef $$ShortlistEntriesTableCreateCompanionBuilder =
    ShortlistEntriesCompanion Function({
      required String gardenId,
      required String speciesId,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$ShortlistEntriesTableUpdateCompanionBuilder =
    ShortlistEntriesCompanion Function({
      Value<String> gardenId,
      Value<String> speciesId,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$ShortlistEntriesTableReferences
    extends
        BaseReferences<_$AppDatabase, $ShortlistEntriesTable, ShortlistRow> {
  $$ShortlistEntriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $GardensTable _gardenIdTable(_$AppDatabase db) =>
      db.gardens.createAlias(
        $_aliasNameGenerator(db.shortlistEntries.gardenId, db.gardens.id),
      );

  $$GardensTableProcessedTableManager get gardenId {
    final $_column = $_itemColumn<String>('garden_id')!;

    final manager = $$GardensTableTableManager(
      $_db,
      $_db.gardens,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_gardenIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ShortlistEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $ShortlistEntriesTable> {
  $$ShortlistEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get speciesId => $composableBuilder(
    column: $table.speciesId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$GardensTableFilterComposer get gardenId {
    final $$GardensTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gardenId,
      referencedTable: $db.gardens,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GardensTableFilterComposer(
            $db: $db,
            $table: $db.gardens,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ShortlistEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $ShortlistEntriesTable> {
  $$ShortlistEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get speciesId => $composableBuilder(
    column: $table.speciesId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$GardensTableOrderingComposer get gardenId {
    final $$GardensTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gardenId,
      referencedTable: $db.gardens,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GardensTableOrderingComposer(
            $db: $db,
            $table: $db.gardens,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ShortlistEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ShortlistEntriesTable> {
  $$ShortlistEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get speciesId =>
      $composableBuilder(column: $table.speciesId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$GardensTableAnnotationComposer get gardenId {
    final $$GardensTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gardenId,
      referencedTable: $db.gardens,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GardensTableAnnotationComposer(
            $db: $db,
            $table: $db.gardens,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ShortlistEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ShortlistEntriesTable,
          ShortlistRow,
          $$ShortlistEntriesTableFilterComposer,
          $$ShortlistEntriesTableOrderingComposer,
          $$ShortlistEntriesTableAnnotationComposer,
          $$ShortlistEntriesTableCreateCompanionBuilder,
          $$ShortlistEntriesTableUpdateCompanionBuilder,
          (ShortlistRow, $$ShortlistEntriesTableReferences),
          ShortlistRow,
          PrefetchHooks Function({bool gardenId})
        > {
  $$ShortlistEntriesTableTableManager(
    _$AppDatabase db,
    $ShortlistEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ShortlistEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ShortlistEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ShortlistEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> gardenId = const Value.absent(),
                Value<String> speciesId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ShortlistEntriesCompanion(
                gardenId: gardenId,
                speciesId: speciesId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String gardenId,
                required String speciesId,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => ShortlistEntriesCompanion.insert(
                gardenId: gardenId,
                speciesId: speciesId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ShortlistEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({gardenId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (gardenId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.gardenId,
                                referencedTable:
                                    $$ShortlistEntriesTableReferences
                                        ._gardenIdTable(db),
                                referencedColumn:
                                    $$ShortlistEntriesTableReferences
                                        ._gardenIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ShortlistEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ShortlistEntriesTable,
      ShortlistRow,
      $$ShortlistEntriesTableFilterComposer,
      $$ShortlistEntriesTableOrderingComposer,
      $$ShortlistEntriesTableAnnotationComposer,
      $$ShortlistEntriesTableCreateCompanionBuilder,
      $$ShortlistEntriesTableUpdateCompanionBuilder,
      (ShortlistRow, $$ShortlistEntriesTableReferences),
      ShortlistRow,
      PrefetchHooks Function({bool gardenId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$GardensTableTableManager get gardens =>
      $$GardensTableTableManager(_db, _db.gardens);
  $$GardenPhotosTableTableManager get gardenPhotos =>
      $$GardenPhotosTableTableManager(_db, _db.gardenPhotos);
  $$LayoutElementsTableTableManager get layoutElements =>
      $$LayoutElementsTableTableManager(_db, _db.layoutElements);
  $$PlantingsTableTableManager get plantings =>
      $$PlantingsTableTableManager(_db, _db.plantings);
  $$ShortlistEntriesTableTableManager get shortlistEntries =>
      $$ShortlistEntriesTableTableManager(_db, _db.shortlistEntries);
}
