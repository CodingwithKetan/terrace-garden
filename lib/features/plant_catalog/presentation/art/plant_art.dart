import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:terrace_garden/features/plant_catalog/domain/plant_species.dart';

part 'plant_traits.dart';

/// Botanical illustrations drawn in code (Living Terrace). Every species
/// maps to a growth form, a trait (its fruit, head, flower or leaf shape)
/// and colours, so all catalogue plants get a distinct
/// drawing — from above for the terrace plan, from the side for cards and
/// plant pages — without bundling image files (KI-016 stays open for photos).
enum PlantForm {
  /// Compound leaves with fruit (tomato, chilli, brinjal, beans).
  fruiting,

  /// Big lobed leaves with a yellow flower (okra, gourds).
  palmate,

  /// A rosette of broad leaves (palak, lettuce, amaranth).
  rosette,

  /// A rosette with a root at the soil line (radish, carrot).
  root,

  /// Many small leaves (mint, tulsi, curry leaf, coriander, methi).
  cluster,

  /// Upright blades (lemongrass).
  grass,

  /// Foliage with flowers (marigold, hibiscus, jasmine, rose).
  flowering,

  /// Thick upright leaves (aloe vera, snake plant).
  succulent,

  /// Heart-shaped leaves on trailing stems (money plant).
  trailing,
}

@immutable
final class PlantArtSpec {
  const PlantArtSpec(
    this.form, {
    this.accent,
    this.leafDark = const Color(0xFF2E6A32),
    this.leafMid = const Color(0xFF4E8E3E),
    this.leafLight = const Color(0xFF7DB35A),
    this.rootColor,
    this.trait = ArtTrait.none,
  });

  /// The drawing for a species; falls back on its category.
  factory PlantArtSpec.of(String speciesId, {PlantCategory? category}) =>
      _bySpecies[speciesId] ??
      switch (category) {
        PlantCategory.vegetable => const PlantArtSpec(
          PlantForm.fruiting,
          accent: _red,
        ),
        PlantCategory.leafyGreen => const PlantArtSpec(PlantForm.rosette),
        PlantCategory.herb => const PlantArtSpec(PlantForm.cluster),
        PlantCategory.climber => const PlantArtSpec(PlantForm.palmate),
        PlantCategory.flower => const PlantArtSpec(
          PlantForm.flowering,
          accent: Color(0xFFF08C1A),
        ),
        PlantCategory.ornamental => const PlantArtSpec(PlantForm.succulent),
        PlantCategory.fruit => const PlantArtSpec(
          PlantForm.fruiting,
          accent: Color(0xFF8DBA2E),
        ),
        null => const PlantArtSpec(PlantForm.cluster),
      };
  final PlantForm form;

  /// Fruit or flower colour.
  final Color? accent;
  final Color leafDark;
  final Color leafMid;
  final Color leafLight;
  final Color? rootColor;

  /// What sets the species apart within its form.
  final ArtTrait trait;

  /// Whether [speciesId] has its own drawing (not its category's).
  static bool hasOwnDrawing(String speciesId) =>
      _bySpecies.containsKey(speciesId);

  /// Everything that changes how the drawing looks.
  Object get look => (
    form,
    trait,
    accent,
    leafDark,
    leafMid,
    leafLight,
    rootColor,
  );

  static const _red = Color(0xFFD9452B);
  static const _purple = Color(0xFF5B2A6E);

  static const Map<String, PlantArtSpec> _bySpecies = {
    'tomato': PlantArtSpec(PlantForm.fruiting, accent: _red),
    'bougainvillea': PlantArtSpec(
      PlantForm.flowering,
      accent: Color(0xFFC2185B),
      trait: ArtTrait.bracts,
    ),
    'adenium': PlantArtSpec(
      PlantForm.flowering,
      accent: Color(0xFFE94E77),
      trait: ArtTrait.trumpet,
    ),
    'jadePlant': PlantArtSpec(
      PlantForm.succulent,
      leafDark: Color(0xFF2E6B3A),
      leafMid: Color(0xFF4F8F4A),
      leafLight: Color(0xFF8CC07A),
      trait: ArtTrait.coins,
    ),
    'peaceLily': PlantArtSpec(
      PlantForm.flowering,
      accent: Color(0xFFF7F7F2),
      trait: ArtTrait.spathe,
    ),
    'rubberPlant': PlantArtSpec(
      PlantForm.palmate,
      leafDark: Color(0xFF1F3B2A),
      leafMid: Color(0xFF2F5A3C),
      leafLight: Color(0xFF5E7F52),
      trait: ArtTrait.bigLeaf,
    ),
    'zzPlant': PlantArtSpec(
      PlantForm.cluster,
      leafDark: Color(0xFF1F4D2B),
      leafMid: Color(0xFF2E6B3A),
      leafLight: Color(0xFF4F8F4A),
      trait: ArtTrait.glossyPinnate,
    ),
    'syngonium': PlantArtSpec(
      PlantForm.trailing,
      leafDark: Color(0xFF4F8A4A),
      leafMid: Color(0xFF8DBF7A),
      leafLight: Color(0xFFDDEFD0),
      trait: ArtTrait.arrowhead,
    ),
    'chrysanthemum': PlantArtSpec(
      PlantForm.flowering,
      accent: Color(0xFFF2C230),
      trait: ArtTrait.rays,
    ),
    'capsicum': PlantArtSpec(
      PlantForm.fruiting,
      accent: Color(0xFF3E9B3A),
      trait: ArtTrait.fruitBell,
    ),
    'cucumber': PlantArtSpec(
      PlantForm.palmate,
      accent: Color(0xFFF2D24B),
      trait: ArtTrait.gourdCucumber,
    ),
    'ridgeGourd': PlantArtSpec(
      PlantForm.palmate,
      accent: Color(0xFFF5D547),
      trait: ArtTrait.gourdRidged,
    ),
    'clusterBean': PlantArtSpec(
      PlantForm.fruiting,
      accent: Color(0xFF7DB34A),
      trait: ArtTrait.fruitPodCluster,
    ),
    'cowpea': PlantArtSpec(
      PlantForm.trailing,
      accent: Color(0xFFB98ACB),
      trait: ArtTrait.longPods,
    ),
    'peas': PlantArtSpec(
      PlantForm.trailing,
      accent: Color(0xFFF4F1F6),
      trait: ArtTrait.tendril,
    ),
    'cauliflower': PlantArtSpec(
      PlantForm.rosette,
      leafDark: Color(0xFF3F6E52),
      leafMid: Color(0xFF5C8C6A),
      leafLight: Color(0xFFF1EAD2),
      trait: ArtTrait.curd,
    ),
    'beetroot': PlantArtSpec(
      PlantForm.root,
      rootColor: Color(0xFF8E1F45),
      trait: ArtTrait.redStems,
    ),
    'springOnion': PlantArtSpec(
      PlantForm.grass,
      leafDark: Color(0xFF3F7D3A),
      leafMid: Color(0xFF5E9E48),
      leafLight: Color(0xFF8DC26A),
      trait: ArtTrait.tubular,
    ),
    'garlic': PlantArtSpec(
      PlantForm.grass,
      leafDark: Color(0xFF557A4A),
      leafMid: Color(0xFF759A62),
      leafLight: Color(0xFFA2BF84),
      trait: ArtTrait.flatBlade,
    ),
    'ginger': PlantArtSpec(
      PlantForm.grass,
      leafDark: Color(0xFF2E6B3A),
      leafMid: Color(0xFF4C8A4A),
      leafLight: Color(0xFF7DB065),
      trait: ArtTrait.broadBlade,
    ),
    'acidLime': PlantArtSpec(
      PlantForm.fruiting,
      accent: Color(0xFF9CC63B),
      trait: ArtTrait.fruitCitrus,
    ),
    'basil': PlantArtSpec(
      PlantForm.cluster,
      leafDark: Color(0xFF3E8E3E),
      leafMid: Color(0xFF5DAA4E),
      leafLight: Color(0xFF8FD06B),
      trait: ArtTrait.spike,
    ),
    'spiderPlant': PlantArtSpec(
      PlantForm.grass,
      leafDark: Color(0xFF4F8A4A),
      leafMid: Color(0xFF7CB36A),
      leafLight: Color(0xFFE9F2D8),
      trait: ArtTrait.striped,
    ),
    'arecaPalm': PlantArtSpec(
      PlantForm.grass,
      leafDark: Color(0xFF6E9A3E),
      leafMid: Color(0xFF94BC52),
      leafLight: Color(0xFFC4DC7C),
      trait: ArtTrait.frond,
    ),
    'aparajita': PlantArtSpec(
      PlantForm.trailing,
      accent: Color(0xFF2F4FB5),
      trait: ArtTrait.vineFlowers,
    ),
    'portulaca': PlantArtSpec(
      PlantForm.flowering,
      accent: Color(0xFFE6408C),
      trait: ArtTrait.cup,
    ),
    'periwinkle': PlantArtSpec(
      PlantForm.flowering,
      accent: Color(0xFFE77FB0),
      trait: ArtTrait.pinwheel,
    ),
    'chilli': PlantArtSpec(
      PlantForm.fruiting,
      accent: Color(0xFFC8311E),
      trait: ArtTrait.fruitLong,
    ),
    'brinjal': PlantArtSpec(
      PlantForm.fruiting,
      accent: _purple,
      trait: ArtTrait.fruitOblong,
    ),
    'frenchBean': PlantArtSpec(
      PlantForm.fruiting,
      accent: Color(0xFF8CBF4E),
      trait: ArtTrait.fruitPod,
    ),
    'okra': PlantArtSpec(
      PlantForm.palmate,
      accent: Color(0xFFE9D46B),
      trait: ArtTrait.uprightPod,
    ),
    'bitterGourd': PlantArtSpec(
      PlantForm.palmate,
      accent: Color(0xFFF2C94C),
      trait: ArtTrait.gourdWarty,
    ),
    'bottleGourd': PlantArtSpec(
      PlantForm.palmate,
      accent: Color(0xFFF7F3E8),
      trait: ArtTrait.gourdBottle,
    ),
    'palak': PlantArtSpec(PlantForm.rosette),
    'lettuce': PlantArtSpec(
      PlantForm.rosette,
      leafDark: Color(0xFF6AA84F),
      leafMid: Color(0xFF8FC566),
      leafLight: Color(0xFFC8E68E),
      trait: ArtTrait.ruffled,
    ),
    'amaranth': PlantArtSpec(
      PlantForm.rosette,
      leafDark: Color(0xFF7A2E4A),
      leafMid: Color(0xFF9E3D5C),
      leafLight: Color(0xFF6E9E50),
      trait: ArtTrait.plume,
    ),
    'radish': PlantArtSpec(PlantForm.root, rootColor: Color(0xFFF3EEE6)),
    'carrot': PlantArtSpec(
      PlantForm.root,
      rootColor: Color(0xFFE67E22),
      trait: ArtTrait.feathery,
    ),
    'mint': PlantArtSpec(
      PlantForm.cluster,
      leafDark: Color(0xFF3F8A42),
      leafMid: Color(0xFF5FA052),
      leafLight: Color(0xFF8CCB75),
    ),
    'tulsi': PlantArtSpec(
      PlantForm.cluster,
      leafDark: Color(0xFF3B6B3A),
      leafMid: Color(0xFF6B4A6E),
      leafLight: Color(0xFF7FAE5E),
      trait: ArtTrait.spike,
    ),
    'curryLeaf': PlantArtSpec(PlantForm.cluster, trait: ArtTrait.pinnate),
    'coriander': PlantArtSpec(
      PlantForm.cluster,
      leafDark: Color(0xFF4F9A45),
      leafMid: Color(0xFF6DB257),
      leafLight: Color(0xFF9ACF7C),
      trait: ArtTrait.lacy,
    ),
    'methi': PlantArtSpec(
      PlantForm.cluster,
      leafDark: Color(0xFF4A8F3E),
      leafMid: Color(0xFF68AA52),
      leafLight: Color(0xFF94C978),
      trait: ArtTrait.trifoliate,
    ),
    'lemongrass': PlantArtSpec(
      PlantForm.grass,
      leafDark: Color(0xFF5E8F3E),
      leafMid: Color(0xFF86B356),
      leafLight: Color(0xFFB6D57E),
    ),
    'marigold': PlantArtSpec(
      PlantForm.flowering,
      accent: Color(0xFFF08C1A),
      trait: ArtTrait.pompom,
    ),
    'hibiscus': PlantArtSpec(
      PlantForm.flowering,
      accent: Color(0xFFD7263D),
      trait: ArtTrait.bigPetals,
    ),
    'jasmine': PlantArtSpec(
      PlantForm.flowering,
      accent: Color(0xFFFFFFFF),
      trait: ArtTrait.star,
    ),
    'rose': PlantArtSpec(
      PlantForm.flowering,
      accent: Color(0xFFD8456B),
      trait: ArtTrait.spiral,
    ),
    'aloeVera': PlantArtSpec(
      PlantForm.succulent,
      leafDark: Color(0xFF5E8C6A),
      leafMid: Color(0xFF7FAA86),
      leafLight: Color(0xFFA9CBAE),
    ),
    'strawberry': PlantArtSpec(
      PlantForm.fruiting,
      accent: Color(0xFFD7263D),
      trait: ArtTrait.fruitBerry,
    ),
    'pomegranate': PlantArtSpec(
      PlantForm.fruiting,
      accent: Color(0xFFB3202E),
      trait: ArtTrait.fruitCrowned,
    ),
    'guava': PlantArtSpec(
      PlantForm.fruiting,
      accent: Color(0xFFA8C94A),
      trait: ArtTrait.fruitPear,
    ),
    'fig': PlantArtSpec(
      PlantForm.palmate,
      accent: Color(0xFF6B3E5E),
      trait: ArtTrait.figFruit,
    ),
    'dragonFruit': PlantArtSpec(
      PlantForm.succulent,
      leafDark: Color(0xFF3E7D4A),
      leafMid: Color(0xFF5E9E5A),
      leafLight: Color(0xFFE0457B),
      trait: ArtTrait.cactus,
    ),
    'papaya': PlantArtSpec(
      PlantForm.palmate,
      accent: Color(0xFFF2A33A),
      trait: ArtTrait.tree,
    ),
    'mulberry': PlantArtSpec(
      PlantForm.fruiting,
      accent: Color(0xFF4A1E3A),
      trait: ArtTrait.fruitBerryCluster,
    ),
    'banana': PlantArtSpec(
      PlantForm.grass,
      leafDark: Color(0xFF5C9A3E),
      leafMid: Color(0xFF7DB84E),
      leafLight: Color(0xFFB5D77A),
      trait: ArtTrait.paddle,
    ),
    'cabbage': PlantArtSpec(
      PlantForm.rosette,
      leafDark: Color(0xFF4F7F6A),
      leafMid: Color(0xFF7FA88E),
      leafLight: Color(0xFFBFD8B8),
      trait: ArtTrait.head,
    ),
    'broccoli': PlantArtSpec(
      PlantForm.rosette,
      leafDark: Color(0xFF2F5E45),
      leafMid: Color(0xFF467A55),
      leafLight: Color(0xFF5E8F4A),
      trait: ArtTrait.florets,
    ),
    'potato': PlantArtSpec(
      PlantForm.root,
      rootColor: Color(0xFFC9A26B),
      trait: ArtTrait.tubers,
    ),
    'onion': PlantArtSpec(
      PlantForm.grass,
      leafDark: Color(0xFF3A6E46),
      leafMid: Color(0xFF5A8E5E),
      leafLight: Color(0xFF8DB98A),
      trait: ArtTrait.bulb,
    ),
    'pumpkin': PlantArtSpec(
      PlantForm.palmate,
      accent: Color(0xFFE67E22),
      trait: ArtTrait.gourdRound,
    ),
    'spongeGourd': PlantArtSpec(
      PlantForm.palmate,
      accent: Color(0xFFF7DC5C),
      trait: ArtTrait.gourdLong,
    ),
    'drumstick': PlantArtSpec(
      PlantForm.cluster,
      leafDark: Color(0xFF4F8A3E),
      leafMid: Color(0xFF76AE5A),
      leafLight: Color(0xFFA7D17E),
      trait: ArtTrait.bipinnate,
    ),
    'sweetPotato': PlantArtSpec(
      PlantForm.trailing,
      leafMid: Color(0xFF4F8A3E),
      leafLight: Color(0xFF9CC46A),
    ),
    'turmeric': PlantArtSpec(
      PlantForm.grass,
      leafDark: Color(0xFF3E7A3A),
      leafMid: Color(0xFF5E9A4A),
      leafLight: Color(0xFF9CC870),
      trait: ArtTrait.wideBlade,
    ),
    'neem': PlantArtSpec(
      PlantForm.cluster,
      leafDark: Color(0xFF2F6B32),
      leafMid: Color(0xFF4A8A3A),
      leafLight: Color(0xFF8FC060),
      trait: ArtTrait.pinnateNarrow,
    ),
    'calendula': PlantArtSpec(
      PlantForm.flowering,
      accent: Color(0xFFF7A21B),
      trait: ArtTrait.daisy,
    ),
    'gotuKola': PlantArtSpec(
      PlantForm.rosette,
      leafDark: Color(0xFF4F8F3E),
      leafMid: Color(0xFF6FAE55),
      leafLight: Color(0xFFA2D27E),
      trait: ArtTrait.roundLeaves,
    ),
    'lavender': PlantArtSpec(
      PlantForm.flowering,
      accent: Color(0xFF8E7CC3),
      leafDark: Color(0xFF5E7A62),
      leafMid: Color(0xFF7E9A80),
      leafLight: Color(0xFFB4C7B0),
      trait: ArtTrait.flowerSpike,
    ),
    'vetiver': PlantArtSpec(
      PlantForm.grass,
      leafDark: Color(0xFF5E8A3E),
      leafMid: Color(0xFF86AE58),
      leafLight: Color(0xFFC2D88A),
    ),
    'snakePlant': PlantArtSpec(
      PlantForm.succulent,
      leafDark: Color(0xFF2F5B3A),
      leafMid: Color(0xFF4F7F4E),
      leafLight: Color(0xFFC9C46A),
      trait: ArtTrait.swords,
    ),
    'moneyPlant': PlantArtSpec(
      PlantForm.trailing,
      leafMid: Color(0xFF4F9A45),
      leafLight: Color(0xFFE2D36B),
    ),
    // Second wave (ADR-035).
    'spinachBeet': PlantArtSpec(
      PlantForm.rosette,
      leafDark: Color(0xFF2F6A3A),
      leafMid: Color(0xFF4A8A4A),
      leafLight: Color(0xFF8FBF6A),
      rootColor: Color(0xFFE6EDC8),
      trait: ArtTrait.redStems,
    ),
    'malabarSpinach': PlantArtSpec(
      PlantForm.trailing,
      accent: Color(0xFFF3D6E4),
      leafDark: Color(0xFF2E6B2E),
      leafMid: Color(0xFF4F9A3E),
      leafLight: Color(0xFF8CC860),
      trait: ArtTrait.vineFlowers,
    ),
    'gongura': PlantArtSpec(
      PlantForm.palmate,
      accent: Color(0xFFF2E27A),
      leafMid: Color(0xFF4E8A3E),
      rootColor: Color(0xFFA3283A),
      trait: ArtTrait.redStems,
    ),
    'mustardGreens': PlantArtSpec(
      PlantForm.rosette,
      leafDark: Color(0xFF3E7A3A),
      leafMid: Color(0xFF5E9A44),
      leafLight: Color(0xFF9CC870),
      trait: ArtTrait.ruffled,
    ),
    'knolKhol': PlantArtSpec(
      PlantForm.rosette,
      leafDark: Color(0xFF4E7A6A),
      leafMid: Color(0xFF6E9A86),
      leafLight: Color(0xFFB7D6A0),
      trait: ArtTrait.knob,
    ),
    'turnip': PlantArtSpec(
      PlantForm.root,
      leafDark: Color(0xFF3A7A3E),
      leafMid: Color(0xFF5A9A4E),
      rootColor: Color(0xFFD9C2E6),
    ),
    'snakeGourd': PlantArtSpec(
      PlantForm.palmate,
      accent: Color(0xFFF7F3E8),
      leafMid: Color(0xFF5A9645),
      trait: ArtTrait.gourdSnake,
    ),
    'ashGourd': PlantArtSpec(
      PlantForm.palmate,
      accent: Color(0xFFF5D547),
      leafMid: Color(0xFF4A8A40),
      trait: ArtTrait.gourdAsh,
    ),
    'ivyGourd': PlantArtSpec(
      PlantForm.palmate,
      accent: Color(0xFFF7F3E8),
      leafMid: Color(0xFF3E8A3A),
      leafLight: Color(0xFF86BE5E),
      trait: ArtTrait.gourdIvy,
    ),
    'lablab': PlantArtSpec(
      PlantForm.trailing,
      accent: Color(0xFF9A5BB0),
      leafMid: Color(0xFF4A8A3E),
      trait: ArtTrait.longPods,
    ),
    'wingedBean': PlantArtSpec(
      PlantForm.trailing,
      accent: Color(0xFF8FA8E0),
      leafMid: Color(0xFF3E7E3A),
      trait: ArtTrait.tendril,
    ),
    'sweetCorn': PlantArtSpec(
      PlantForm.grass,
      leafDark: Color(0xFF3E7A34),
      leafMid: Color(0xFF5E9A44),
      leafLight: Color(0xFFA6CC74),
      trait: ArtTrait.corn,
    ),
    'colocasia': PlantArtSpec(
      PlantForm.palmate,
      leafDark: Color(0xFF2F5E3A),
      leafMid: Color(0xFF4A7E4E),
      leafLight: Color(0xFF9CBF8A),
      trait: ArtTrait.elephantEar,
    ),
    'dill': PlantArtSpec(
      PlantForm.cluster,
      leafDark: Color(0xFF3E6E52),
      leafMid: Color(0xFF5E8E6A),
      leafLight: Color(0xFF9CC096),
      trait: ArtTrait.lacy,
    ),
    'fennel': PlantArtSpec(
      PlantForm.cluster,
      leafDark: Color(0xFF557A3E),
      leafMid: Color(0xFF7FA054),
      leafLight: Color(0xFFC2D88A),
      trait: ArtTrait.lacy,
    ),
    'indianBorage': PlantArtSpec(
      PlantForm.cluster,
      leafDark: Color(0xFF5E9A5A),
      leafMid: Color(0xFF7FB676),
      leafLight: Color(0xFFB9DCA8),
      trait: ArtTrait.scalloped,
    ),
    'parsley': PlantArtSpec(
      PlantForm.cluster,
      leafDark: Color(0xFF2E6E2E),
      leafMid: Color(0xFF3F8A3A),
      leafLight: Color(0xFF76B25A),
      trait: ArtTrait.ruffled,
    ),
    'rosemary': PlantArtSpec(
      PlantForm.cluster,
      accent: Color(0xFF8FA8E0),
      leafDark: Color(0xFF3E5E4E),
      leafMid: Color(0xFF5E7E6A),
      leafLight: Color(0xFFA8BFAE),
      trait: ArtTrait.woodyHerb,
    ),
    'thyme': PlantArtSpec(
      PlantForm.cluster,
      accent: Color(0xFFD9A6CC),
      leafDark: Color(0xFF4E6E4A),
      leafMid: Color(0xFF6E8E62),
      leafLight: Color(0xFFA8BF96),
      trait: ArtTrait.woodyHerb,
    ),
    'oregano': PlantArtSpec(
      PlantForm.cluster,
      accent: Color(0xFFD9A0C8),
      leafDark: Color(0xFF4A7A3E),
      leafMid: Color(0xFF6A9A52),
      leafLight: Color(0xFF9CC07A),
      trait: ArtTrait.spike,
    ),
    'stevia': PlantArtSpec(
      PlantForm.cluster,
      leafDark: Color(0xFF3E8A3E),
      leafMid: Color(0xFF5EAA4E),
      leafLight: Color(0xFF94D070),
      trait: ArtTrait.broadBlade,
    ),
    'betelLeaf': PlantArtSpec(
      PlantForm.trailing,
      leafDark: Color(0xFF2E6A2E),
      leafMid: Color(0xFF4A8E3A),
      leafLight: Color(0xFF8CC060),
      trait: ArtTrait.caneHearts,
    ),
    'brahmi': PlantArtSpec(
      PlantForm.trailing,
      leafDark: Color(0xFF3E7A3A),
      leafMid: Color(0xFF6AA552),
      leafLight: Color(0xFF9CCB7A),
      trait: ArtTrait.creeping,
    ),
    'zinnia': PlantArtSpec(
      PlantForm.flowering,
      accent: Color(0xFFD6336C),
      trait: ArtTrait.rays,
    ),
    'cosmos': PlantArtSpec(
      PlantForm.flowering,
      accent: Color(0xFFE88AC0),
      leafDark: Color(0xFF4E8A3E),
      leafMid: Color(0xFF76B05A),
      trait: ArtTrait.daisy,
    ),
    'sunflower': PlantArtSpec(
      PlantForm.flowering,
      accent: Color(0xFFF2B81B),
      trait: ArtTrait.sunflower,
    ),
    'petunia': PlantArtSpec(
      PlantForm.flowering,
      accent: Color(0xFF8E44AD),
      trait: ArtTrait.trumpet,
    ),
    'balsam': PlantArtSpec(
      PlantForm.flowering,
      accent: Color(0xFFE84F8A),
      leafMid: Color(0xFF5EAA4E),
      trait: ArtTrait.cup,
    ),
    'gerbera': PlantArtSpec(
      PlantForm.flowering,
      accent: Color(0xFFE8452B),
      leafDark: Color(0xFF3E6E3A),
      trait: ArtTrait.rays,
    ),
    'dahlia': PlantArtSpec(
      PlantForm.flowering,
      accent: Color(0xFFC2185B),
      leafDark: Color(0xFF2F5E32),
      trait: ArtTrait.pompom,
    ),
    'tuberose': PlantArtSpec(
      PlantForm.flowering,
      accent: Color(0xFFF7F5EE),
      leafDark: Color(0xFF3E7A3A),
      leafMid: Color(0xFF6A9E52),
      trait: ArtTrait.flowerSpike,
    ),
    'crossandra': PlantArtSpec(
      PlantForm.flowering,
      accent: Color(0xFFF28C28),
      leafDark: Color(0xFF1F5A2E),
      trait: ArtTrait.pinwheel,
    ),
    'ixora': PlantArtSpec(
      PlantForm.flowering,
      accent: Color(0xFFE8352B),
      leafDark: Color(0xFF1F4D2B),
      trait: ArtTrait.floretBall,
    ),
    'plumeria': PlantArtSpec(
      PlantForm.flowering,
      accent: Color(0xFFF7EFD2),
      leafDark: Color(0xFF3E7A3A),
      leafMid: Color(0xFF5E9A4A),
      trait: ArtTrait.pinwheel,
    ),
    'croton': PlantArtSpec(
      PlantForm.palmate,
      leafDark: Color(0xFF7A2E1E),
      leafMid: Color(0xFFC2592B),
      leafLight: Color(0xFFF2C230),
      trait: ArtTrait.bigLeaf,
    ),
    'bostonFern': PlantArtSpec(
      PlantForm.grass,
      leafDark: Color(0xFF3E8A3A),
      leafMid: Color(0xFF5EAA4E),
      leafLight: Color(0xFF94CC6A),
      trait: ArtTrait.frond,
    ),
    'anthurium': PlantArtSpec(
      PlantForm.flowering,
      accent: Color(0xFFD7263D),
      leafDark: Color(0xFF1F4D2B),
      leafMid: Color(0xFF2E6B3A),
      trait: ArtTrait.spathe,
    ),
    'aglaonema': PlantArtSpec(
      PlantForm.palmate,
      leafDark: Color(0xFF2E5E3A),
      leafMid: Color(0xFF6E9A7E),
      leafLight: Color(0xFFE6B8C2),
      trait: ArtTrait.bigLeaf,
    ),
    'kalanchoe': PlantArtSpec(
      PlantForm.flowering,
      accent: Color(0xFFF2563A),
      leafDark: Color(0xFF2E6B3A),
      leafMid: Color(0xFF4F8F4A),
      leafLight: Color(0xFF8CC07A),
      trait: ArtTrait.floretBall,
    ),
    'coleus': PlantArtSpec(
      PlantForm.cluster,
      accent: Color(0xFF8E1F45),
      leafDark: Color(0xFF6E9A3E),
      leafMid: Color(0xFF94BC52),
      leafLight: Color(0xFFD9E68A),
      trait: ArtTrait.scalloped,
    ),
    'philodendron': PlantArtSpec(
      PlantForm.trailing,
      leafDark: Color(0xFF1F5A2E),
      leafMid: Color(0xFF2F7A3A),
      leafLight: Color(0xFF5EA052),
    ),
    'rhapisPalm': PlantArtSpec(
      PlantForm.grass,
      leafDark: Color(0xFF2E5E32),
      leafMid: Color(0xFF4A7E44),
      leafLight: Color(0xFF8AAE6A),
      trait: ArtTrait.fanPalm,
    ),
    'lemon': PlantArtSpec(
      PlantForm.fruiting,
      accent: Color(0xFFF2D22E),
      leafDark: Color(0xFF2E5E2E),
      trait: ArtTrait.fruitCitrus,
    ),
    'sapota': PlantArtSpec(
      PlantForm.fruiting,
      accent: Color(0xFF8A5A3A),
      leafDark: Color(0xFF1F4D2B),
      leafMid: Color(0xFF2F6B3A),
      trait: ArtTrait.fruitPear,
    ),
    'mango': PlantArtSpec(
      PlantForm.fruiting,
      accent: Color(0xFFF2A33A),
      leafDark: Color(0xFF1F4D2B),
      leafMid: Color(0xFF3E6E3A),
      trait: ArtTrait.fruitOblong,
    ),
    'amla': PlantArtSpec(
      PlantForm.fruiting,
      accent: Color(0xFFC9D98A),
      leafMid: Color(0xFF6A9E52),
      leafLight: Color(0xFFA8CC80),
      trait: ArtTrait.fruitCitrus,
    ),
    'capeGooseberry': PlantArtSpec(
      PlantForm.fruiting,
      accent: Color(0xFFD9C08A),
      leafDark: Color(0xFF4E7A3E),
      leafMid: Color(0xFF6E9A52),
      trait: ArtTrait.lantern,
    ),
    'passionFruit': PlantArtSpec(
      PlantForm.trailing,
      accent: Color(0xFFB98AD9),
      leafDark: Color(0xFF2E6B2E),
      leafMid: Color(0xFF3E8A3A),
      trait: ArtTrait.vineFlowers,
    ),
    'grape': PlantArtSpec(
      PlantForm.trailing,
      accent: Color(0xFF5B2A6E),
      leafDark: Color(0xFF3E7A34),
      leafMid: Color(0xFF6A9E44),
      trait: ArtTrait.grapeBunch,
    ),
    'pineapple': PlantArtSpec(
      PlantForm.succulent,
      accent: Color(0xFFE8A33A),
      leafDark: Color(0xFF4E7A5A),
      leafMid: Color(0xFF6E9A72),
      leafLight: Color(0xFFA8C8A0),
      trait: ArtTrait.pineapple,
    ),
  };
}

/// A leaf pointing along +x from the origin: [length] long, [width] wide.
Path leafPath(double length, double width) => Path()
  ..moveTo(0, 0)
  ..cubicTo(length * .22, -width * .9, length * .72, -width * .95, length, 0)
  ..cubicTo(length * .72, width * .95, length * .22, width * .9, 0, 0)
  ..close();

void _leaf(
  Canvas canvas,
  Offset origin,
  double angle,
  double length,
  double width,
  Color color,
) {
  canvas
    ..save()
    ..translate(origin.dx, origin.dy)
    ..rotate(angle)
    ..drawPath(leafPath(length, width), Paint()..color = color)
    ..restore();
}

double _rad(double degrees) => degrees * math.pi / 180;

// ---------------------------------------------------------------------------
// Top view
// ---------------------------------------------------------------------------

/// A plant seen from above, centred, filling a circle of [size].
class PlantTopArt extends StatelessWidget {
  const PlantTopArt({
    required this.spec,
    required this.size,
    this.semanticLabel,
    super.key,
  });

  final PlantArtSpec spec;
  final double size;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final art = CustomPaint(
      size: Size.square(size),
      painter: PlantTopPainter(spec),
    );
    return semanticLabel == null
        ? ExcludeSemantics(child: art)
        : Semantics(image: true, label: semanticLabel, child: art);
  }
}

class PlantTopPainter extends CustomPainter {
  const PlantTopPainter(this.spec);

  final PlantArtSpec spec;

  @override
  void paint(Canvas canvas, Size size) {
    final r = size.shortestSide / 2;
    canvas
      ..save()
      ..translate(size.width / 2, size.height / 2);
    final s = spec;
    if (!s.trait.replacesForm) _paintForm(canvas, r, s);
    _topTrait(canvas, r, s);
    canvas.restore();
  }

  void _paintForm(Canvas canvas, double r, PlantArtSpec s) {
    switch (s.form) {
      case PlantForm.fruiting:
        // The fruit itself is the trait's (see _topTrait).
        _radial(canvas, 7, r * .95, r * .34, s.leafDark, 0);
        _radial(canvas, 7, r * .72, r * .27, s.leafMid, 26);
        _radial(canvas, 3, r * .38, r * .16, s.leafLight, 60);
      case PlantForm.palmate:
        for (var i = 0; i < 5; i++) {
          _lobed(canvas, _rad(i * 72.0 - 90), r * .95, s.leafMid);
        }
        _radial(canvas, 3, r * .55, r * .22, s.leafLight, 36);
        canvas.drawCircle(
          Offset.zero,
          r * .12,
          Paint()..color = s.accent ?? const Color(0xFFE9D46B),
        );
      case PlantForm.rosette || PlantForm.root:
        _radial(canvas, 8, r * .95, r * .36, s.leafDark, 0, fromCentre: true);
        _radial(canvas, 4, r * .6, r * .28, s.leafMid, 22, fromCentre: true);
        final vein = Paint()
          ..color = s.leafLight.withValues(alpha: .8)
          ..strokeWidth = math.max(1, r * .03)
          ..style = PaintingStyle.stroke;
        for (var i = 0; i < 8; i++) {
          final a = _rad(i * 45.0);
          canvas.drawLine(
            Offset.zero,
            Offset(math.cos(a), math.sin(a)) * r * .75,
            vein,
          );
        }
      case PlantForm.cluster:
        final rnd = math.Random(7);
        for (var i = 0; i < 14; i++) {
          final a = rnd.nextDouble() * math.pi * 2;
          final d = (.25 + rnd.nextDouble() * .55) * r;
          _leaf(
            canvas,
            Offset(math.cos(a), math.sin(a)) * d * .4,
            a,
            r * .42,
            r * .16,
            i.isEven ? s.leafDark : s.leafMid,
          );
        }
        _radial(canvas, 4, r * .32, r * .13, s.leafLight, 15);
      case PlantForm.grass:
        final blade = Paint()
          ..color = s.leafMid
          ..strokeWidth = math.max(1.5, r * .07)
          ..strokeCap = StrokeCap.round;
        for (var i = 0; i < 12; i++) {
          final a = _rad(i * 30.0 + 8);
          canvas.drawLine(
            Offset.zero,
            Offset(math.cos(a), math.sin(a)) * r * .95,
            blade..color = i.isEven ? s.leafMid : s.leafDark,
          );
        }
        canvas.drawCircle(Offset.zero, r * .14, Paint()..color = s.leafLight);
      case PlantForm.flowering:
        _radial(canvas, 8, r * .9, r * .3, s.leafDark, 0);
        _radial(canvas, 6, r * .6, r * .24, s.leafMid, 30);
        for (final (dx, dy) in const [(.3, -.3), (-.35, -.1), (.1, .38)]) {
          _bloom(canvas, Offset(dx * r, dy * r), r * .2, s);
        }
      case PlantForm.succulent:
        for (var i = 0; i < 9; i++) {
          _leaf(
            canvas,
            Offset.zero,
            _rad(i * 40.0),
            r * .95,
            r * .2,
            i.isEven ? s.leafDark : s.leafMid,
          );
        }
        _radial(canvas, 5, r * .5, r * .14, s.leafLight, 20);
      case PlantForm.trailing:
        for (var i = 0; i < 9; i++) {
          final a = _rad(i * 40.0);
          final p = Offset(math.cos(a), math.sin(a)) * r * .55;
          _heart(canvas, p, r * .46, i.isEven ? s.leafMid : s.leafDark);
        }
        _heart(canvas, Offset.zero, r * .42, s.leafLight);
    }
  }

  void _radial(
    Canvas canvas,
    int count,
    double length,
    double width,
    Color color,
    double offsetDeg, {
    bool fromCentre = false,
  }) {
    for (var i = 0; i < count; i++) {
      final a = _rad(offsetDeg + i * 360 / count);
      _leaf(
        canvas,
        fromCentre ? Offset.zero : Offset(math.cos(a), math.sin(a)) * 2,
        a,
        length,
        width,
        color,
      );
    }
  }

  void _lobed(Canvas canvas, double angle, double length, Color color) {
    final path = Path()
      ..moveTo(0, 0)
      ..cubicTo(
        length * .2,
        -length * .3,
        length * .6,
        -length * .35,
        length * .85,
        -length * .18,
      )
      ..quadraticBezierTo(length * .7, -length * .05, length, 0)
      ..quadraticBezierTo(length * .7, length * .05, length * .85, length * .18)
      ..cubicTo(length * .6, length * .35, length * .2, length * .3, 0, 0)
      ..close();
    canvas
      ..save()
      ..rotate(angle)
      ..drawPath(path, Paint()..color = color)
      ..drawLine(
        Offset.zero,
        Offset(length * .9, 0),
        Paint()
          ..color = Colors.white.withValues(alpha: .25)
          ..strokeWidth = math.max(1, length * .025),
      )
      ..restore();
  }

  @override
  bool shouldRepaint(PlantTopPainter oldDelegate) => oldDelegate.spec != spec;
}

void _flower(Canvas canvas, Offset centre, double r, Color color) {
  final petal = Paint()..color = color;
  for (var i = 0; i < 6; i++) {
    final a = _rad(i * 60.0);
    canvas.drawCircle(
      centre + Offset(math.cos(a), math.sin(a)) * r * .55,
      r * .45,
      petal,
    );
  }
  canvas.drawCircle(
    centre,
    r * .35,
    Paint()
      ..color = color == const Color(0xFFFFFFFF)
          ? const Color(0xFFE9D46B)
          : Color.lerp(color, Colors.black, .25)!,
  );
}

void _heart(Canvas canvas, Offset centre, double size, Color color) {
  final p = Path()
    ..moveTo(centre.dx, centre.dy + size * .5)
    ..cubicTo(
      centre.dx - size * .9,
      centre.dy - size * .05,
      centre.dx - size * .5,
      centre.dy - size * .75,
      centre.dx,
      centre.dy - size * .3,
    )
    ..cubicTo(
      centre.dx + size * .5,
      centre.dy - size * .75,
      centre.dx + size * .9,
      centre.dy - size * .05,
      centre.dx,
      centre.dy + size * .5,
    )
    ..close();
  canvas.drawPath(p, Paint()..color = color);
}

// ---------------------------------------------------------------------------
// Side view
// ---------------------------------------------------------------------------

enum PotStyle { terracotta, growBag }

/// A plant in a pot, seen from the side. Drawn in a box of `size`
/// (width × 1.0 height).
class PlantSideArt extends StatelessWidget {
  const PlantSideArt({
    required this.spec,
    required this.size,
    this.pot = PotStyle.terracotta,
    this.semanticLabel,
    super.key,
  });

  final PlantArtSpec spec;
  final double size;
  final PotStyle pot;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final art = CustomPaint(
      size: Size.square(size),
      painter: PlantSidePainter(spec, pot),
    );
    return semanticLabel == null
        ? ExcludeSemantics(child: art)
        : Semantics(image: true, label: semanticLabel, child: art);
  }
}

class PlantSidePainter extends CustomPainter {
  const PlantSidePainter(this.spec, this.pot);

  final PlantArtSpec spec;
  final PotStyle pot;

  @override
  void paint(Canvas canvas, Size size) {
    // Work in a 120 × 120 box.
    final k = size.shortestSide / 120;
    canvas
      ..save()
      ..scale(k);
    final s = spec;

    // Shadow.
    canvas.drawOval(
      const Rect.fromLTWH(18, 108, 84, 10),
      Paint()..color = const Color(0x262B2418),
    );

    // Plant behind the pot rim.
    if (!s.trait.replacesForm) _paintForm(canvas, s);
    _sideTrait(canvas, s);
    _paintPot(canvas);
    canvas.restore();
  }

  void _paintForm(Canvas canvas, PlantArtSpec s) {
    const soil = Offset(60, 80);
    switch (s.form) {
      case PlantForm.fruiting:
        final stem = Paint()
          ..color = const Color(0xFF3E7A34)
          ..strokeWidth = 3
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;
        canvas.drawPath(
          Path()
            ..moveTo(60, 80)
            ..cubicTo(58, 60, 64, 40, 62, 16),
          stem,
        );
        for (final (x, y, a, l) in const [
          (61.0, 66.0, 200.0, 26.0),
          (61.0, 60.0, -20.0, 26.0),
          (62.0, 44.0, 205.0, 24.0),
          (62.0, 38.0, -25.0, 24.0),
          (62.0, 22.0, 230.0, 18.0),
          (62.0, 18.0, -50.0, 18.0),
        ]) {
          _leaf(canvas, Offset(x, y), _rad(a), l, 8, s.leafDark);
        }
        for (final (x, y, a) in const [
          (61.0, 54.0, 190.0),
          (62.0, 30.0, -10.0),
        ]) {
          _leaf(canvas, Offset(x, y), _rad(a), 18, 6, s.leafMid);
        }
      // The fruit itself is the trait's (see _sideTrait).
      case PlantForm.palmate:
        final stem = Paint()
          ..color = const Color(0xFF4B6B3A)
          ..strokeWidth = 3
          ..style = PaintingStyle.stroke;
        canvas.drawLine(soil, const Offset(60, 14), stem);
        for (final (x, y, a) in const [
          (60.0, 62.0, 205.0),
          (60.0, 56.0, -25.0),
          (60.0, 38.0, 215.0),
          (60.0, 32.0, -35.0),
        ]) {
          _leaf(canvas, Offset(x, y), _rad(a), 30, 13, s.leafMid);
        }
        _leaf(canvas, const Offset(60, 22), _rad(-90), 14, 8, s.leafLight);
        canvas.drawCircle(
          const Offset(68, 28),
          5,
          Paint()..color = s.accent ?? const Color(0xFFE9D46B),
        );
      case PlantForm.rosette:
        for (final (a, l, w, c) in [
          (-150.0, 32.0, 14.0, s.leafDark),
          (-30.0, 32.0, 14.0, s.leafDark),
          (-122.0, 40.0, 17.0, s.leafDark),
          (-58.0, 40.0, 17.0, s.leafDark),
          (-90.0, 46.0, 18.0, s.leafMid),
          (-108.0, 34.0, 14.0, s.leafMid),
          (-72.0, 34.0, 14.0, s.leafMid),
          (-90.0, 26.0, 10.0, s.leafLight),
        ]) {
          _leaf(canvas, const Offset(60, 78), _rad(a), l, w, c);
        }
      case PlantForm.root:
        final root = Paint()..color = s.rootColor ?? Colors.white;
        for (final (a, l, c) in [
          (-125.0, 34.0, s.leafDark),
          (-55.0, 34.0, s.leafDark),
          (-100.0, 40.0, s.leafMid),
          (-80.0, 40.0, s.leafMid),
        ]) {
          _leaf(canvas, const Offset(60, 64), _rad(a), l, 10, c);
        }
        // The root's shoulder shows above the soil.
        canvas.drawPath(
          Path()
            ..moveTo(49, 76)
            ..cubicTo(49, 62, 71, 62, 71, 76)
            ..close(),
          root,
        );
      case PlantForm.cluster:
        final stem = Paint()
          ..color = s.leafDark
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke;
        for (final dx in const [-14.0, 0.0, 14.0]) {
          canvas.drawLine(soil, Offset(60 + dx, 30), stem);
          for (var i = 0; i < 4; i++) {
            final y = 70.0 - i * 11;
            final x = 60 + dx * (80 - y) / 50;
            _leaf(canvas, Offset(x, y), _rad(200), 11, 5, s.leafMid);
            _leaf(canvas, Offset(x, y), _rad(-20), 11, 5, s.leafDark);
          }
          _leaf(canvas, Offset(60 + dx, 30), _rad(-90), 9, 5, s.leafLight);
        }
      case PlantForm.grass:
        final blade = Paint()
          ..strokeWidth = 3
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke;
        for (final (dx, top, c) in [
          (-24.0, 20.0, s.leafDark),
          (-12.0, 8.0, s.leafMid),
          (0.0, 4.0, s.leafDark),
          (12.0, 10.0, s.leafMid),
          (24.0, 22.0, s.leafLight),
        ]) {
          canvas.drawPath(
            Path()
              ..moveTo(60 + dx / 4, 80)
              ..quadraticBezierTo(60 + dx / 2, 40, 60 + dx, top),
            blade..color = c,
          );
        }
      case PlantForm.flowering:
        for (final (a, l, c) in [
          (-130.0, 30.0, s.leafDark),
          (-50.0, 30.0, s.leafDark),
          (-100.0, 34.0, s.leafMid),
          (-80.0, 34.0, s.leafMid),
        ]) {
          _leaf(canvas, soil, _rad(a), l, 12, c);
        }
        for (final o in const [
          Offset(46, 40),
          Offset(74, 38),
          Offset(60, 26),
        ]) {
          _bloom(canvas, o, 8, s, side: true);
        }
      case PlantForm.succulent:
        for (final (a, l, c) in [
          (-125.0, 38.0, s.leafMid),
          (-55.0, 38.0, s.leafMid),
          (-105.0, 54.0, s.leafDark),
          (-75.0, 54.0, s.leafDark),
          (-90.0, 60.0, s.leafLight),
        ]) {
          _leaf(canvas, soil, _rad(a), l, 7, c);
        }
      case PlantForm.trailing:
        final vine = Paint()
          ..color = s.leafDark
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke;
        canvas
          ..drawPath(
            Path()
              ..moveTo(50, 80)
              ..cubicTo(30, 84, 24, 96, 26, 108),
            vine,
          )
          ..drawPath(
            Path()
              ..moveTo(70, 80)
              ..cubicTo(90, 84, 96, 96, 94, 106),
            vine,
          );
        for (final o in const [
          Offset(28, 96),
          Offset(92, 96),
          Offset(48, 60),
          Offset(70, 58),
          Offset(60, 44),
        ]) {
          _heart(canvas, o, 16, s.leafMid);
        }
        _heart(canvas, const Offset(60, 66), 14, s.leafLight);
    }
  }

  void _paintPot(Canvas canvas) {
    switch (pot) {
      case PotStyle.terracotta:
        canvas
          ..drawPath(
            Path()
              ..moveTo(28, 80)
              ..lineTo(92, 80)
              ..lineTo(86, 110)
              ..quadraticBezierTo(60, 116, 34, 110)
              ..close(),
            Paint()
              ..shader = const LinearGradient(
                colors: [
                  Color(0xFFB9532A),
                  Color(0xFFD2703F),
                  Color(0xFFA4441D),
                ],
                stops: [0, .55, 1],
              ).createShader(const Rect.fromLTWH(28, 80, 64, 36)),
          )
          ..drawRRect(
            RRect.fromRectAndRadius(
              const Rect.fromLTWH(24, 74, 72, 10),
              const Radius.circular(3),
            ),
            Paint()..color = const Color(0xFFC2592B),
          );
      case PotStyle.growBag:
        canvas
          ..drawPath(
            Path()
              ..moveTo(28, 78)
              ..lineTo(92, 78)
              ..lineTo(87, 110)
              ..quadraticBezierTo(60, 116, 33, 110)
              ..close(),
            Paint()
              ..shader = const LinearGradient(
                colors: [
                  Color(0xFF262E2A),
                  Color(0xFF3A4540),
                  Color(0xFF1F2622),
                ],
                stops: [0, .5, 1],
              ).createShader(const Rect.fromLTWH(28, 78, 64, 38)),
          )
          ..drawOval(
            const Rect.fromLTWH(30, 74, 60, 8),
            Paint()..color = const Color(0xFF5A3E2B),
          );
    }
  }

  @override
  bool shouldRepaint(PlantSidePainter oldDelegate) =>
      oldDelegate.spec != spec || oldDelegate.pot != pot;
}
