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

class $CareRulesTable extends CareRules
    with TableInfo<$CareRulesTable, CareRuleRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CareRulesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _plantingIdMeta = const VerificationMeta(
    'plantingId',
  );
  @override
  late final GeneratedColumn<String> plantingId = GeneratedColumn<String>(
    'planting_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES plantings (id) ON DELETE CASCADE',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<CareTaskType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<CareTaskType>($CareRulesTable.$convertertype);
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _daysMeta = const VerificationMeta('days');
  @override
  late final GeneratedColumn<int> days = GeneratedColumn<int>(
    'days',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startOnMeta = const VerificationMeta(
    'startOn',
  );
  @override
  late final GeneratedColumn<String> startOn = GeneratedColumn<String>(
    'start_on',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weekdaysMeta = const VerificationMeta(
    'weekdays',
  );
  @override
  late final GeneratedColumn<String> weekdays = GeneratedColumn<String>(
    'weekdays',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _monthMeta = const VerificationMeta('month');
  @override
  late final GeneratedColumn<int> month = GeneratedColumn<int>(
    'month',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dayMeta = const VerificationMeta('day');
  @override
  late final GeneratedColumn<int> day = GeneratedColumn<int>(
    'day',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdOnMeta = const VerificationMeta(
    'createdOn',
  );
  @override
  late final GeneratedColumn<String> createdOn = GeneratedColumn<String>(
    'created_on',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    gardenId,
    plantingId,
    type,
    kind,
    days,
    startOn,
    weekdays,
    month,
    day,
    enabled,
    createdOn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'care_rules';
  @override
  VerificationContext validateIntegrity(
    Insertable<CareRuleRow> instance, {
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
    if (data.containsKey('planting_id')) {
      context.handle(
        _plantingIdMeta,
        plantingId.isAcceptableOrUnknown(data['planting_id']!, _plantingIdMeta),
      );
    } else if (isInserting) {
      context.missing(_plantingIdMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('days')) {
      context.handle(
        _daysMeta,
        days.isAcceptableOrUnknown(data['days']!, _daysMeta),
      );
    }
    if (data.containsKey('start_on')) {
      context.handle(
        _startOnMeta,
        startOn.isAcceptableOrUnknown(data['start_on']!, _startOnMeta),
      );
    } else if (isInserting) {
      context.missing(_startOnMeta);
    }
    if (data.containsKey('weekdays')) {
      context.handle(
        _weekdaysMeta,
        weekdays.isAcceptableOrUnknown(data['weekdays']!, _weekdaysMeta),
      );
    }
    if (data.containsKey('month')) {
      context.handle(
        _monthMeta,
        month.isAcceptableOrUnknown(data['month']!, _monthMeta),
      );
    }
    if (data.containsKey('day')) {
      context.handle(
        _dayMeta,
        day.isAcceptableOrUnknown(data['day']!, _dayMeta),
      );
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    }
    if (data.containsKey('created_on')) {
      context.handle(
        _createdOnMeta,
        createdOn.isAcceptableOrUnknown(data['created_on']!, _createdOnMeta),
      );
    } else if (isInserting) {
      context.missing(_createdOnMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CareRuleRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CareRuleRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      gardenId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}garden_id'],
      )!,
      plantingId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}planting_id'],
      )!,
      type: $CareRulesTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      days: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}days'],
      ),
      startOn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}start_on'],
      )!,
      weekdays: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}weekdays'],
      ),
      month: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}month'],
      ),
      day: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}day'],
      ),
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled'],
      )!,
      createdOn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_on'],
      )!,
    );
  }

  @override
  $CareRulesTable createAlias(String alias) {
    return $CareRulesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<CareTaskType, String, String> $convertertype =
      const EnumNameConverter<CareTaskType>(CareTaskType.values);
}

class CareRuleRow extends DataClass implements Insertable<CareRuleRow> {
  final String id;
  final String gardenId;
  final String plantingId;
  final CareTaskType type;

  /// `fromCompletion`, `fixedInterval`, `weekly`, `yearly` or `once`.
  final String kind;
  final int? days;

  /// Start, anchor or date (`yyyy-MM-dd`), depending on [kind].
  final String startOn;

  /// Comma-separated ISO weekdays for `weekly`.
  final String? weekdays;
  final int? month;
  final int? day;
  final bool enabled;
  final String createdOn;
  const CareRuleRow({
    required this.id,
    required this.gardenId,
    required this.plantingId,
    required this.type,
    required this.kind,
    this.days,
    required this.startOn,
    this.weekdays,
    this.month,
    this.day,
    required this.enabled,
    required this.createdOn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['garden_id'] = Variable<String>(gardenId);
    map['planting_id'] = Variable<String>(plantingId);
    {
      map['type'] = Variable<String>(
        $CareRulesTable.$convertertype.toSql(type),
      );
    }
    map['kind'] = Variable<String>(kind);
    if (!nullToAbsent || days != null) {
      map['days'] = Variable<int>(days);
    }
    map['start_on'] = Variable<String>(startOn);
    if (!nullToAbsent || weekdays != null) {
      map['weekdays'] = Variable<String>(weekdays);
    }
    if (!nullToAbsent || month != null) {
      map['month'] = Variable<int>(month);
    }
    if (!nullToAbsent || day != null) {
      map['day'] = Variable<int>(day);
    }
    map['enabled'] = Variable<bool>(enabled);
    map['created_on'] = Variable<String>(createdOn);
    return map;
  }

  CareRulesCompanion toCompanion(bool nullToAbsent) {
    return CareRulesCompanion(
      id: Value(id),
      gardenId: Value(gardenId),
      plantingId: Value(plantingId),
      type: Value(type),
      kind: Value(kind),
      days: days == null && nullToAbsent ? const Value.absent() : Value(days),
      startOn: Value(startOn),
      weekdays: weekdays == null && nullToAbsent
          ? const Value.absent()
          : Value(weekdays),
      month: month == null && nullToAbsent
          ? const Value.absent()
          : Value(month),
      day: day == null && nullToAbsent ? const Value.absent() : Value(day),
      enabled: Value(enabled),
      createdOn: Value(createdOn),
    );
  }

  factory CareRuleRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CareRuleRow(
      id: serializer.fromJson<String>(json['id']),
      gardenId: serializer.fromJson<String>(json['gardenId']),
      plantingId: serializer.fromJson<String>(json['plantingId']),
      type: $CareRulesTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      kind: serializer.fromJson<String>(json['kind']),
      days: serializer.fromJson<int?>(json['days']),
      startOn: serializer.fromJson<String>(json['startOn']),
      weekdays: serializer.fromJson<String?>(json['weekdays']),
      month: serializer.fromJson<int?>(json['month']),
      day: serializer.fromJson<int?>(json['day']),
      enabled: serializer.fromJson<bool>(json['enabled']),
      createdOn: serializer.fromJson<String>(json['createdOn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'gardenId': serializer.toJson<String>(gardenId),
      'plantingId': serializer.toJson<String>(plantingId),
      'type': serializer.toJson<String>(
        $CareRulesTable.$convertertype.toJson(type),
      ),
      'kind': serializer.toJson<String>(kind),
      'days': serializer.toJson<int?>(days),
      'startOn': serializer.toJson<String>(startOn),
      'weekdays': serializer.toJson<String?>(weekdays),
      'month': serializer.toJson<int?>(month),
      'day': serializer.toJson<int?>(day),
      'enabled': serializer.toJson<bool>(enabled),
      'createdOn': serializer.toJson<String>(createdOn),
    };
  }

  CareRuleRow copyWith({
    String? id,
    String? gardenId,
    String? plantingId,
    CareTaskType? type,
    String? kind,
    Value<int?> days = const Value.absent(),
    String? startOn,
    Value<String?> weekdays = const Value.absent(),
    Value<int?> month = const Value.absent(),
    Value<int?> day = const Value.absent(),
    bool? enabled,
    String? createdOn,
  }) => CareRuleRow(
    id: id ?? this.id,
    gardenId: gardenId ?? this.gardenId,
    plantingId: plantingId ?? this.plantingId,
    type: type ?? this.type,
    kind: kind ?? this.kind,
    days: days.present ? days.value : this.days,
    startOn: startOn ?? this.startOn,
    weekdays: weekdays.present ? weekdays.value : this.weekdays,
    month: month.present ? month.value : this.month,
    day: day.present ? day.value : this.day,
    enabled: enabled ?? this.enabled,
    createdOn: createdOn ?? this.createdOn,
  );
  CareRuleRow copyWithCompanion(CareRulesCompanion data) {
    return CareRuleRow(
      id: data.id.present ? data.id.value : this.id,
      gardenId: data.gardenId.present ? data.gardenId.value : this.gardenId,
      plantingId: data.plantingId.present
          ? data.plantingId.value
          : this.plantingId,
      type: data.type.present ? data.type.value : this.type,
      kind: data.kind.present ? data.kind.value : this.kind,
      days: data.days.present ? data.days.value : this.days,
      startOn: data.startOn.present ? data.startOn.value : this.startOn,
      weekdays: data.weekdays.present ? data.weekdays.value : this.weekdays,
      month: data.month.present ? data.month.value : this.month,
      day: data.day.present ? data.day.value : this.day,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
      createdOn: data.createdOn.present ? data.createdOn.value : this.createdOn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CareRuleRow(')
          ..write('id: $id, ')
          ..write('gardenId: $gardenId, ')
          ..write('plantingId: $plantingId, ')
          ..write('type: $type, ')
          ..write('kind: $kind, ')
          ..write('days: $days, ')
          ..write('startOn: $startOn, ')
          ..write('weekdays: $weekdays, ')
          ..write('month: $month, ')
          ..write('day: $day, ')
          ..write('enabled: $enabled, ')
          ..write('createdOn: $createdOn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    gardenId,
    plantingId,
    type,
    kind,
    days,
    startOn,
    weekdays,
    month,
    day,
    enabled,
    createdOn,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CareRuleRow &&
          other.id == this.id &&
          other.gardenId == this.gardenId &&
          other.plantingId == this.plantingId &&
          other.type == this.type &&
          other.kind == this.kind &&
          other.days == this.days &&
          other.startOn == this.startOn &&
          other.weekdays == this.weekdays &&
          other.month == this.month &&
          other.day == this.day &&
          other.enabled == this.enabled &&
          other.createdOn == this.createdOn);
}

class CareRulesCompanion extends UpdateCompanion<CareRuleRow> {
  final Value<String> id;
  final Value<String> gardenId;
  final Value<String> plantingId;
  final Value<CareTaskType> type;
  final Value<String> kind;
  final Value<int?> days;
  final Value<String> startOn;
  final Value<String?> weekdays;
  final Value<int?> month;
  final Value<int?> day;
  final Value<bool> enabled;
  final Value<String> createdOn;
  final Value<int> rowid;
  const CareRulesCompanion({
    this.id = const Value.absent(),
    this.gardenId = const Value.absent(),
    this.plantingId = const Value.absent(),
    this.type = const Value.absent(),
    this.kind = const Value.absent(),
    this.days = const Value.absent(),
    this.startOn = const Value.absent(),
    this.weekdays = const Value.absent(),
    this.month = const Value.absent(),
    this.day = const Value.absent(),
    this.enabled = const Value.absent(),
    this.createdOn = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CareRulesCompanion.insert({
    required String id,
    required String gardenId,
    required String plantingId,
    required CareTaskType type,
    required String kind,
    this.days = const Value.absent(),
    required String startOn,
    this.weekdays = const Value.absent(),
    this.month = const Value.absent(),
    this.day = const Value.absent(),
    this.enabled = const Value.absent(),
    required String createdOn,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       gardenId = Value(gardenId),
       plantingId = Value(plantingId),
       type = Value(type),
       kind = Value(kind),
       startOn = Value(startOn),
       createdOn = Value(createdOn);
  static Insertable<CareRuleRow> custom({
    Expression<String>? id,
    Expression<String>? gardenId,
    Expression<String>? plantingId,
    Expression<String>? type,
    Expression<String>? kind,
    Expression<int>? days,
    Expression<String>? startOn,
    Expression<String>? weekdays,
    Expression<int>? month,
    Expression<int>? day,
    Expression<bool>? enabled,
    Expression<String>? createdOn,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (gardenId != null) 'garden_id': gardenId,
      if (plantingId != null) 'planting_id': plantingId,
      if (type != null) 'type': type,
      if (kind != null) 'kind': kind,
      if (days != null) 'days': days,
      if (startOn != null) 'start_on': startOn,
      if (weekdays != null) 'weekdays': weekdays,
      if (month != null) 'month': month,
      if (day != null) 'day': day,
      if (enabled != null) 'enabled': enabled,
      if (createdOn != null) 'created_on': createdOn,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CareRulesCompanion copyWith({
    Value<String>? id,
    Value<String>? gardenId,
    Value<String>? plantingId,
    Value<CareTaskType>? type,
    Value<String>? kind,
    Value<int?>? days,
    Value<String>? startOn,
    Value<String?>? weekdays,
    Value<int?>? month,
    Value<int?>? day,
    Value<bool>? enabled,
    Value<String>? createdOn,
    Value<int>? rowid,
  }) {
    return CareRulesCompanion(
      id: id ?? this.id,
      gardenId: gardenId ?? this.gardenId,
      plantingId: plantingId ?? this.plantingId,
      type: type ?? this.type,
      kind: kind ?? this.kind,
      days: days ?? this.days,
      startOn: startOn ?? this.startOn,
      weekdays: weekdays ?? this.weekdays,
      month: month ?? this.month,
      day: day ?? this.day,
      enabled: enabled ?? this.enabled,
      createdOn: createdOn ?? this.createdOn,
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
    if (plantingId.present) {
      map['planting_id'] = Variable<String>(plantingId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $CareRulesTable.$convertertype.toSql(type.value),
      );
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (days.present) {
      map['days'] = Variable<int>(days.value);
    }
    if (startOn.present) {
      map['start_on'] = Variable<String>(startOn.value);
    }
    if (weekdays.present) {
      map['weekdays'] = Variable<String>(weekdays.value);
    }
    if (month.present) {
      map['month'] = Variable<int>(month.value);
    }
    if (day.present) {
      map['day'] = Variable<int>(day.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    if (createdOn.present) {
      map['created_on'] = Variable<String>(createdOn.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CareRulesCompanion(')
          ..write('id: $id, ')
          ..write('gardenId: $gardenId, ')
          ..write('plantingId: $plantingId, ')
          ..write('type: $type, ')
          ..write('kind: $kind, ')
          ..write('days: $days, ')
          ..write('startOn: $startOn, ')
          ..write('weekdays: $weekdays, ')
          ..write('month: $month, ')
          ..write('day: $day, ')
          ..write('enabled: $enabled, ')
          ..write('createdOn: $createdOn, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CareTasksTable extends CareTasks
    with TableInfo<$CareTasksTable, CareTaskRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CareTasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ruleIdMeta = const VerificationMeta('ruleId');
  @override
  late final GeneratedColumn<String> ruleId = GeneratedColumn<String>(
    'rule_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES care_rules (id) ON DELETE CASCADE',
    ),
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
  static const VerificationMeta _plantingIdMeta = const VerificationMeta(
    'plantingId',
  );
  @override
  late final GeneratedColumn<String> plantingId = GeneratedColumn<String>(
    'planting_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES plantings (id) ON DELETE CASCADE',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<CareTaskType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<CareTaskType>($CareTasksTable.$convertertype);
  static const VerificationMeta _dueOnMeta = const VerificationMeta('dueOn');
  @override
  late final GeneratedColumn<String> dueOn = GeneratedColumn<String>(
    'due_on',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<TaskStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<TaskStatus>($CareTasksTable.$converterstatus);
  static const VerificationMeta _completedOnMeta = const VerificationMeta(
    'completedOn',
  );
  @override
  late final GeneratedColumn<String> completedOn = GeneratedColumn<String>(
    'completed_on',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SkipReason?, String> skipReason =
      GeneratedColumn<String>(
        'skip_reason',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<SkipReason?>($CareTasksTable.$converterskipReasonn);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ruleId,
    gardenId,
    plantingId,
    type,
    dueOn,
    status,
    completedOn,
    note,
    skipReason,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'care_tasks';
  @override
  VerificationContext validateIntegrity(
    Insertable<CareTaskRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('rule_id')) {
      context.handle(
        _ruleIdMeta,
        ruleId.isAcceptableOrUnknown(data['rule_id']!, _ruleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ruleIdMeta);
    }
    if (data.containsKey('garden_id')) {
      context.handle(
        _gardenIdMeta,
        gardenId.isAcceptableOrUnknown(data['garden_id']!, _gardenIdMeta),
      );
    } else if (isInserting) {
      context.missing(_gardenIdMeta);
    }
    if (data.containsKey('planting_id')) {
      context.handle(
        _plantingIdMeta,
        plantingId.isAcceptableOrUnknown(data['planting_id']!, _plantingIdMeta),
      );
    } else if (isInserting) {
      context.missing(_plantingIdMeta);
    }
    if (data.containsKey('due_on')) {
      context.handle(
        _dueOnMeta,
        dueOn.isAcceptableOrUnknown(data['due_on']!, _dueOnMeta),
      );
    } else if (isInserting) {
      context.missing(_dueOnMeta);
    }
    if (data.containsKey('completed_on')) {
      context.handle(
        _completedOnMeta,
        completedOn.isAcceptableOrUnknown(
          data['completed_on']!,
          _completedOnMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {ruleId, dueOn},
  ];
  @override
  CareTaskRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CareTaskRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      ruleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_id'],
      )!,
      gardenId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}garden_id'],
      )!,
      plantingId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}planting_id'],
      )!,
      type: $CareTasksTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      dueOn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}due_on'],
      )!,
      status: $CareTasksTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      completedOn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}completed_on'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      skipReason: $CareTasksTable.$converterskipReasonn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}skip_reason'],
        ),
      ),
    );
  }

  @override
  $CareTasksTable createAlias(String alias) {
    return $CareTasksTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<CareTaskType, String, String> $convertertype =
      const EnumNameConverter<CareTaskType>(CareTaskType.values);
  static JsonTypeConverter2<TaskStatus, String, String> $converterstatus =
      const EnumNameConverter<TaskStatus>(TaskStatus.values);
  static JsonTypeConverter2<SkipReason, String, String> $converterskipReason =
      const EnumNameConverter<SkipReason>(SkipReason.values);
  static JsonTypeConverter2<SkipReason?, String?, String?>
  $converterskipReasonn = JsonTypeConverter2.asNullable($converterskipReason);
}

class CareTaskRow extends DataClass implements Insertable<CareTaskRow> {
  final String id;
  final String ruleId;
  final String gardenId;
  final String plantingId;
  final CareTaskType type;
  final String dueOn;
  final TaskStatus status;
  final String? completedOn;
  final String? note;
  final SkipReason? skipReason;
  const CareTaskRow({
    required this.id,
    required this.ruleId,
    required this.gardenId,
    required this.plantingId,
    required this.type,
    required this.dueOn,
    required this.status,
    this.completedOn,
    this.note,
    this.skipReason,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['rule_id'] = Variable<String>(ruleId);
    map['garden_id'] = Variable<String>(gardenId);
    map['planting_id'] = Variable<String>(plantingId);
    {
      map['type'] = Variable<String>(
        $CareTasksTable.$convertertype.toSql(type),
      );
    }
    map['due_on'] = Variable<String>(dueOn);
    {
      map['status'] = Variable<String>(
        $CareTasksTable.$converterstatus.toSql(status),
      );
    }
    if (!nullToAbsent || completedOn != null) {
      map['completed_on'] = Variable<String>(completedOn);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || skipReason != null) {
      map['skip_reason'] = Variable<String>(
        $CareTasksTable.$converterskipReasonn.toSql(skipReason),
      );
    }
    return map;
  }

  CareTasksCompanion toCompanion(bool nullToAbsent) {
    return CareTasksCompanion(
      id: Value(id),
      ruleId: Value(ruleId),
      gardenId: Value(gardenId),
      plantingId: Value(plantingId),
      type: Value(type),
      dueOn: Value(dueOn),
      status: Value(status),
      completedOn: completedOn == null && nullToAbsent
          ? const Value.absent()
          : Value(completedOn),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      skipReason: skipReason == null && nullToAbsent
          ? const Value.absent()
          : Value(skipReason),
    );
  }

  factory CareTaskRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CareTaskRow(
      id: serializer.fromJson<String>(json['id']),
      ruleId: serializer.fromJson<String>(json['ruleId']),
      gardenId: serializer.fromJson<String>(json['gardenId']),
      plantingId: serializer.fromJson<String>(json['plantingId']),
      type: $CareTasksTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      dueOn: serializer.fromJson<String>(json['dueOn']),
      status: $CareTasksTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      completedOn: serializer.fromJson<String?>(json['completedOn']),
      note: serializer.fromJson<String?>(json['note']),
      skipReason: $CareTasksTable.$converterskipReasonn.fromJson(
        serializer.fromJson<String?>(json['skipReason']),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ruleId': serializer.toJson<String>(ruleId),
      'gardenId': serializer.toJson<String>(gardenId),
      'plantingId': serializer.toJson<String>(plantingId),
      'type': serializer.toJson<String>(
        $CareTasksTable.$convertertype.toJson(type),
      ),
      'dueOn': serializer.toJson<String>(dueOn),
      'status': serializer.toJson<String>(
        $CareTasksTable.$converterstatus.toJson(status),
      ),
      'completedOn': serializer.toJson<String?>(completedOn),
      'note': serializer.toJson<String?>(note),
      'skipReason': serializer.toJson<String?>(
        $CareTasksTable.$converterskipReasonn.toJson(skipReason),
      ),
    };
  }

  CareTaskRow copyWith({
    String? id,
    String? ruleId,
    String? gardenId,
    String? plantingId,
    CareTaskType? type,
    String? dueOn,
    TaskStatus? status,
    Value<String?> completedOn = const Value.absent(),
    Value<String?> note = const Value.absent(),
    Value<SkipReason?> skipReason = const Value.absent(),
  }) => CareTaskRow(
    id: id ?? this.id,
    ruleId: ruleId ?? this.ruleId,
    gardenId: gardenId ?? this.gardenId,
    plantingId: plantingId ?? this.plantingId,
    type: type ?? this.type,
    dueOn: dueOn ?? this.dueOn,
    status: status ?? this.status,
    completedOn: completedOn.present ? completedOn.value : this.completedOn,
    note: note.present ? note.value : this.note,
    skipReason: skipReason.present ? skipReason.value : this.skipReason,
  );
  CareTaskRow copyWithCompanion(CareTasksCompanion data) {
    return CareTaskRow(
      id: data.id.present ? data.id.value : this.id,
      ruleId: data.ruleId.present ? data.ruleId.value : this.ruleId,
      gardenId: data.gardenId.present ? data.gardenId.value : this.gardenId,
      plantingId: data.plantingId.present
          ? data.plantingId.value
          : this.plantingId,
      type: data.type.present ? data.type.value : this.type,
      dueOn: data.dueOn.present ? data.dueOn.value : this.dueOn,
      status: data.status.present ? data.status.value : this.status,
      completedOn: data.completedOn.present
          ? data.completedOn.value
          : this.completedOn,
      note: data.note.present ? data.note.value : this.note,
      skipReason: data.skipReason.present
          ? data.skipReason.value
          : this.skipReason,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CareTaskRow(')
          ..write('id: $id, ')
          ..write('ruleId: $ruleId, ')
          ..write('gardenId: $gardenId, ')
          ..write('plantingId: $plantingId, ')
          ..write('type: $type, ')
          ..write('dueOn: $dueOn, ')
          ..write('status: $status, ')
          ..write('completedOn: $completedOn, ')
          ..write('note: $note, ')
          ..write('skipReason: $skipReason')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    ruleId,
    gardenId,
    plantingId,
    type,
    dueOn,
    status,
    completedOn,
    note,
    skipReason,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CareTaskRow &&
          other.id == this.id &&
          other.ruleId == this.ruleId &&
          other.gardenId == this.gardenId &&
          other.plantingId == this.plantingId &&
          other.type == this.type &&
          other.dueOn == this.dueOn &&
          other.status == this.status &&
          other.completedOn == this.completedOn &&
          other.note == this.note &&
          other.skipReason == this.skipReason);
}

class CareTasksCompanion extends UpdateCompanion<CareTaskRow> {
  final Value<String> id;
  final Value<String> ruleId;
  final Value<String> gardenId;
  final Value<String> plantingId;
  final Value<CareTaskType> type;
  final Value<String> dueOn;
  final Value<TaskStatus> status;
  final Value<String?> completedOn;
  final Value<String?> note;
  final Value<SkipReason?> skipReason;
  final Value<int> rowid;
  const CareTasksCompanion({
    this.id = const Value.absent(),
    this.ruleId = const Value.absent(),
    this.gardenId = const Value.absent(),
    this.plantingId = const Value.absent(),
    this.type = const Value.absent(),
    this.dueOn = const Value.absent(),
    this.status = const Value.absent(),
    this.completedOn = const Value.absent(),
    this.note = const Value.absent(),
    this.skipReason = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CareTasksCompanion.insert({
    required String id,
    required String ruleId,
    required String gardenId,
    required String plantingId,
    required CareTaskType type,
    required String dueOn,
    required TaskStatus status,
    this.completedOn = const Value.absent(),
    this.note = const Value.absent(),
    this.skipReason = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       ruleId = Value(ruleId),
       gardenId = Value(gardenId),
       plantingId = Value(plantingId),
       type = Value(type),
       dueOn = Value(dueOn),
       status = Value(status);
  static Insertable<CareTaskRow> custom({
    Expression<String>? id,
    Expression<String>? ruleId,
    Expression<String>? gardenId,
    Expression<String>? plantingId,
    Expression<String>? type,
    Expression<String>? dueOn,
    Expression<String>? status,
    Expression<String>? completedOn,
    Expression<String>? note,
    Expression<String>? skipReason,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ruleId != null) 'rule_id': ruleId,
      if (gardenId != null) 'garden_id': gardenId,
      if (plantingId != null) 'planting_id': plantingId,
      if (type != null) 'type': type,
      if (dueOn != null) 'due_on': dueOn,
      if (status != null) 'status': status,
      if (completedOn != null) 'completed_on': completedOn,
      if (note != null) 'note': note,
      if (skipReason != null) 'skip_reason': skipReason,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CareTasksCompanion copyWith({
    Value<String>? id,
    Value<String>? ruleId,
    Value<String>? gardenId,
    Value<String>? plantingId,
    Value<CareTaskType>? type,
    Value<String>? dueOn,
    Value<TaskStatus>? status,
    Value<String?>? completedOn,
    Value<String?>? note,
    Value<SkipReason?>? skipReason,
    Value<int>? rowid,
  }) {
    return CareTasksCompanion(
      id: id ?? this.id,
      ruleId: ruleId ?? this.ruleId,
      gardenId: gardenId ?? this.gardenId,
      plantingId: plantingId ?? this.plantingId,
      type: type ?? this.type,
      dueOn: dueOn ?? this.dueOn,
      status: status ?? this.status,
      completedOn: completedOn ?? this.completedOn,
      note: note ?? this.note,
      skipReason: skipReason ?? this.skipReason,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ruleId.present) {
      map['rule_id'] = Variable<String>(ruleId.value);
    }
    if (gardenId.present) {
      map['garden_id'] = Variable<String>(gardenId.value);
    }
    if (plantingId.present) {
      map['planting_id'] = Variable<String>(plantingId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $CareTasksTable.$convertertype.toSql(type.value),
      );
    }
    if (dueOn.present) {
      map['due_on'] = Variable<String>(dueOn.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $CareTasksTable.$converterstatus.toSql(status.value),
      );
    }
    if (completedOn.present) {
      map['completed_on'] = Variable<String>(completedOn.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (skipReason.present) {
      map['skip_reason'] = Variable<String>(
        $CareTasksTable.$converterskipReasonn.toSql(skipReason.value),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CareTasksCompanion(')
          ..write('id: $id, ')
          ..write('ruleId: $ruleId, ')
          ..write('gardenId: $gardenId, ')
          ..write('plantingId: $plantingId, ')
          ..write('type: $type, ')
          ..write('dueOn: $dueOn, ')
          ..write('status: $status, ')
          ..write('completedOn: $completedOn, ')
          ..write('note: $note, ')
          ..write('skipReason: $skipReason, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ScheduledNotificationsTable extends ScheduledNotifications
    with TableInfo<$ScheduledNotificationsTable, ScheduledNotificationRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScheduledNotificationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dayMeta = const VerificationMeta('day');
  @override
  late final GeneratedColumn<String> day = GeneratedColumn<String>(
    'day',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fireAtMeta = const VerificationMeta('fireAt');
  @override
  late final GeneratedColumn<DateTime> fireAt = GeneratedColumn<DateTime>(
    'fire_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taskCountMeta = const VerificationMeta(
    'taskCount',
  );
  @override
  late final GeneratedColumn<int> taskCount = GeneratedColumn<int>(
    'task_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, day, fireAt, taskCount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'scheduled_notifications';
  @override
  VerificationContext validateIntegrity(
    Insertable<ScheduledNotificationRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('day')) {
      context.handle(
        _dayMeta,
        day.isAcceptableOrUnknown(data['day']!, _dayMeta),
      );
    } else if (isInserting) {
      context.missing(_dayMeta);
    }
    if (data.containsKey('fire_at')) {
      context.handle(
        _fireAtMeta,
        fireAt.isAcceptableOrUnknown(data['fire_at']!, _fireAtMeta),
      );
    } else if (isInserting) {
      context.missing(_fireAtMeta);
    }
    if (data.containsKey('task_count')) {
      context.handle(
        _taskCountMeta,
        taskCount.isAcceptableOrUnknown(data['task_count']!, _taskCountMeta),
      );
    } else if (isInserting) {
      context.missing(_taskCountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ScheduledNotificationRow map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScheduledNotificationRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      day: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}day'],
      )!,
      fireAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fire_at'],
      )!,
      taskCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}task_count'],
      )!,
    );
  }

  @override
  $ScheduledNotificationsTable createAlias(String alias) {
    return $ScheduledNotificationsTable(attachedDatabase, alias);
  }
}

class ScheduledNotificationRow extends DataClass
    implements Insertable<ScheduledNotificationRow> {
  final int id;
  final String day;
  final DateTime fireAt;
  final int taskCount;
  const ScheduledNotificationRow({
    required this.id,
    required this.day,
    required this.fireAt,
    required this.taskCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['day'] = Variable<String>(day);
    map['fire_at'] = Variable<DateTime>(fireAt);
    map['task_count'] = Variable<int>(taskCount);
    return map;
  }

  ScheduledNotificationsCompanion toCompanion(bool nullToAbsent) {
    return ScheduledNotificationsCompanion(
      id: Value(id),
      day: Value(day),
      fireAt: Value(fireAt),
      taskCount: Value(taskCount),
    );
  }

  factory ScheduledNotificationRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScheduledNotificationRow(
      id: serializer.fromJson<int>(json['id']),
      day: serializer.fromJson<String>(json['day']),
      fireAt: serializer.fromJson<DateTime>(json['fireAt']),
      taskCount: serializer.fromJson<int>(json['taskCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'day': serializer.toJson<String>(day),
      'fireAt': serializer.toJson<DateTime>(fireAt),
      'taskCount': serializer.toJson<int>(taskCount),
    };
  }

  ScheduledNotificationRow copyWith({
    int? id,
    String? day,
    DateTime? fireAt,
    int? taskCount,
  }) => ScheduledNotificationRow(
    id: id ?? this.id,
    day: day ?? this.day,
    fireAt: fireAt ?? this.fireAt,
    taskCount: taskCount ?? this.taskCount,
  );
  ScheduledNotificationRow copyWithCompanion(
    ScheduledNotificationsCompanion data,
  ) {
    return ScheduledNotificationRow(
      id: data.id.present ? data.id.value : this.id,
      day: data.day.present ? data.day.value : this.day,
      fireAt: data.fireAt.present ? data.fireAt.value : this.fireAt,
      taskCount: data.taskCount.present ? data.taskCount.value : this.taskCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScheduledNotificationRow(')
          ..write('id: $id, ')
          ..write('day: $day, ')
          ..write('fireAt: $fireAt, ')
          ..write('taskCount: $taskCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, day, fireAt, taskCount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScheduledNotificationRow &&
          other.id == this.id &&
          other.day == this.day &&
          other.fireAt == this.fireAt &&
          other.taskCount == this.taskCount);
}

class ScheduledNotificationsCompanion
    extends UpdateCompanion<ScheduledNotificationRow> {
  final Value<int> id;
  final Value<String> day;
  final Value<DateTime> fireAt;
  final Value<int> taskCount;
  const ScheduledNotificationsCompanion({
    this.id = const Value.absent(),
    this.day = const Value.absent(),
    this.fireAt = const Value.absent(),
    this.taskCount = const Value.absent(),
  });
  ScheduledNotificationsCompanion.insert({
    this.id = const Value.absent(),
    required String day,
    required DateTime fireAt,
    required int taskCount,
  }) : day = Value(day),
       fireAt = Value(fireAt),
       taskCount = Value(taskCount);
  static Insertable<ScheduledNotificationRow> custom({
    Expression<int>? id,
    Expression<String>? day,
    Expression<DateTime>? fireAt,
    Expression<int>? taskCount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (day != null) 'day': day,
      if (fireAt != null) 'fire_at': fireAt,
      if (taskCount != null) 'task_count': taskCount,
    });
  }

  ScheduledNotificationsCompanion copyWith({
    Value<int>? id,
    Value<String>? day,
    Value<DateTime>? fireAt,
    Value<int>? taskCount,
  }) {
    return ScheduledNotificationsCompanion(
      id: id ?? this.id,
      day: day ?? this.day,
      fireAt: fireAt ?? this.fireAt,
      taskCount: taskCount ?? this.taskCount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (day.present) {
      map['day'] = Variable<String>(day.value);
    }
    if (fireAt.present) {
      map['fire_at'] = Variable<DateTime>(fireAt.value);
    }
    if (taskCount.present) {
      map['task_count'] = Variable<int>(taskCount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScheduledNotificationsCompanion(')
          ..write('id: $id, ')
          ..write('day: $day, ')
          ..write('fireAt: $fireAt, ')
          ..write('taskCount: $taskCount')
          ..write(')'))
        .toString();
  }
}

class $JournalEntriesTable extends JournalEntries
    with TableInfo<$JournalEntriesTable, JournalEntryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JournalEntriesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _plantingIdMeta = const VerificationMeta(
    'plantingId',
  );
  @override
  late final GeneratedColumn<String> plantingId = GeneratedColumn<String>(
    'planting_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES plantings (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Milestone?, String> milestone =
      GeneratedColumn<String>(
        'milestone',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<Milestone?>($JournalEntriesTable.$convertermilestonen);
  static const VerificationMeta _harvestQuantityMeta = const VerificationMeta(
    'harvestQuantity',
  );
  @override
  late final GeneratedColumn<double> harvestQuantity = GeneratedColumn<double>(
    'harvest_quantity',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<HarvestUnit?, String>
  harvestUnit = GeneratedColumn<String>(
    'harvest_unit',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<HarvestUnit?>($JournalEntriesTable.$converterharvestUnitn);
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
    plantingId,
    date,
    note,
    milestone,
    harvestQuantity,
    harvestUnit,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'journal_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<JournalEntryRow> instance, {
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
    if (data.containsKey('planting_id')) {
      context.handle(
        _plantingIdMeta,
        plantingId.isAcceptableOrUnknown(data['planting_id']!, _plantingIdMeta),
      );
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('harvest_quantity')) {
      context.handle(
        _harvestQuantityMeta,
        harvestQuantity.isAcceptableOrUnknown(
          data['harvest_quantity']!,
          _harvestQuantityMeta,
        ),
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  JournalEntryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JournalEntryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      gardenId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}garden_id'],
      )!,
      plantingId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}planting_id'],
      ),
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      milestone: $JournalEntriesTable.$convertermilestonen.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}milestone'],
        ),
      ),
      harvestQuantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}harvest_quantity'],
      ),
      harvestUnit: $JournalEntriesTable.$converterharvestUnitn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}harvest_unit'],
        ),
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $JournalEntriesTable createAlias(String alias) {
    return $JournalEntriesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Milestone, String, String> $convertermilestone =
      const EnumNameConverter<Milestone>(Milestone.values);
  static JsonTypeConverter2<Milestone?, String?, String?> $convertermilestonen =
      JsonTypeConverter2.asNullable($convertermilestone);
  static JsonTypeConverter2<HarvestUnit, String, String> $converterharvestUnit =
      const EnumNameConverter<HarvestUnit>(HarvestUnit.values);
  static JsonTypeConverter2<HarvestUnit?, String?, String?>
  $converterharvestUnitn = JsonTypeConverter2.asNullable($converterharvestUnit);
}

class JournalEntryRow extends DataClass implements Insertable<JournalEntryRow> {
  final String id;
  final String gardenId;
  final String? plantingId;

  /// `yyyy-MM-dd`.
  final String date;
  final String? note;
  final Milestone? milestone;
  final double? harvestQuantity;
  final HarvestUnit? harvestUnit;
  final DateTime createdAt;
  const JournalEntryRow({
    required this.id,
    required this.gardenId,
    this.plantingId,
    required this.date,
    this.note,
    this.milestone,
    this.harvestQuantity,
    this.harvestUnit,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['garden_id'] = Variable<String>(gardenId);
    if (!nullToAbsent || plantingId != null) {
      map['planting_id'] = Variable<String>(plantingId);
    }
    map['date'] = Variable<String>(date);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || milestone != null) {
      map['milestone'] = Variable<String>(
        $JournalEntriesTable.$convertermilestonen.toSql(milestone),
      );
    }
    if (!nullToAbsent || harvestQuantity != null) {
      map['harvest_quantity'] = Variable<double>(harvestQuantity);
    }
    if (!nullToAbsent || harvestUnit != null) {
      map['harvest_unit'] = Variable<String>(
        $JournalEntriesTable.$converterharvestUnitn.toSql(harvestUnit),
      );
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  JournalEntriesCompanion toCompanion(bool nullToAbsent) {
    return JournalEntriesCompanion(
      id: Value(id),
      gardenId: Value(gardenId),
      plantingId: plantingId == null && nullToAbsent
          ? const Value.absent()
          : Value(plantingId),
      date: Value(date),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      milestone: milestone == null && nullToAbsent
          ? const Value.absent()
          : Value(milestone),
      harvestQuantity: harvestQuantity == null && nullToAbsent
          ? const Value.absent()
          : Value(harvestQuantity),
      harvestUnit: harvestUnit == null && nullToAbsent
          ? const Value.absent()
          : Value(harvestUnit),
      createdAt: Value(createdAt),
    );
  }

  factory JournalEntryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JournalEntryRow(
      id: serializer.fromJson<String>(json['id']),
      gardenId: serializer.fromJson<String>(json['gardenId']),
      plantingId: serializer.fromJson<String?>(json['plantingId']),
      date: serializer.fromJson<String>(json['date']),
      note: serializer.fromJson<String?>(json['note']),
      milestone: $JournalEntriesTable.$convertermilestonen.fromJson(
        serializer.fromJson<String?>(json['milestone']),
      ),
      harvestQuantity: serializer.fromJson<double?>(json['harvestQuantity']),
      harvestUnit: $JournalEntriesTable.$converterharvestUnitn.fromJson(
        serializer.fromJson<String?>(json['harvestUnit']),
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'gardenId': serializer.toJson<String>(gardenId),
      'plantingId': serializer.toJson<String?>(plantingId),
      'date': serializer.toJson<String>(date),
      'note': serializer.toJson<String?>(note),
      'milestone': serializer.toJson<String?>(
        $JournalEntriesTable.$convertermilestonen.toJson(milestone),
      ),
      'harvestQuantity': serializer.toJson<double?>(harvestQuantity),
      'harvestUnit': serializer.toJson<String?>(
        $JournalEntriesTable.$converterharvestUnitn.toJson(harvestUnit),
      ),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  JournalEntryRow copyWith({
    String? id,
    String? gardenId,
    Value<String?> plantingId = const Value.absent(),
    String? date,
    Value<String?> note = const Value.absent(),
    Value<Milestone?> milestone = const Value.absent(),
    Value<double?> harvestQuantity = const Value.absent(),
    Value<HarvestUnit?> harvestUnit = const Value.absent(),
    DateTime? createdAt,
  }) => JournalEntryRow(
    id: id ?? this.id,
    gardenId: gardenId ?? this.gardenId,
    plantingId: plantingId.present ? plantingId.value : this.plantingId,
    date: date ?? this.date,
    note: note.present ? note.value : this.note,
    milestone: milestone.present ? milestone.value : this.milestone,
    harvestQuantity: harvestQuantity.present
        ? harvestQuantity.value
        : this.harvestQuantity,
    harvestUnit: harvestUnit.present ? harvestUnit.value : this.harvestUnit,
    createdAt: createdAt ?? this.createdAt,
  );
  JournalEntryRow copyWithCompanion(JournalEntriesCompanion data) {
    return JournalEntryRow(
      id: data.id.present ? data.id.value : this.id,
      gardenId: data.gardenId.present ? data.gardenId.value : this.gardenId,
      plantingId: data.plantingId.present
          ? data.plantingId.value
          : this.plantingId,
      date: data.date.present ? data.date.value : this.date,
      note: data.note.present ? data.note.value : this.note,
      milestone: data.milestone.present ? data.milestone.value : this.milestone,
      harvestQuantity: data.harvestQuantity.present
          ? data.harvestQuantity.value
          : this.harvestQuantity,
      harvestUnit: data.harvestUnit.present
          ? data.harvestUnit.value
          : this.harvestUnit,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JournalEntryRow(')
          ..write('id: $id, ')
          ..write('gardenId: $gardenId, ')
          ..write('plantingId: $plantingId, ')
          ..write('date: $date, ')
          ..write('note: $note, ')
          ..write('milestone: $milestone, ')
          ..write('harvestQuantity: $harvestQuantity, ')
          ..write('harvestUnit: $harvestUnit, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    gardenId,
    plantingId,
    date,
    note,
    milestone,
    harvestQuantity,
    harvestUnit,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JournalEntryRow &&
          other.id == this.id &&
          other.gardenId == this.gardenId &&
          other.plantingId == this.plantingId &&
          other.date == this.date &&
          other.note == this.note &&
          other.milestone == this.milestone &&
          other.harvestQuantity == this.harvestQuantity &&
          other.harvestUnit == this.harvestUnit &&
          other.createdAt == this.createdAt);
}

class JournalEntriesCompanion extends UpdateCompanion<JournalEntryRow> {
  final Value<String> id;
  final Value<String> gardenId;
  final Value<String?> plantingId;
  final Value<String> date;
  final Value<String?> note;
  final Value<Milestone?> milestone;
  final Value<double?> harvestQuantity;
  final Value<HarvestUnit?> harvestUnit;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const JournalEntriesCompanion({
    this.id = const Value.absent(),
    this.gardenId = const Value.absent(),
    this.plantingId = const Value.absent(),
    this.date = const Value.absent(),
    this.note = const Value.absent(),
    this.milestone = const Value.absent(),
    this.harvestQuantity = const Value.absent(),
    this.harvestUnit = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  JournalEntriesCompanion.insert({
    required String id,
    required String gardenId,
    this.plantingId = const Value.absent(),
    required String date,
    this.note = const Value.absent(),
    this.milestone = const Value.absent(),
    this.harvestQuantity = const Value.absent(),
    this.harvestUnit = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       gardenId = Value(gardenId),
       date = Value(date),
       createdAt = Value(createdAt);
  static Insertable<JournalEntryRow> custom({
    Expression<String>? id,
    Expression<String>? gardenId,
    Expression<String>? plantingId,
    Expression<String>? date,
    Expression<String>? note,
    Expression<String>? milestone,
    Expression<double>? harvestQuantity,
    Expression<String>? harvestUnit,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (gardenId != null) 'garden_id': gardenId,
      if (plantingId != null) 'planting_id': plantingId,
      if (date != null) 'date': date,
      if (note != null) 'note': note,
      if (milestone != null) 'milestone': milestone,
      if (harvestQuantity != null) 'harvest_quantity': harvestQuantity,
      if (harvestUnit != null) 'harvest_unit': harvestUnit,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  JournalEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? gardenId,
    Value<String?>? plantingId,
    Value<String>? date,
    Value<String?>? note,
    Value<Milestone?>? milestone,
    Value<double?>? harvestQuantity,
    Value<HarvestUnit?>? harvestUnit,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return JournalEntriesCompanion(
      id: id ?? this.id,
      gardenId: gardenId ?? this.gardenId,
      plantingId: plantingId ?? this.plantingId,
      date: date ?? this.date,
      note: note ?? this.note,
      milestone: milestone ?? this.milestone,
      harvestQuantity: harvestQuantity ?? this.harvestQuantity,
      harvestUnit: harvestUnit ?? this.harvestUnit,
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
    if (plantingId.present) {
      map['planting_id'] = Variable<String>(plantingId.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (milestone.present) {
      map['milestone'] = Variable<String>(
        $JournalEntriesTable.$convertermilestonen.toSql(milestone.value),
      );
    }
    if (harvestQuantity.present) {
      map['harvest_quantity'] = Variable<double>(harvestQuantity.value);
    }
    if (harvestUnit.present) {
      map['harvest_unit'] = Variable<String>(
        $JournalEntriesTable.$converterharvestUnitn.toSql(harvestUnit.value),
      );
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
    return (StringBuffer('JournalEntriesCompanion(')
          ..write('id: $id, ')
          ..write('gardenId: $gardenId, ')
          ..write('plantingId: $plantingId, ')
          ..write('date: $date, ')
          ..write('note: $note, ')
          ..write('milestone: $milestone, ')
          ..write('harvestQuantity: $harvestQuantity, ')
          ..write('harvestUnit: $harvestUnit, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $JournalPhotosTable extends JournalPhotos
    with TableInfo<$JournalPhotosTable, JournalPhotoRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JournalPhotosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entryIdMeta = const VerificationMeta(
    'entryId',
  );
  @override
  late final GeneratedColumn<String> entryId = GeneratedColumn<String>(
    'entry_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES journal_entries (id) ON DELETE CASCADE',
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
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    entryId,
    relativePath,
    thumbnailPath,
    position,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'journal_photos';
  @override
  VerificationContext validateIntegrity(
    Insertable<JournalPhotoRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('entry_id')) {
      context.handle(
        _entryIdMeta,
        entryId.isAcceptableOrUnknown(data['entry_id']!, _entryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entryIdMeta);
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
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  JournalPhotoRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JournalPhotoRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      entryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entry_id'],
      )!,
      relativePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}relative_path'],
      )!,
      thumbnailPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}thumbnail_path'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
    );
  }

  @override
  $JournalPhotosTable createAlias(String alias) {
    return $JournalPhotosTable(attachedDatabase, alias);
  }
}

class JournalPhotoRow extends DataClass implements Insertable<JournalPhotoRow> {
  final String id;
  final String entryId;
  final String relativePath;
  final String thumbnailPath;
  final int position;
  const JournalPhotoRow({
    required this.id,
    required this.entryId,
    required this.relativePath,
    required this.thumbnailPath,
    required this.position,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['entry_id'] = Variable<String>(entryId);
    map['relative_path'] = Variable<String>(relativePath);
    map['thumbnail_path'] = Variable<String>(thumbnailPath);
    map['position'] = Variable<int>(position);
    return map;
  }

  JournalPhotosCompanion toCompanion(bool nullToAbsent) {
    return JournalPhotosCompanion(
      id: Value(id),
      entryId: Value(entryId),
      relativePath: Value(relativePath),
      thumbnailPath: Value(thumbnailPath),
      position: Value(position),
    );
  }

  factory JournalPhotoRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JournalPhotoRow(
      id: serializer.fromJson<String>(json['id']),
      entryId: serializer.fromJson<String>(json['entryId']),
      relativePath: serializer.fromJson<String>(json['relativePath']),
      thumbnailPath: serializer.fromJson<String>(json['thumbnailPath']),
      position: serializer.fromJson<int>(json['position']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'entryId': serializer.toJson<String>(entryId),
      'relativePath': serializer.toJson<String>(relativePath),
      'thumbnailPath': serializer.toJson<String>(thumbnailPath),
      'position': serializer.toJson<int>(position),
    };
  }

  JournalPhotoRow copyWith({
    String? id,
    String? entryId,
    String? relativePath,
    String? thumbnailPath,
    int? position,
  }) => JournalPhotoRow(
    id: id ?? this.id,
    entryId: entryId ?? this.entryId,
    relativePath: relativePath ?? this.relativePath,
    thumbnailPath: thumbnailPath ?? this.thumbnailPath,
    position: position ?? this.position,
  );
  JournalPhotoRow copyWithCompanion(JournalPhotosCompanion data) {
    return JournalPhotoRow(
      id: data.id.present ? data.id.value : this.id,
      entryId: data.entryId.present ? data.entryId.value : this.entryId,
      relativePath: data.relativePath.present
          ? data.relativePath.value
          : this.relativePath,
      thumbnailPath: data.thumbnailPath.present
          ? data.thumbnailPath.value
          : this.thumbnailPath,
      position: data.position.present ? data.position.value : this.position,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JournalPhotoRow(')
          ..write('id: $id, ')
          ..write('entryId: $entryId, ')
          ..write('relativePath: $relativePath, ')
          ..write('thumbnailPath: $thumbnailPath, ')
          ..write('position: $position')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, entryId, relativePath, thumbnailPath, position);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JournalPhotoRow &&
          other.id == this.id &&
          other.entryId == this.entryId &&
          other.relativePath == this.relativePath &&
          other.thumbnailPath == this.thumbnailPath &&
          other.position == this.position);
}

class JournalPhotosCompanion extends UpdateCompanion<JournalPhotoRow> {
  final Value<String> id;
  final Value<String> entryId;
  final Value<String> relativePath;
  final Value<String> thumbnailPath;
  final Value<int> position;
  final Value<int> rowid;
  const JournalPhotosCompanion({
    this.id = const Value.absent(),
    this.entryId = const Value.absent(),
    this.relativePath = const Value.absent(),
    this.thumbnailPath = const Value.absent(),
    this.position = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  JournalPhotosCompanion.insert({
    required String id,
    required String entryId,
    required String relativePath,
    required String thumbnailPath,
    required int position,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       entryId = Value(entryId),
       relativePath = Value(relativePath),
       thumbnailPath = Value(thumbnailPath),
       position = Value(position);
  static Insertable<JournalPhotoRow> custom({
    Expression<String>? id,
    Expression<String>? entryId,
    Expression<String>? relativePath,
    Expression<String>? thumbnailPath,
    Expression<int>? position,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entryId != null) 'entry_id': entryId,
      if (relativePath != null) 'relative_path': relativePath,
      if (thumbnailPath != null) 'thumbnail_path': thumbnailPath,
      if (position != null) 'position': position,
      if (rowid != null) 'rowid': rowid,
    });
  }

  JournalPhotosCompanion copyWith({
    Value<String>? id,
    Value<String>? entryId,
    Value<String>? relativePath,
    Value<String>? thumbnailPath,
    Value<int>? position,
    Value<int>? rowid,
  }) {
    return JournalPhotosCompanion(
      id: id ?? this.id,
      entryId: entryId ?? this.entryId,
      relativePath: relativePath ?? this.relativePath,
      thumbnailPath: thumbnailPath ?? this.thumbnailPath,
      position: position ?? this.position,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (entryId.present) {
      map['entry_id'] = Variable<String>(entryId.value);
    }
    if (relativePath.present) {
      map['relative_path'] = Variable<String>(relativePath.value);
    }
    if (thumbnailPath.present) {
      map['thumbnail_path'] = Variable<String>(thumbnailPath.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JournalPhotosCompanion(')
          ..write('id: $id, ')
          ..write('entryId: $entryId, ')
          ..write('relativePath: $relativePath, ')
          ..write('thumbnailPath: $thumbnailPath, ')
          ..write('position: $position, ')
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
  late final $CareRulesTable careRules = $CareRulesTable(this);
  late final $CareTasksTable careTasks = $CareTasksTable(this);
  late final $ScheduledNotificationsTable scheduledNotifications =
      $ScheduledNotificationsTable(this);
  late final $JournalEntriesTable journalEntries = $JournalEntriesTable(this);
  late final $JournalPhotosTable journalPhotos = $JournalPhotosTable(this);
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
    careRules,
    careTasks,
    scheduledNotifications,
    journalEntries,
    journalPhotos,
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
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'gardens',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('care_rules', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'plantings',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('care_rules', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'care_rules',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('care_tasks', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'gardens',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('care_tasks', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'plantings',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('care_tasks', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'gardens',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('journal_entries', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'plantings',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('journal_entries', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'journal_entries',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('journal_photos', kind: UpdateKind.delete)],
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

  static MultiTypedResultKey<$CareRulesTable, List<CareRuleRow>>
  _careRulesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.careRules,
    aliasName: $_aliasNameGenerator(db.gardens.id, db.careRules.gardenId),
  );

  $$CareRulesTableProcessedTableManager get careRulesRefs {
    final manager = $$CareRulesTableTableManager(
      $_db,
      $_db.careRules,
    ).filter((f) => f.gardenId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_careRulesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CareTasksTable, List<CareTaskRow>>
  _careTasksRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.careTasks,
    aliasName: $_aliasNameGenerator(db.gardens.id, db.careTasks.gardenId),
  );

  $$CareTasksTableProcessedTableManager get careTasksRefs {
    final manager = $$CareTasksTableTableManager(
      $_db,
      $_db.careTasks,
    ).filter((f) => f.gardenId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_careTasksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$JournalEntriesTable, List<JournalEntryRow>>
  _journalEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.journalEntries,
    aliasName: $_aliasNameGenerator(db.gardens.id, db.journalEntries.gardenId),
  );

  $$JournalEntriesTableProcessedTableManager get journalEntriesRefs {
    final manager = $$JournalEntriesTableTableManager(
      $_db,
      $_db.journalEntries,
    ).filter((f) => f.gardenId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_journalEntriesRefsTable($_db));
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

  Expression<bool> careRulesRefs(
    Expression<bool> Function($$CareRulesTableFilterComposer f) f,
  ) {
    final $$CareRulesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.careRules,
      getReferencedColumn: (t) => t.gardenId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareRulesTableFilterComposer(
            $db: $db,
            $table: $db.careRules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> careTasksRefs(
    Expression<bool> Function($$CareTasksTableFilterComposer f) f,
  ) {
    final $$CareTasksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.careTasks,
      getReferencedColumn: (t) => t.gardenId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareTasksTableFilterComposer(
            $db: $db,
            $table: $db.careTasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> journalEntriesRefs(
    Expression<bool> Function($$JournalEntriesTableFilterComposer f) f,
  ) {
    final $$JournalEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.journalEntries,
      getReferencedColumn: (t) => t.gardenId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JournalEntriesTableFilterComposer(
            $db: $db,
            $table: $db.journalEntries,
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

  Expression<T> careRulesRefs<T extends Object>(
    Expression<T> Function($$CareRulesTableAnnotationComposer a) f,
  ) {
    final $$CareRulesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.careRules,
      getReferencedColumn: (t) => t.gardenId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareRulesTableAnnotationComposer(
            $db: $db,
            $table: $db.careRules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> careTasksRefs<T extends Object>(
    Expression<T> Function($$CareTasksTableAnnotationComposer a) f,
  ) {
    final $$CareTasksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.careTasks,
      getReferencedColumn: (t) => t.gardenId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareTasksTableAnnotationComposer(
            $db: $db,
            $table: $db.careTasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> journalEntriesRefs<T extends Object>(
    Expression<T> Function($$JournalEntriesTableAnnotationComposer a) f,
  ) {
    final $$JournalEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.journalEntries,
      getReferencedColumn: (t) => t.gardenId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JournalEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.journalEntries,
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
            bool careRulesRefs,
            bool careTasksRefs,
            bool journalEntriesRefs,
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
                careRulesRefs = false,
                careTasksRefs = false,
                journalEntriesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (gardenPhotosRefs) db.gardenPhotos,
                    if (layoutElementsRefs) db.layoutElements,
                    if (plantingsRefs) db.plantings,
                    if (shortlistEntriesRefs) db.shortlistEntries,
                    if (careRulesRefs) db.careRules,
                    if (careTasksRefs) db.careTasks,
                    if (journalEntriesRefs) db.journalEntries,
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
                      if (careRulesRefs)
                        await $_getPrefetchedData<
                          GardenRow,
                          $GardensTable,
                          CareRuleRow
                        >(
                          currentTable: table,
                          referencedTable: $$GardensTableReferences
                              ._careRulesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GardensTableReferences(
                                db,
                                table,
                                p0,
                              ).careRulesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.gardenId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (careTasksRefs)
                        await $_getPrefetchedData<
                          GardenRow,
                          $GardensTable,
                          CareTaskRow
                        >(
                          currentTable: table,
                          referencedTable: $$GardensTableReferences
                              ._careTasksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GardensTableReferences(
                                db,
                                table,
                                p0,
                              ).careTasksRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.gardenId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (journalEntriesRefs)
                        await $_getPrefetchedData<
                          GardenRow,
                          $GardensTable,
                          JournalEntryRow
                        >(
                          currentTable: table,
                          referencedTable: $$GardensTableReferences
                              ._journalEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GardensTableReferences(
                                db,
                                table,
                                p0,
                              ).journalEntriesRefs,
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
        bool careRulesRefs,
        bool careTasksRefs,
        bool journalEntriesRefs,
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

  static MultiTypedResultKey<$CareRulesTable, List<CareRuleRow>>
  _careRulesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.careRules,
    aliasName: $_aliasNameGenerator(db.plantings.id, db.careRules.plantingId),
  );

  $$CareRulesTableProcessedTableManager get careRulesRefs {
    final manager = $$CareRulesTableTableManager(
      $_db,
      $_db.careRules,
    ).filter((f) => f.plantingId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_careRulesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CareTasksTable, List<CareTaskRow>>
  _careTasksRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.careTasks,
    aliasName: $_aliasNameGenerator(db.plantings.id, db.careTasks.plantingId),
  );

  $$CareTasksTableProcessedTableManager get careTasksRefs {
    final manager = $$CareTasksTableTableManager(
      $_db,
      $_db.careTasks,
    ).filter((f) => f.plantingId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_careTasksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$JournalEntriesTable, List<JournalEntryRow>>
  _journalEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.journalEntries,
    aliasName: $_aliasNameGenerator(
      db.plantings.id,
      db.journalEntries.plantingId,
    ),
  );

  $$JournalEntriesTableProcessedTableManager get journalEntriesRefs {
    final manager = $$JournalEntriesTableTableManager(
      $_db,
      $_db.journalEntries,
    ).filter((f) => f.plantingId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_journalEntriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
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

  Expression<bool> careRulesRefs(
    Expression<bool> Function($$CareRulesTableFilterComposer f) f,
  ) {
    final $$CareRulesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.careRules,
      getReferencedColumn: (t) => t.plantingId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareRulesTableFilterComposer(
            $db: $db,
            $table: $db.careRules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> careTasksRefs(
    Expression<bool> Function($$CareTasksTableFilterComposer f) f,
  ) {
    final $$CareTasksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.careTasks,
      getReferencedColumn: (t) => t.plantingId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareTasksTableFilterComposer(
            $db: $db,
            $table: $db.careTasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> journalEntriesRefs(
    Expression<bool> Function($$JournalEntriesTableFilterComposer f) f,
  ) {
    final $$JournalEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.journalEntries,
      getReferencedColumn: (t) => t.plantingId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JournalEntriesTableFilterComposer(
            $db: $db,
            $table: $db.journalEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
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

  Expression<T> careRulesRefs<T extends Object>(
    Expression<T> Function($$CareRulesTableAnnotationComposer a) f,
  ) {
    final $$CareRulesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.careRules,
      getReferencedColumn: (t) => t.plantingId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareRulesTableAnnotationComposer(
            $db: $db,
            $table: $db.careRules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> careTasksRefs<T extends Object>(
    Expression<T> Function($$CareTasksTableAnnotationComposer a) f,
  ) {
    final $$CareTasksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.careTasks,
      getReferencedColumn: (t) => t.plantingId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareTasksTableAnnotationComposer(
            $db: $db,
            $table: $db.careTasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> journalEntriesRefs<T extends Object>(
    Expression<T> Function($$JournalEntriesTableAnnotationComposer a) f,
  ) {
    final $$JournalEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.journalEntries,
      getReferencedColumn: (t) => t.plantingId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JournalEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.journalEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
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
          PrefetchHooks Function({
            bool gardenId,
            bool careRulesRefs,
            bool careTasksRefs,
            bool journalEntriesRefs,
          })
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
          prefetchHooksCallback:
              ({
                gardenId = false,
                careRulesRefs = false,
                careTasksRefs = false,
                journalEntriesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (careRulesRefs) db.careRules,
                    if (careTasksRefs) db.careTasks,
                    if (journalEntriesRefs) db.journalEntries,
                  ],
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
                    return [
                      if (careRulesRefs)
                        await $_getPrefetchedData<
                          PlantingRow,
                          $PlantingsTable,
                          CareRuleRow
                        >(
                          currentTable: table,
                          referencedTable: $$PlantingsTableReferences
                              ._careRulesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PlantingsTableReferences(
                                db,
                                table,
                                p0,
                              ).careRulesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.plantingId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (careTasksRefs)
                        await $_getPrefetchedData<
                          PlantingRow,
                          $PlantingsTable,
                          CareTaskRow
                        >(
                          currentTable: table,
                          referencedTable: $$PlantingsTableReferences
                              ._careTasksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PlantingsTableReferences(
                                db,
                                table,
                                p0,
                              ).careTasksRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.plantingId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (journalEntriesRefs)
                        await $_getPrefetchedData<
                          PlantingRow,
                          $PlantingsTable,
                          JournalEntryRow
                        >(
                          currentTable: table,
                          referencedTable: $$PlantingsTableReferences
                              ._journalEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PlantingsTableReferences(
                                db,
                                table,
                                p0,
                              ).journalEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.plantingId == item.id,
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
      PrefetchHooks Function({
        bool gardenId,
        bool careRulesRefs,
        bool careTasksRefs,
        bool journalEntriesRefs,
      })
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
typedef $$CareRulesTableCreateCompanionBuilder =
    CareRulesCompanion Function({
      required String id,
      required String gardenId,
      required String plantingId,
      required CareTaskType type,
      required String kind,
      Value<int?> days,
      required String startOn,
      Value<String?> weekdays,
      Value<int?> month,
      Value<int?> day,
      Value<bool> enabled,
      required String createdOn,
      Value<int> rowid,
    });
typedef $$CareRulesTableUpdateCompanionBuilder =
    CareRulesCompanion Function({
      Value<String> id,
      Value<String> gardenId,
      Value<String> plantingId,
      Value<CareTaskType> type,
      Value<String> kind,
      Value<int?> days,
      Value<String> startOn,
      Value<String?> weekdays,
      Value<int?> month,
      Value<int?> day,
      Value<bool> enabled,
      Value<String> createdOn,
      Value<int> rowid,
    });

final class $$CareRulesTableReferences
    extends BaseReferences<_$AppDatabase, $CareRulesTable, CareRuleRow> {
  $$CareRulesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $GardensTable _gardenIdTable(_$AppDatabase db) => db.gardens
      .createAlias($_aliasNameGenerator(db.careRules.gardenId, db.gardens.id));

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

  static $PlantingsTable _plantingIdTable(_$AppDatabase db) =>
      db.plantings.createAlias(
        $_aliasNameGenerator(db.careRules.plantingId, db.plantings.id),
      );

  $$PlantingsTableProcessedTableManager get plantingId {
    final $_column = $_itemColumn<String>('planting_id')!;

    final manager = $$PlantingsTableTableManager(
      $_db,
      $_db.plantings,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_plantingIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$CareTasksTable, List<CareTaskRow>>
  _careTasksRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.careTasks,
    aliasName: $_aliasNameGenerator(db.careRules.id, db.careTasks.ruleId),
  );

  $$CareTasksTableProcessedTableManager get careTasksRefs {
    final manager = $$CareTasksTableTableManager(
      $_db,
      $_db.careTasks,
    ).filter((f) => f.ruleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_careTasksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CareRulesTableFilterComposer
    extends Composer<_$AppDatabase, $CareRulesTable> {
  $$CareRulesTableFilterComposer({
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

  ColumnWithTypeConverterFilters<CareTaskType, CareTaskType, String> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get days => $composableBuilder(
    column: $table.days,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get startOn => $composableBuilder(
    column: $table.startOn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get weekdays => $composableBuilder(
    column: $table.weekdays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get month => $composableBuilder(
    column: $table.month,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdOn => $composableBuilder(
    column: $table.createdOn,
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

  $$PlantingsTableFilterComposer get plantingId {
    final $$PlantingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.plantingId,
      referencedTable: $db.plantings,
      getReferencedColumn: (t) => t.id,
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
    return composer;
  }

  Expression<bool> careTasksRefs(
    Expression<bool> Function($$CareTasksTableFilterComposer f) f,
  ) {
    final $$CareTasksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.careTasks,
      getReferencedColumn: (t) => t.ruleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareTasksTableFilterComposer(
            $db: $db,
            $table: $db.careTasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CareRulesTableOrderingComposer
    extends Composer<_$AppDatabase, $CareRulesTable> {
  $$CareRulesTableOrderingComposer({
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

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get days => $composableBuilder(
    column: $table.days,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get startOn => $composableBuilder(
    column: $table.startOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get weekdays => $composableBuilder(
    column: $table.weekdays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get month => $composableBuilder(
    column: $table.month,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdOn => $composableBuilder(
    column: $table.createdOn,
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

  $$PlantingsTableOrderingComposer get plantingId {
    final $$PlantingsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.plantingId,
      referencedTable: $db.plantings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlantingsTableOrderingComposer(
            $db: $db,
            $table: $db.plantings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CareRulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CareRulesTable> {
  $$CareRulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CareTaskType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<int> get days =>
      $composableBuilder(column: $table.days, builder: (column) => column);

  GeneratedColumn<String> get startOn =>
      $composableBuilder(column: $table.startOn, builder: (column) => column);

  GeneratedColumn<String> get weekdays =>
      $composableBuilder(column: $table.weekdays, builder: (column) => column);

  GeneratedColumn<int> get month =>
      $composableBuilder(column: $table.month, builder: (column) => column);

  GeneratedColumn<int> get day =>
      $composableBuilder(column: $table.day, builder: (column) => column);

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);

  GeneratedColumn<String> get createdOn =>
      $composableBuilder(column: $table.createdOn, builder: (column) => column);

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

  $$PlantingsTableAnnotationComposer get plantingId {
    final $$PlantingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.plantingId,
      referencedTable: $db.plantings,
      getReferencedColumn: (t) => t.id,
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
    return composer;
  }

  Expression<T> careTasksRefs<T extends Object>(
    Expression<T> Function($$CareTasksTableAnnotationComposer a) f,
  ) {
    final $$CareTasksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.careTasks,
      getReferencedColumn: (t) => t.ruleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareTasksTableAnnotationComposer(
            $db: $db,
            $table: $db.careTasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CareRulesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CareRulesTable,
          CareRuleRow,
          $$CareRulesTableFilterComposer,
          $$CareRulesTableOrderingComposer,
          $$CareRulesTableAnnotationComposer,
          $$CareRulesTableCreateCompanionBuilder,
          $$CareRulesTableUpdateCompanionBuilder,
          (CareRuleRow, $$CareRulesTableReferences),
          CareRuleRow,
          PrefetchHooks Function({
            bool gardenId,
            bool plantingId,
            bool careTasksRefs,
          })
        > {
  $$CareRulesTableTableManager(_$AppDatabase db, $CareRulesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CareRulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CareRulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CareRulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> gardenId = const Value.absent(),
                Value<String> plantingId = const Value.absent(),
                Value<CareTaskType> type = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<int?> days = const Value.absent(),
                Value<String> startOn = const Value.absent(),
                Value<String?> weekdays = const Value.absent(),
                Value<int?> month = const Value.absent(),
                Value<int?> day = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<String> createdOn = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CareRulesCompanion(
                id: id,
                gardenId: gardenId,
                plantingId: plantingId,
                type: type,
                kind: kind,
                days: days,
                startOn: startOn,
                weekdays: weekdays,
                month: month,
                day: day,
                enabled: enabled,
                createdOn: createdOn,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String gardenId,
                required String plantingId,
                required CareTaskType type,
                required String kind,
                Value<int?> days = const Value.absent(),
                required String startOn,
                Value<String?> weekdays = const Value.absent(),
                Value<int?> month = const Value.absent(),
                Value<int?> day = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                required String createdOn,
                Value<int> rowid = const Value.absent(),
              }) => CareRulesCompanion.insert(
                id: id,
                gardenId: gardenId,
                plantingId: plantingId,
                type: type,
                kind: kind,
                days: days,
                startOn: startOn,
                weekdays: weekdays,
                month: month,
                day: day,
                enabled: enabled,
                createdOn: createdOn,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CareRulesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({gardenId = false, plantingId = false, careTasksRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [if (careTasksRefs) db.careTasks],
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
                                    referencedTable: $$CareRulesTableReferences
                                        ._gardenIdTable(db),
                                    referencedColumn: $$CareRulesTableReferences
                                        ._gardenIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (plantingId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.plantingId,
                                    referencedTable: $$CareRulesTableReferences
                                        ._plantingIdTable(db),
                                    referencedColumn: $$CareRulesTableReferences
                                        ._plantingIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (careTasksRefs)
                        await $_getPrefetchedData<
                          CareRuleRow,
                          $CareRulesTable,
                          CareTaskRow
                        >(
                          currentTable: table,
                          referencedTable: $$CareRulesTableReferences
                              ._careTasksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CareRulesTableReferences(
                                db,
                                table,
                                p0,
                              ).careTasksRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.ruleId == item.id,
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

typedef $$CareRulesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CareRulesTable,
      CareRuleRow,
      $$CareRulesTableFilterComposer,
      $$CareRulesTableOrderingComposer,
      $$CareRulesTableAnnotationComposer,
      $$CareRulesTableCreateCompanionBuilder,
      $$CareRulesTableUpdateCompanionBuilder,
      (CareRuleRow, $$CareRulesTableReferences),
      CareRuleRow,
      PrefetchHooks Function({
        bool gardenId,
        bool plantingId,
        bool careTasksRefs,
      })
    >;
typedef $$CareTasksTableCreateCompanionBuilder =
    CareTasksCompanion Function({
      required String id,
      required String ruleId,
      required String gardenId,
      required String plantingId,
      required CareTaskType type,
      required String dueOn,
      required TaskStatus status,
      Value<String?> completedOn,
      Value<String?> note,
      Value<SkipReason?> skipReason,
      Value<int> rowid,
    });
typedef $$CareTasksTableUpdateCompanionBuilder =
    CareTasksCompanion Function({
      Value<String> id,
      Value<String> ruleId,
      Value<String> gardenId,
      Value<String> plantingId,
      Value<CareTaskType> type,
      Value<String> dueOn,
      Value<TaskStatus> status,
      Value<String?> completedOn,
      Value<String?> note,
      Value<SkipReason?> skipReason,
      Value<int> rowid,
    });

final class $$CareTasksTableReferences
    extends BaseReferences<_$AppDatabase, $CareTasksTable, CareTaskRow> {
  $$CareTasksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CareRulesTable _ruleIdTable(_$AppDatabase db) => db.careRules
      .createAlias($_aliasNameGenerator(db.careTasks.ruleId, db.careRules.id));

  $$CareRulesTableProcessedTableManager get ruleId {
    final $_column = $_itemColumn<String>('rule_id')!;

    final manager = $$CareRulesTableTableManager(
      $_db,
      $_db.careRules,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ruleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $GardensTable _gardenIdTable(_$AppDatabase db) => db.gardens
      .createAlias($_aliasNameGenerator(db.careTasks.gardenId, db.gardens.id));

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

  static $PlantingsTable _plantingIdTable(_$AppDatabase db) =>
      db.plantings.createAlias(
        $_aliasNameGenerator(db.careTasks.plantingId, db.plantings.id),
      );

  $$PlantingsTableProcessedTableManager get plantingId {
    final $_column = $_itemColumn<String>('planting_id')!;

    final manager = $$PlantingsTableTableManager(
      $_db,
      $_db.plantings,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_plantingIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CareTasksTableFilterComposer
    extends Composer<_$AppDatabase, $CareTasksTable> {
  $$CareTasksTableFilterComposer({
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

  ColumnWithTypeConverterFilters<CareTaskType, CareTaskType, String> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get dueOn => $composableBuilder(
    column: $table.dueOn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TaskStatus, TaskStatus, String> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get completedOn => $composableBuilder(
    column: $table.completedOn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SkipReason?, SkipReason, String>
  get skipReason => $composableBuilder(
    column: $table.skipReason,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  $$CareRulesTableFilterComposer get ruleId {
    final $$CareRulesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ruleId,
      referencedTable: $db.careRules,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareRulesTableFilterComposer(
            $db: $db,
            $table: $db.careRules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

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

  $$PlantingsTableFilterComposer get plantingId {
    final $$PlantingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.plantingId,
      referencedTable: $db.plantings,
      getReferencedColumn: (t) => t.id,
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
    return composer;
  }
}

class $$CareTasksTableOrderingComposer
    extends Composer<_$AppDatabase, $CareTasksTable> {
  $$CareTasksTableOrderingComposer({
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

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dueOn => $composableBuilder(
    column: $table.dueOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get completedOn => $composableBuilder(
    column: $table.completedOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get skipReason => $composableBuilder(
    column: $table.skipReason,
    builder: (column) => ColumnOrderings(column),
  );

  $$CareRulesTableOrderingComposer get ruleId {
    final $$CareRulesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ruleId,
      referencedTable: $db.careRules,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareRulesTableOrderingComposer(
            $db: $db,
            $table: $db.careRules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

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

  $$PlantingsTableOrderingComposer get plantingId {
    final $$PlantingsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.plantingId,
      referencedTable: $db.plantings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlantingsTableOrderingComposer(
            $db: $db,
            $table: $db.plantings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CareTasksTableAnnotationComposer
    extends Composer<_$AppDatabase, $CareTasksTable> {
  $$CareTasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CareTaskType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get dueOn =>
      $composableBuilder(column: $table.dueOn, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TaskStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get completedOn => $composableBuilder(
    column: $table.completedOn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SkipReason?, String> get skipReason =>
      $composableBuilder(
        column: $table.skipReason,
        builder: (column) => column,
      );

  $$CareRulesTableAnnotationComposer get ruleId {
    final $$CareRulesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ruleId,
      referencedTable: $db.careRules,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareRulesTableAnnotationComposer(
            $db: $db,
            $table: $db.careRules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

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

  $$PlantingsTableAnnotationComposer get plantingId {
    final $$PlantingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.plantingId,
      referencedTable: $db.plantings,
      getReferencedColumn: (t) => t.id,
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
    return composer;
  }
}

class $$CareTasksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CareTasksTable,
          CareTaskRow,
          $$CareTasksTableFilterComposer,
          $$CareTasksTableOrderingComposer,
          $$CareTasksTableAnnotationComposer,
          $$CareTasksTableCreateCompanionBuilder,
          $$CareTasksTableUpdateCompanionBuilder,
          (CareTaskRow, $$CareTasksTableReferences),
          CareTaskRow,
          PrefetchHooks Function({bool ruleId, bool gardenId, bool plantingId})
        > {
  $$CareTasksTableTableManager(_$AppDatabase db, $CareTasksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CareTasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CareTasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CareTasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> ruleId = const Value.absent(),
                Value<String> gardenId = const Value.absent(),
                Value<String> plantingId = const Value.absent(),
                Value<CareTaskType> type = const Value.absent(),
                Value<String> dueOn = const Value.absent(),
                Value<TaskStatus> status = const Value.absent(),
                Value<String?> completedOn = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<SkipReason?> skipReason = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CareTasksCompanion(
                id: id,
                ruleId: ruleId,
                gardenId: gardenId,
                plantingId: plantingId,
                type: type,
                dueOn: dueOn,
                status: status,
                completedOn: completedOn,
                note: note,
                skipReason: skipReason,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String ruleId,
                required String gardenId,
                required String plantingId,
                required CareTaskType type,
                required String dueOn,
                required TaskStatus status,
                Value<String?> completedOn = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<SkipReason?> skipReason = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CareTasksCompanion.insert(
                id: id,
                ruleId: ruleId,
                gardenId: gardenId,
                plantingId: plantingId,
                type: type,
                dueOn: dueOn,
                status: status,
                completedOn: completedOn,
                note: note,
                skipReason: skipReason,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CareTasksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({ruleId = false, gardenId = false, plantingId = false}) {
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
                        if (ruleId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.ruleId,
                                    referencedTable: $$CareTasksTableReferences
                                        ._ruleIdTable(db),
                                    referencedColumn: $$CareTasksTableReferences
                                        ._ruleIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (gardenId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.gardenId,
                                    referencedTable: $$CareTasksTableReferences
                                        ._gardenIdTable(db),
                                    referencedColumn: $$CareTasksTableReferences
                                        ._gardenIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (plantingId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.plantingId,
                                    referencedTable: $$CareTasksTableReferences
                                        ._plantingIdTable(db),
                                    referencedColumn: $$CareTasksTableReferences
                                        ._plantingIdTable(db)
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

typedef $$CareTasksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CareTasksTable,
      CareTaskRow,
      $$CareTasksTableFilterComposer,
      $$CareTasksTableOrderingComposer,
      $$CareTasksTableAnnotationComposer,
      $$CareTasksTableCreateCompanionBuilder,
      $$CareTasksTableUpdateCompanionBuilder,
      (CareTaskRow, $$CareTasksTableReferences),
      CareTaskRow,
      PrefetchHooks Function({bool ruleId, bool gardenId, bool plantingId})
    >;
typedef $$ScheduledNotificationsTableCreateCompanionBuilder =
    ScheduledNotificationsCompanion Function({
      Value<int> id,
      required String day,
      required DateTime fireAt,
      required int taskCount,
    });
typedef $$ScheduledNotificationsTableUpdateCompanionBuilder =
    ScheduledNotificationsCompanion Function({
      Value<int> id,
      Value<String> day,
      Value<DateTime> fireAt,
      Value<int> taskCount,
    });

class $$ScheduledNotificationsTableFilterComposer
    extends Composer<_$AppDatabase, $ScheduledNotificationsTable> {
  $$ScheduledNotificationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fireAt => $composableBuilder(
    column: $table.fireAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get taskCount => $composableBuilder(
    column: $table.taskCount,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ScheduledNotificationsTableOrderingComposer
    extends Composer<_$AppDatabase, $ScheduledNotificationsTable> {
  $$ScheduledNotificationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fireAt => $composableBuilder(
    column: $table.fireAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get taskCount => $composableBuilder(
    column: $table.taskCount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ScheduledNotificationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ScheduledNotificationsTable> {
  $$ScheduledNotificationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get day =>
      $composableBuilder(column: $table.day, builder: (column) => column);

  GeneratedColumn<DateTime> get fireAt =>
      $composableBuilder(column: $table.fireAt, builder: (column) => column);

  GeneratedColumn<int> get taskCount =>
      $composableBuilder(column: $table.taskCount, builder: (column) => column);
}

class $$ScheduledNotificationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ScheduledNotificationsTable,
          ScheduledNotificationRow,
          $$ScheduledNotificationsTableFilterComposer,
          $$ScheduledNotificationsTableOrderingComposer,
          $$ScheduledNotificationsTableAnnotationComposer,
          $$ScheduledNotificationsTableCreateCompanionBuilder,
          $$ScheduledNotificationsTableUpdateCompanionBuilder,
          (
            ScheduledNotificationRow,
            BaseReferences<
              _$AppDatabase,
              $ScheduledNotificationsTable,
              ScheduledNotificationRow
            >,
          ),
          ScheduledNotificationRow,
          PrefetchHooks Function()
        > {
  $$ScheduledNotificationsTableTableManager(
    _$AppDatabase db,
    $ScheduledNotificationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScheduledNotificationsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$ScheduledNotificationsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ScheduledNotificationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> day = const Value.absent(),
                Value<DateTime> fireAt = const Value.absent(),
                Value<int> taskCount = const Value.absent(),
              }) => ScheduledNotificationsCompanion(
                id: id,
                day: day,
                fireAt: fireAt,
                taskCount: taskCount,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String day,
                required DateTime fireAt,
                required int taskCount,
              }) => ScheduledNotificationsCompanion.insert(
                id: id,
                day: day,
                fireAt: fireAt,
                taskCount: taskCount,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ScheduledNotificationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ScheduledNotificationsTable,
      ScheduledNotificationRow,
      $$ScheduledNotificationsTableFilterComposer,
      $$ScheduledNotificationsTableOrderingComposer,
      $$ScheduledNotificationsTableAnnotationComposer,
      $$ScheduledNotificationsTableCreateCompanionBuilder,
      $$ScheduledNotificationsTableUpdateCompanionBuilder,
      (
        ScheduledNotificationRow,
        BaseReferences<
          _$AppDatabase,
          $ScheduledNotificationsTable,
          ScheduledNotificationRow
        >,
      ),
      ScheduledNotificationRow,
      PrefetchHooks Function()
    >;
typedef $$JournalEntriesTableCreateCompanionBuilder =
    JournalEntriesCompanion Function({
      required String id,
      required String gardenId,
      Value<String?> plantingId,
      required String date,
      Value<String?> note,
      Value<Milestone?> milestone,
      Value<double?> harvestQuantity,
      Value<HarvestUnit?> harvestUnit,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$JournalEntriesTableUpdateCompanionBuilder =
    JournalEntriesCompanion Function({
      Value<String> id,
      Value<String> gardenId,
      Value<String?> plantingId,
      Value<String> date,
      Value<String?> note,
      Value<Milestone?> milestone,
      Value<double?> harvestQuantity,
      Value<HarvestUnit?> harvestUnit,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$JournalEntriesTableReferences
    extends
        BaseReferences<_$AppDatabase, $JournalEntriesTable, JournalEntryRow> {
  $$JournalEntriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $GardensTable _gardenIdTable(_$AppDatabase db) =>
      db.gardens.createAlias(
        $_aliasNameGenerator(db.journalEntries.gardenId, db.gardens.id),
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

  static $PlantingsTable _plantingIdTable(_$AppDatabase db) =>
      db.plantings.createAlias(
        $_aliasNameGenerator(db.journalEntries.plantingId, db.plantings.id),
      );

  $$PlantingsTableProcessedTableManager? get plantingId {
    final $_column = $_itemColumn<String>('planting_id');
    if ($_column == null) return null;
    final manager = $$PlantingsTableTableManager(
      $_db,
      $_db.plantings,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_plantingIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$JournalPhotosTable, List<JournalPhotoRow>>
  _journalPhotosRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.journalPhotos,
    aliasName: $_aliasNameGenerator(
      db.journalEntries.id,
      db.journalPhotos.entryId,
    ),
  );

  $$JournalPhotosTableProcessedTableManager get journalPhotosRefs {
    final manager = $$JournalPhotosTableTableManager(
      $_db,
      $_db.journalPhotos,
    ).filter((f) => f.entryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_journalPhotosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$JournalEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $JournalEntriesTable> {
  $$JournalEntriesTableFilterComposer({
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

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Milestone?, Milestone, String> get milestone =>
      $composableBuilder(
        column: $table.milestone,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<double> get harvestQuantity => $composableBuilder(
    column: $table.harvestQuantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<HarvestUnit?, HarvestUnit, String>
  get harvestUnit => $composableBuilder(
    column: $table.harvestUnit,
    builder: (column) => ColumnWithTypeConverterFilters(column),
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

  $$PlantingsTableFilterComposer get plantingId {
    final $$PlantingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.plantingId,
      referencedTable: $db.plantings,
      getReferencedColumn: (t) => t.id,
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
    return composer;
  }

  Expression<bool> journalPhotosRefs(
    Expression<bool> Function($$JournalPhotosTableFilterComposer f) f,
  ) {
    final $$JournalPhotosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.journalPhotos,
      getReferencedColumn: (t) => t.entryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JournalPhotosTableFilterComposer(
            $db: $db,
            $table: $db.journalPhotos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$JournalEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $JournalEntriesTable> {
  $$JournalEntriesTableOrderingComposer({
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

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get milestone => $composableBuilder(
    column: $table.milestone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get harvestQuantity => $composableBuilder(
    column: $table.harvestQuantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get harvestUnit => $composableBuilder(
    column: $table.harvestUnit,
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

  $$PlantingsTableOrderingComposer get plantingId {
    final $$PlantingsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.plantingId,
      referencedTable: $db.plantings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlantingsTableOrderingComposer(
            $db: $db,
            $table: $db.plantings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$JournalEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $JournalEntriesTable> {
  $$JournalEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Milestone?, String> get milestone =>
      $composableBuilder(column: $table.milestone, builder: (column) => column);

  GeneratedColumn<double> get harvestQuantity => $composableBuilder(
    column: $table.harvestQuantity,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<HarvestUnit?, String> get harvestUnit =>
      $composableBuilder(
        column: $table.harvestUnit,
        builder: (column) => column,
      );

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

  $$PlantingsTableAnnotationComposer get plantingId {
    final $$PlantingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.plantingId,
      referencedTable: $db.plantings,
      getReferencedColumn: (t) => t.id,
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
    return composer;
  }

  Expression<T> journalPhotosRefs<T extends Object>(
    Expression<T> Function($$JournalPhotosTableAnnotationComposer a) f,
  ) {
    final $$JournalPhotosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.journalPhotos,
      getReferencedColumn: (t) => t.entryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JournalPhotosTableAnnotationComposer(
            $db: $db,
            $table: $db.journalPhotos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$JournalEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $JournalEntriesTable,
          JournalEntryRow,
          $$JournalEntriesTableFilterComposer,
          $$JournalEntriesTableOrderingComposer,
          $$JournalEntriesTableAnnotationComposer,
          $$JournalEntriesTableCreateCompanionBuilder,
          $$JournalEntriesTableUpdateCompanionBuilder,
          (JournalEntryRow, $$JournalEntriesTableReferences),
          JournalEntryRow,
          PrefetchHooks Function({
            bool gardenId,
            bool plantingId,
            bool journalPhotosRefs,
          })
        > {
  $$JournalEntriesTableTableManager(
    _$AppDatabase db,
    $JournalEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JournalEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JournalEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JournalEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> gardenId = const Value.absent(),
                Value<String?> plantingId = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<Milestone?> milestone = const Value.absent(),
                Value<double?> harvestQuantity = const Value.absent(),
                Value<HarvestUnit?> harvestUnit = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => JournalEntriesCompanion(
                id: id,
                gardenId: gardenId,
                plantingId: plantingId,
                date: date,
                note: note,
                milestone: milestone,
                harvestQuantity: harvestQuantity,
                harvestUnit: harvestUnit,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String gardenId,
                Value<String?> plantingId = const Value.absent(),
                required String date,
                Value<String?> note = const Value.absent(),
                Value<Milestone?> milestone = const Value.absent(),
                Value<double?> harvestQuantity = const Value.absent(),
                Value<HarvestUnit?> harvestUnit = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => JournalEntriesCompanion.insert(
                id: id,
                gardenId: gardenId,
                plantingId: plantingId,
                date: date,
                note: note,
                milestone: milestone,
                harvestQuantity: harvestQuantity,
                harvestUnit: harvestUnit,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$JournalEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                gardenId = false,
                plantingId = false,
                journalPhotosRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (journalPhotosRefs) db.journalPhotos,
                  ],
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
                                        $$JournalEntriesTableReferences
                                            ._gardenIdTable(db),
                                    referencedColumn:
                                        $$JournalEntriesTableReferences
                                            ._gardenIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (plantingId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.plantingId,
                                    referencedTable:
                                        $$JournalEntriesTableReferences
                                            ._plantingIdTable(db),
                                    referencedColumn:
                                        $$JournalEntriesTableReferences
                                            ._plantingIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (journalPhotosRefs)
                        await $_getPrefetchedData<
                          JournalEntryRow,
                          $JournalEntriesTable,
                          JournalPhotoRow
                        >(
                          currentTable: table,
                          referencedTable: $$JournalEntriesTableReferences
                              ._journalPhotosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$JournalEntriesTableReferences(
                                db,
                                table,
                                p0,
                              ).journalPhotosRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.entryId == item.id,
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

typedef $$JournalEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $JournalEntriesTable,
      JournalEntryRow,
      $$JournalEntriesTableFilterComposer,
      $$JournalEntriesTableOrderingComposer,
      $$JournalEntriesTableAnnotationComposer,
      $$JournalEntriesTableCreateCompanionBuilder,
      $$JournalEntriesTableUpdateCompanionBuilder,
      (JournalEntryRow, $$JournalEntriesTableReferences),
      JournalEntryRow,
      PrefetchHooks Function({
        bool gardenId,
        bool plantingId,
        bool journalPhotosRefs,
      })
    >;
typedef $$JournalPhotosTableCreateCompanionBuilder =
    JournalPhotosCompanion Function({
      required String id,
      required String entryId,
      required String relativePath,
      required String thumbnailPath,
      required int position,
      Value<int> rowid,
    });
typedef $$JournalPhotosTableUpdateCompanionBuilder =
    JournalPhotosCompanion Function({
      Value<String> id,
      Value<String> entryId,
      Value<String> relativePath,
      Value<String> thumbnailPath,
      Value<int> position,
      Value<int> rowid,
    });

final class $$JournalPhotosTableReferences
    extends
        BaseReferences<_$AppDatabase, $JournalPhotosTable, JournalPhotoRow> {
  $$JournalPhotosTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $JournalEntriesTable _entryIdTable(_$AppDatabase db) =>
      db.journalEntries.createAlias(
        $_aliasNameGenerator(db.journalPhotos.entryId, db.journalEntries.id),
      );

  $$JournalEntriesTableProcessedTableManager get entryId {
    final $_column = $_itemColumn<String>('entry_id')!;

    final manager = $$JournalEntriesTableTableManager(
      $_db,
      $_db.journalEntries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_entryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$JournalPhotosTableFilterComposer
    extends Composer<_$AppDatabase, $JournalPhotosTable> {
  $$JournalPhotosTableFilterComposer({
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

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  $$JournalEntriesTableFilterComposer get entryId {
    final $$JournalEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.journalEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JournalEntriesTableFilterComposer(
            $db: $db,
            $table: $db.journalEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$JournalPhotosTableOrderingComposer
    extends Composer<_$AppDatabase, $JournalPhotosTable> {
  $$JournalPhotosTableOrderingComposer({
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

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  $$JournalEntriesTableOrderingComposer get entryId {
    final $$JournalEntriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.journalEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JournalEntriesTableOrderingComposer(
            $db: $db,
            $table: $db.journalEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$JournalPhotosTableAnnotationComposer
    extends Composer<_$AppDatabase, $JournalPhotosTable> {
  $$JournalPhotosTableAnnotationComposer({
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

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  $$JournalEntriesTableAnnotationComposer get entryId {
    final $$JournalEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.journalEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JournalEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.journalEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$JournalPhotosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $JournalPhotosTable,
          JournalPhotoRow,
          $$JournalPhotosTableFilterComposer,
          $$JournalPhotosTableOrderingComposer,
          $$JournalPhotosTableAnnotationComposer,
          $$JournalPhotosTableCreateCompanionBuilder,
          $$JournalPhotosTableUpdateCompanionBuilder,
          (JournalPhotoRow, $$JournalPhotosTableReferences),
          JournalPhotoRow,
          PrefetchHooks Function({bool entryId})
        > {
  $$JournalPhotosTableTableManager(_$AppDatabase db, $JournalPhotosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JournalPhotosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JournalPhotosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JournalPhotosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> entryId = const Value.absent(),
                Value<String> relativePath = const Value.absent(),
                Value<String> thumbnailPath = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => JournalPhotosCompanion(
                id: id,
                entryId: entryId,
                relativePath: relativePath,
                thumbnailPath: thumbnailPath,
                position: position,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String entryId,
                required String relativePath,
                required String thumbnailPath,
                required int position,
                Value<int> rowid = const Value.absent(),
              }) => JournalPhotosCompanion.insert(
                id: id,
                entryId: entryId,
                relativePath: relativePath,
                thumbnailPath: thumbnailPath,
                position: position,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$JournalPhotosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({entryId = false}) {
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
                    if (entryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.entryId,
                                referencedTable: $$JournalPhotosTableReferences
                                    ._entryIdTable(db),
                                referencedColumn: $$JournalPhotosTableReferences
                                    ._entryIdTable(db)
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

typedef $$JournalPhotosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $JournalPhotosTable,
      JournalPhotoRow,
      $$JournalPhotosTableFilterComposer,
      $$JournalPhotosTableOrderingComposer,
      $$JournalPhotosTableAnnotationComposer,
      $$JournalPhotosTableCreateCompanionBuilder,
      $$JournalPhotosTableUpdateCompanionBuilder,
      (JournalPhotoRow, $$JournalPhotosTableReferences),
      JournalPhotoRow,
      PrefetchHooks Function({bool entryId})
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
  $$CareRulesTableTableManager get careRules =>
      $$CareRulesTableTableManager(_db, _db.careRules);
  $$CareTasksTableTableManager get careTasks =>
      $$CareTasksTableTableManager(_db, _db.careTasks);
  $$ScheduledNotificationsTableTableManager get scheduledNotifications =>
      $$ScheduledNotificationsTableTableManager(
        _db,
        _db.scheduledNotifications,
      );
  $$JournalEntriesTableTableManager get journalEntries =>
      $$JournalEntriesTableTableManager(_db, _db.journalEntries);
  $$JournalPhotosTableTableManager get journalPhotos =>
      $$JournalPhotosTableTableManager(_db, _db.journalPhotos);
}
