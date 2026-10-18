// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'Terrace Garden';

  @override
  String get navToday => 'आज';

  @override
  String get navGarden => 'बगीचा';

  @override
  String get navSeasons => 'मौसम';

  @override
  String get navPlants => 'पौधे';

  @override
  String get navJournal => 'डायरी';

  @override
  String get settingsTitle => 'सेटिंग्स';

  @override
  String get settingsTooltip => 'सेटिंग्स';

  @override
  String get todayEmptyTitle => 'आपके बगीचे का दिन यहाँ से शुरू होता है';

  @override
  String get todayEmptyBody =>
      'बगीचा सेट करने और पौधे जोड़ने के बाद, आज के देखभाल के काम यहाँ दिखेंगे, साथ में पानी देने से पहले मिट्टी जाँचने का रिमाइंडर भी।';

  @override
  String get gardenEmptyTitle => 'अपनी छत या बालकनी की योजना बनाएँ';

  @override
  String get gardenEmptyBody =>
      'अपनी जगह के बारे में बताएँ, फ़ोटो जोड़ें और अपनी छत से जुड़ी हर बात एक ही जगह रखें।';

  @override
  String get journalEmptyTitle => 'अपने बगीचे को बढ़ते देखें';

  @override
  String get journalEmptyBody =>
      'बगीचा बढ़ने लगेगा तो प्रगति की फ़ोटो, नोट्स और फसल यहाँ जमा होंगे।';

  @override
  String get greetingMorning => 'सुप्रभात';

  @override
  String get greetingAfternoon => 'नमस्ते';

  @override
  String get greetingEvening => 'शुभ संध्या';

  @override
  String get todayCareHeading => 'आज की देखभाल';

  @override
  String get todayNoTasks => 'अभी कोई देखभाल का काम नहीं';

  @override
  String get tipWateringTitle => 'पानी देने से पहले';

  @override
  String get tipWateringBody =>
      'मिट्टी में लगभग 2–3 cm तक उँगली डालें। मिट्टी सूखी लगे तभी पानी दें, फिर धीरे-धीरे पानी दें जब तक गमले के नीचे से पानी न निकलने लगे।';

  @override
  String get tipWateringSource => 'स्रोत: Royal Horticultural Society';

  @override
  String get onbWelcomeTitle => 'अपनी छत के हिसाब से बगीचा उगाएँ';

  @override
  String get onbBenefitPlan =>
      'गमलों और ग्रो बैग के साथ अपनी असली जगह की सही माप में योजना बनाएँ';

  @override
  String get onbBenefitSeason => 'आपके शहर और मौसम के लिए पौधों के सुझाव';

  @override
  String get onbBenefitCare =>
      'देखभाल के रिमाइंडर जो पहले मिट्टी जाँचने को कहते हैं';

  @override
  String get onbStart => 'मेरा बगीचा सेट करें';

  @override
  String get onbExplore => 'पहले ऐप देखें';

  @override
  String onbStepOf(int step, int total) {
    return '$total में से चरण $step';
  }

  @override
  String get onbSpaceTitle => 'अपनी जगह के बारे में बताएँ';

  @override
  String get onbLightTitle => 'धूप और जगह';

  @override
  String get onbOptionalHint =>
      'यहाँ सब कुछ वैकल्पिक है। अगर पता न हो तो \"पक्का नहीं\" चुनें।';

  @override
  String get onbGoalsTitle => 'आप क्या उगाना चाहेंगे?';

  @override
  String get onbReadyTitle => 'आपका बगीचा बनाने के लिए तैयार';

  @override
  String get onbReadyBody => 'आप कभी भी फ़ोटो, माप और पौधे जोड़ सकते हैं।';

  @override
  String get onbCreateGarden => 'मेरा बगीचा बनाएँ';

  @override
  String get actionContinue => 'आगे बढ़ें';

  @override
  String get actionSkip => 'छोड़ें';

  @override
  String get actionSave => 'सेव करें';

  @override
  String get actionEdit => 'बदलें';

  @override
  String get actionAdd => 'जोड़ें';

  @override
  String get seeAll => 'सभी देखें';

  @override
  String get notSure => 'पक्का नहीं';

  @override
  String get notSet => 'सेट नहीं';

  @override
  String get notSetAdd => 'सेट नहीं · जोड़ें';

  @override
  String get fieldGardenName => 'बगीचे का नाम';

  @override
  String get defaultGardenName => 'मेरी छत';

  @override
  String get fieldSpaceType => 'जगह का प्रकार';

  @override
  String get spaceTerrace => 'छत';

  @override
  String get spaceBalcony => 'बालकनी';

  @override
  String get spaceRooftop => 'रूफ़टॉप';

  @override
  String get spaceWindowsill => 'खिड़की की पट्टी';

  @override
  String get spaceCourtyard => 'आँगन';

  @override
  String get spaceOther => 'अन्य';

  @override
  String get fieldDimensions => 'आकार (वैकल्पिक)';

  @override
  String get fieldDimensionsHelp =>
      'इस्तेमाल लायक फ़र्श का क्षेत्रफल नापें। आप इसे बाद में भी जोड़ सकते हैं।';

  @override
  String get fieldLength => 'लंबाई';

  @override
  String get fieldWidth => 'चौड़ाई';

  @override
  String get unitMetresShort => 'm';

  @override
  String get unitFeetShort => 'ft';

  @override
  String get fieldCity => 'शहर';

  @override
  String get cityChoose => 'अपना शहर चुनें';

  @override
  String get citySearchHint => 'शहर या राज्य खोजें';

  @override
  String get cityNoResults =>
      'कोई मिलता-जुलता शहर नहीं मिला। आप इसे खाली छोड़ सकते हैं।';

  @override
  String get cityClear => 'कोई शहर नहीं';

  @override
  String get cityNoRegion =>
      'इस शहर के लिए बुवाई कैलेंडर अभी उपलब्ध नहीं है। बाकी सब सामान्य रूप से काम करता है।';

  @override
  String get fieldSun => 'रोज़ सीधी धूप';

  @override
  String get sunLessThan3 => '3 घंटे से कम';

  @override
  String get sun3To6 => '3–6 घंटे';

  @override
  String get sunMoreThan6 => '6+ घंटे';

  @override
  String get fieldFacing => 'इसका मुँह किस दिशा में है?';

  @override
  String get facingNorth => 'उत्तर';

  @override
  String get facingNorthEast => 'उत्तर-पूर्व';

  @override
  String get facingEast => 'पूर्व';

  @override
  String get facingSouthEast => 'दक्षिण-पूर्व';

  @override
  String get facingSouth => 'दक्षिण';

  @override
  String get facingSouthWest => 'दक्षिण-पश्चिम';

  @override
  String get facingWest => 'पश्चिम';

  @override
  String get facingNorthWest => 'उत्तर-पश्चिम';

  @override
  String get fieldWind => 'हवा';

  @override
  String get windSheltered => 'हवा से बचाव';

  @override
  String get windModerate => 'थोड़ी हवा';

  @override
  String get windExposed => 'बहुत तेज़ हवा';

  @override
  String get fieldWater => 'पानी का स्रोत';

  @override
  String get waterTapNearby => 'पास में नल';

  @override
  String get waterCarried => 'बाल्टी से लाते हैं';

  @override
  String get fieldGoals => 'लक्ष्य';

  @override
  String get goalVegetables => 'सब्ज़ियाँ';

  @override
  String get goalHerbs => 'जड़ी-बूटियाँ';

  @override
  String get goalFlowers => 'फूल';

  @override
  String get goalOrnamental => 'सजावटी पौधे';

  @override
  String get goalFruit => 'फल';

  @override
  String get fieldStyle => 'बगीचे की शैली (वैकल्पिक)';

  @override
  String get styleModernMinimalist => 'आधुनिक और सादा';

  @override
  String get styleTropical => 'ट्रॉपिकल';

  @override
  String get styleEdibleKitchen => 'किचन गार्डन';

  @override
  String get styleIndianTerraceVegetable => 'भारतीय छत पर सब्ज़ी बगीचा';

  @override
  String get styleHerbGarden => 'जड़ी-बूटी बगीचा';

  @override
  String get styleFlowerGarden => 'फूलों का बगीचा';

  @override
  String get styleLowMaintenance => 'कम देखभाल वाला';

  @override
  String get styleVerticalSpaceSaving => 'वर्टिकल और जगह बचाने वाला';

  @override
  String get fieldExperience => 'बागवानी का अनुभव';

  @override
  String get experienceBeginner => 'नया';

  @override
  String get experienceIntermediate => 'थोड़ा अनुभव';

  @override
  String get experienceExperienced => 'अनुभवी';

  @override
  String get fieldWeeklyTime => 'हर हफ़्ते का समय';

  @override
  String get weeklyUnderOneHour => '1 घंटे से कम';

  @override
  String get weeklyOneToThree => '1–3 घंटे';

  @override
  String get weeklyMoreThanThree => '3 घंटे से ज़्यादा';

  @override
  String get fieldBudget => 'बजट';

  @override
  String get budgetLow => 'कम';

  @override
  String get budgetMedium => 'मध्यम';

  @override
  String get budgetHigh => 'ज़्यादा';

  @override
  String get fieldNotes => 'नोट्स';

  @override
  String get fieldNotesHint => 'इस जगह के बारे में याद रखने लायक कोई भी बात';

  @override
  String get errNameRequired => 'अपने बगीचे को एक नाम दें';

  @override
  String get errNameTooLong => '60 या उससे कम अक्षर रखें';

  @override
  String get errDimension => '0 से ज़्यादा और 200 m (656 ft) तक का आकार डालें';

  @override
  String get regionNorthIndia => 'उत्तर भारत';

  @override
  String get regionSouthIndia => 'दक्षिण भारत';

  @override
  String get regionTelangana => 'तेलंगाना';

  @override
  String get regionTamilNadu => 'तमिलनाडु';

  @override
  String get regionKerala => 'केरल';

  @override
  String get gardensTitle => 'आपके बगीचे';

  @override
  String get gardenCreateAction => 'अपना बगीचा बनाएँ';

  @override
  String get gardenNew => 'नया बगीचा';

  @override
  String get gardenEditTitle => 'बगीचा बदलें';

  @override
  String get gardenSectionSpace => 'आपकी जगह';

  @override
  String get gardenSectionLight => 'धूप और मौसम';

  @override
  String get gardenSectionGoals => 'लक्ष्य और स्टाइल';

  @override
  String get gardenSize => 'आकार';

  @override
  String get gardenArea => 'क्षेत्रफल';

  @override
  String gardenSizeValue(String length, String width) {
    return '$length × $width';
  }

  @override
  String get gardenLocation => 'जगह';

  @override
  String get gardenRegion => 'उगाने का क्षेत्र';

  @override
  String get gardenPhotos => 'फ़ोटो';

  @override
  String get gardenPhotosEmpty =>
      'अपनी जगह की कुछ अलग-अलग कोणों से फ़ोटो जोड़ें। फ़ोटो सिर्फ़ आपके रिकॉर्ड के लिए हैं; माप हमेशा वही माने जाते हैं जो आप भरते हैं।';

  @override
  String get gardenDelete => 'बगीचा हटाएँ';

  @override
  String gardenDeleteTitle(String name) {
    return '$name हटाएँ?';
  }

  @override
  String get gardenDeleteBody =>
      'इससे बगीचा, उसकी फ़ोटो और उसके लिए दर्ज सब कुछ हट जाएगा। इसे वापस नहीं लाया जा सकता।';

  @override
  String get gardenDeleted => 'बगीचा हटा दिया गया';

  @override
  String get gardenSaved => 'बगीचा सेव हो गया';

  @override
  String get unsavedTitle => 'बदलाव छोड़ दें?';

  @override
  String get unsavedBody => 'इस बगीचे में आपके बदलाव अभी सेव नहीं हुए हैं।';

  @override
  String get unsavedDiscard => 'छोड़ दें';

  @override
  String get moreActions => 'और विकल्प';

  @override
  String get photosTitle => 'फ़ोटो';

  @override
  String get photoAdd => 'फ़ोटो जोड़ें';

  @override
  String get photoTake => 'फ़ोटो खींचें';

  @override
  String get photoChoose => 'गैलरी से चुनें';

  @override
  String get photoCaption => 'कैप्शन';

  @override
  String get photoCaptionHint => 'जैसे, उत्तर वाले कोने से नज़ारा';

  @override
  String get photoSetCover => 'कवर बनाएँ';

  @override
  String get photoIsCover => 'कवर फ़ोटो';

  @override
  String get photoReplace => 'फ़ोटो बदलें';

  @override
  String get photoDelete => 'फ़ोटो हटाएँ';

  @override
  String get photoDeleteBody => 'यह फ़ोटो आपके बगीचे से हटा दी जाएगी।';

  @override
  String get photoCoverUpdated => 'कवर फ़ोटो बदल गई';

  @override
  String get photoMissing => 'यह फ़ोटो अब आपके डिवाइस पर नहीं है';

  @override
  String get photoPermission =>
      'अपने फ़ोन की सेटिंग्स में Terrace Garden को कैमरा या फ़ोटो की अनुमति दें, या इसकी जगह अपनी गैलरी से फ़ोटो चुनें।';

  @override
  String get photoAdding => 'फ़ोटो जोड़ी जा रही है…';

  @override
  String photoCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count फ़ोटो',
      one: '1 फ़ोटो',
      zero: 'कोई फ़ोटो नहीं',
    );
    return '$_temp0';
  }

  @override
  String get checklistTitle => 'छत की देखभाल की चेकलिस्ट';

  @override
  String get checklistSubtitle =>
      'वज़न, पानी की निकासी, वॉटरप्रूफ़िंग, मानसून और गर्मी';

  @override
  String get checklistIntro =>
      'छत और बालकनी के लिए काम की बातें। यह सामान्य सलाह है, आपकी इमारत की ढाँचागत (स्ट्रक्चरल) जाँच नहीं।';

  @override
  String get checkLoadTitle => 'जाँचें कि छत वज़न सह सकती है';

  @override
  String get checkLoadBody =>
      'भारतीय लोडिंग कोड के अनुसार, जिस सपाट छत पर चला जा सकता है, वह लोगों और सामान के लिए लगभग 150 kg प्रति वर्ग मीटर के हिसाब से बनाई जाती है। गीली मिट्टी, गमले और जमा किया पानी जल्दी ही बहुत वज़न बढ़ा देते हैं। ऊँची क्यारियाँ, बड़े प्लांटर या पानी की टंकी लगाने से पहले किसी स्ट्रक्चरल इंजीनियर से सलाह लें।';

  @override
  String get checkLoadSources =>
      'स्रोत: IS 875 (Part 2), Bureau of Indian Standards; ICAR Indian Horticulture';

  @override
  String get checkWallsTitle => 'भारी कंटेनर दीवारों के ऊपर रखें';

  @override
  String get checkWallsBody =>
      'ग्रो बैग और भारी गमले वहाँ रखें जहाँ नीचे दीवार हो, खुली छत के बीच में नहीं।';

  @override
  String get checkWallsSources => 'स्रोत: Kerala Agricultural University';

  @override
  String get checkDrainTitle => 'पानी निकलता रहे';

  @override
  String get checkDrainBody =>
      'हर कंटेनर में पानी निकलने के छेद होने चाहिए। गमलों को ईंटों या गमला-स्टैंड पर ऊँचा रखें ताकि पानी बह जाए, पानी देने के बाद नीचे की प्लेटें खाली करें, और छत की नालियाँ साफ़ रखें।';

  @override
  String get checkDrainSources =>
      'स्रोत: University of Maryland Extension; Kerala Agricultural University';

  @override
  String get checkWaterproofTitle => 'वॉटरप्रूफ़िंग को बचाएँ';

  @override
  String get checkWaterproofBody =>
      'पौधे लगाने से पहले पक्का करें कि छत पर ऐसी वॉटरप्रूफ़ परत हो जो जड़ों और सड़न से बची रहे। हर फसल के बाद बैग और ईंटों को थोड़ा खिसका दें ताकि छत का कोई हिस्सा हमेशा गीला न रहे।';

  @override
  String get checkWaterproofSources =>
      'स्रोत: ICAR Indian Horticulture; Kerala Agricultural University';

  @override
  String get checkMonsoonTitle => 'मानसून की तैयारी करें';

  @override
  String get checkMonsoonBody =>
      'ज़्यादा पानी देना कंटेनर के पौधे खराब होने की सबसे आम वजह है। बहुत बारिश वाले दिनों में गमलों को ढकी जगह पर रखें, नीचे की प्लेटें हटा दें, और बारिश के बाद भी पानी देने से पहले मिट्टी जाँचें।';

  @override
  String get checkMonsoonSources => 'स्रोत: Royal Horticultural Society';

  @override
  String get checkHeatTitle => 'पौधों को गर्मी से बचाएँ';

  @override
  String get checkHeatBody =>
      'छोटे, गहरे रंग के और धातु के गमले जल्दी गरम होकर सूख जाते हैं, और दक्षिण व पश्चिम की ओर वाली जगहें सबसे जल्दी सूखती हैं। गमलों को पास-पास रखें, मिट्टी पर मल्च बिछाएँ, और सुबह जल्दी पानी दें।';

  @override
  String get checkHeatSources =>
      'स्रोत: Royal Horticultural Society; University of Maryland Extension';

  @override
  String get designOpen => 'अपना लेआउट बनाएँ';

  @override
  String get designOpenSubtitle =>
      'गमले, ग्रो बैग और क्यारियाँ सही नाप में सजाएँ';

  @override
  String layoutObjectCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'आपके लेआउट में $count चीज़ें',
      one: 'आपके लेआउट में 1 चीज़',
    );
    return '$_temp0';
  }

  @override
  String get designerTitle => 'लेआउट';

  @override
  String get designerAdd => 'जोड़ें';

  @override
  String get designerUndo => 'पहले जैसा करें';

  @override
  String get designerRedo => 'फिर से करें';

  @override
  String get designerObjects => 'चीज़ें';

  @override
  String get designerSummary => 'जगह का सार';

  @override
  String get designerSnap => 'स्नैप';

  @override
  String get designerFit => 'स्क्रीन में फ़िट करें';

  @override
  String get designerSaved => 'सेव हो गया';

  @override
  String get designerSaving => 'सेव हो रहा है…';

  @override
  String get designerNotSaved => 'अभी सेव नहीं हुआ';

  @override
  String get designerSaveFailed =>
      'सेव नहीं हो सका। आपके बदलाव रखे गए हैं और फिर से सेव किए जाएँगे।';

  @override
  String get designerEmptyHint =>
      'गमले, ग्रो बैग, क्यारियाँ और बहुत कुछ रखने के लिए जोड़ें पर टैप करें।';

  @override
  String get designerNeedsSizeTitle => 'अपने बगीचे का आकार जोड़ें';

  @override
  String get designerNeedsSizeBody =>
      'लेआउट असली माप पर चलता है, इसलिए इसे इस्तेमाल होने वाले फ़र्श की लंबाई और चौड़ाई चाहिए।';

  @override
  String get designerStart => 'डिज़ाइन शुरू करें';

  @override
  String designerProblems(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count समस्याएँ',
      one: '1 समस्या',
    );
    return '$_temp0';
  }

  @override
  String designerCanvasLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count चीज़ें',
      one: '1 चीज़',
      zero: 'कोई चीज़ नहीं',
    );
    return 'बगीचे का लेआउट, $_temp0। इन्हें देखने और बदलने के लिए चीज़ों की सूची इस्तेमाल करें।';
  }

  @override
  String get issueOutOfBounds => 'बगीचे से बाहर';

  @override
  String get issueOverlap => 'दूसरी चीज़ पर चढ़ा है';

  @override
  String get issueOnPath => 'रास्ते पर रखा है';

  @override
  String get paletteContainers => 'कंटेनर';

  @override
  String get paletteStructures => 'ढाँचे';

  @override
  String get paletteOther => 'अन्य';

  @override
  String get kindRoundPot => 'गोल गमला';

  @override
  String get kindRectPlanter => 'प्लांटर बॉक्स';

  @override
  String get kindGrowBag => 'ग्रो बैग';

  @override
  String get kindRaisedBed => 'ऊँची क्यारी';

  @override
  String get kindVerticalPlanter => 'वर्टिकल प्लांटर';

  @override
  String get kindWall => 'दीवार';

  @override
  String get kindRailing => 'रेलिंग';

  @override
  String get kindPath => 'रास्ता';

  @override
  String get kindWaterPoint => 'पानी का नल';

  @override
  String get inspectorTitle => 'चीज़ बदलें';

  @override
  String get fieldDiameter => 'व्यास';

  @override
  String get fieldDepth => 'मिट्टी की गहराई';

  @override
  String get fieldRotation => 'घुमाव';

  @override
  String get fieldLabel => 'लेबल (वैकल्पिक)';

  @override
  String get fieldLabelHint => 'जैसे, टमाटर';

  @override
  String degreesValue(int degrees) {
    return '$degrees°';
  }

  @override
  String get actionRotate => '90° घुमाएँ';

  @override
  String get actionDuplicate => 'कॉपी बनाएँ';

  @override
  String get actionDone => 'हो गया';

  @override
  String get unitCmShort => 'cm';

  @override
  String get unitInShort => 'in';

  @override
  String get objectsEmpty => 'अभी कोई चीज़ नहीं';

  @override
  String get summaryGardenArea => 'बगीचे का क्षेत्रफल';

  @override
  String get summaryContainerArea => 'कंटेनरों से घिरा';

  @override
  String summaryContainerShare(int percent) {
    return 'फ़र्श का $percent%';
  }

  @override
  String get summaryWalkway => 'रास्ते';

  @override
  String get summarySoil => 'ज़रूरी मिट्टी';

  @override
  String get summaryCounts => 'चीज़ें';

  @override
  String get summaryNote =>
      'मिट्टी की मात्रा = हर कंटेनर के तले का क्षेत्रफल × आपकी डाली गई मिट्टी की गहराई। ग्रो बैग को लगभग तीन-चौथाई तक भरें (Kerala Agricultural University) और छत की चेकलिस्ट में वज़न की सलाह ज़रूर देखें।';

  @override
  String get settingsAppearance => 'दिखावट';

  @override
  String get settingsTheme => 'थीम';

  @override
  String get themeSystem => 'सिस्टम';

  @override
  String get themeLight => 'लाइट';

  @override
  String get themeDark => 'डार्क';

  @override
  String get settingsUnits => 'माप की इकाइयाँ';

  @override
  String get unitsMetric => 'मीट्रिक (cm, m)';

  @override
  String get unitsImperial => 'इंपीरियल (in, ft)';

  @override
  String get settingsAbout => 'ऐप के बारे में';

  @override
  String get settingsLicences => 'ओपन-सोर्स लाइसेंस';

  @override
  String get settingsLicencesSubtitle =>
      'इस ऐप में इस्तेमाल हुए फ़ॉन्ट और सॉफ़्टवेयर';

  @override
  String get imageCreditsTitle => 'फ़ोटो क्रेडिट';

  @override
  String get imageCreditsSubtitle =>
      'इस ऐप की फ़ोटो के फ़ोटोग्राफ़र और लाइसेंस';

  @override
  String imageCreditsBy(String author) {
    return 'फ़ोटो: $author';
  }

  @override
  String get errorGenericTitle => 'कुछ गड़बड़ हो गई';

  @override
  String get errorGenericBody =>
      'कृपया फिर से कोशिश करें। अगर ऐसा बार-बार हो, तो ऐप को रीस्टार्ट करें।';

  @override
  String get errorNotFound =>
      'यह आइटम नहीं मिला। हो सकता है इसे हटा दिया गया हो।';

  @override
  String get errorStorage => 'इस डिवाइस पर आपका डेटा सेव या पढ़ा नहीं जा सका।';

  @override
  String get errorPermission => 'आगे बढ़ने के लिए अनुमति चाहिए।';

  @override
  String get actionRetry => 'फिर से कोशिश करें';

  @override
  String get actionCancel => 'रद्द करें';

  @override
  String get actionConfirm => 'पक्का करें';

  @override
  String get actionDelete => 'हटाएँ';

  @override
  String get actionOpenSettings => 'सेटिंग्स खोलें';

  @override
  String get loadingLabel => 'लोड हो रहा है';

  @override
  String get plantsTitle => 'पौधे';

  @override
  String get plantsSearchHint => 'खोजें, जैसे भिंडी या तुलसी';

  @override
  String get plantsFilterAll => 'सभी';

  @override
  String get settingsLanguage => 'भाषा';

  @override
  String get languageSystem => 'फ़ोन जैसी';

  @override
  String get plantsFilterPetFriendly => 'पालतू-सुरक्षित';

  @override
  String get plantsPetFriendlyNote =>
      'वे पौधे जिन्हें एक स्रोत (ASPCA) कुत्तों और बिल्लियों के लिए ज़हरीला नहीं बताता। जिन पौधों की जाँच किसी ने नहीं की, उन्हें सुरक्षित मानकर नहीं दिखाया गया है। अगर पालतू जानवर कोई पौधा खा ले, तो पशु-चिकित्सक को फ़ोन करें।';

  @override
  String get categoryVegetable => 'सब्ज़ियाँ';

  @override
  String get categoryLeafyGreen => 'पत्तेदार सब्ज़ियाँ';

  @override
  String get categoryHerb => 'जड़ी-बूटियाँ';

  @override
  String get categoryClimber => 'बेलें';

  @override
  String get categoryFlower => 'फूल';

  @override
  String get categoryOrnamental => 'सजावटी पौधे';

  @override
  String get plantsNoResults => 'आपकी खोज से कोई पौधा नहीं मिला';

  @override
  String get plantsNoResultsBody =>
      'आम नाम, स्थानीय नाम या कोई दूसरी श्रेणी आज़माएँ।';

  @override
  String get plantsCatalogueNote =>
      'हर जानकारी अपने स्रोत से जुड़ी है। जो दर्ज नहीं है, उसे \'दर्ज नहीं\' ही दिखाया जाता है, कभी अंदाज़ा नहीं लगाया जाता।';

  @override
  String plantsIdeasFor(String garden) {
    return '$garden के लिए सुझाव';
  }

  @override
  String get plantsIdeasSubtitle =>
      'आपकी जगह, मौसम और कंटेनरों के हिसाब से क्रम में';

  @override
  String get lifecycleAnnual => 'एक-वर्षीय';

  @override
  String get lifecyclePerennial => 'बारहमासी';

  @override
  String get dataStatusVerified => 'स्रोतों से पुष्ट';

  @override
  String get dataStatusPartial => 'आंशिक रूप से दर्ज';

  @override
  String get dataStatusUnverified => 'कम स्रोत-आधारित जानकारी';

  @override
  String get notDocumented => 'दर्ज नहीं';

  @override
  String get plantSectionSun => 'धूप';

  @override
  String get sunFull => 'पूरी धूप';

  @override
  String sunFullHours(int hours) {
    return 'पूरी धूप, दिन में कम से कम $hours घंटे';
  }

  @override
  String get sunPartial => 'आंशिक छाया सह लेता है';

  @override
  String sunPartialHours(int hours) {
    return 'धूप या आंशिक छाया, कम से कम $hours घंटे सीधी धूप';
  }

  @override
  String get sunIndirect => 'उजली अप्रत्यक्ष रोशनी';

  @override
  String get plantSectionContainer => 'कंटेनर';

  @override
  String get containerMinSoil => 'कम से कम मिट्टी';

  @override
  String get containerRecommendedSoil => 'सुझाई गई मिट्टी';

  @override
  String get containerMinDepth => 'कम से कम गहराई';

  @override
  String get containerRecommendedDepth => 'सुझाई गई गहराई';

  @override
  String get containerPlantsPer => 'सबसे छोटे सही कंटेनर में पौधे';

  @override
  String get evidenceVerified => 'स्रोत से';

  @override
  String get evidenceProxy => 'मिलती-जुलती फसल के आधार पर';

  @override
  String get evidenceUnverified => 'आकार दर्ज नहीं';

  @override
  String get plantSectionHarvest => 'पहली फसल का समय';

  @override
  String harvestDays(int min, int max) {
    return '$min–$max दिन';
  }

  @override
  String harvestDaysSingle(int days) {
    return 'लगभग $days दिन';
  }

  @override
  String get plantSectionSowing => 'बुवाई या पौधा लगाने के महीने';

  @override
  String get sowingYearRound => 'पूरे साल';

  @override
  String sowingFallback(String state, String region) {
    return 'इस पौधे के लिए $state की तालिका नहीं है; $region के महीने दिखाए जा रहे हैं।';
  }

  @override
  String get sowingNone =>
      'इस पौधे के लिए बुवाई का कोई स्रोत-आधारित कैलेंडर नहीं है।';

  @override
  String get plantSectionPropagation => 'कैसे शुरू करें';

  @override
  String get propagationTransplant => 'पहले पौध तैयार करें, फिर रोपाई करें';

  @override
  String get propagationDirect => 'सीधे कंटेनर में बोएँ';

  @override
  String get propagationSeed => 'बीज से';

  @override
  String get propagationDivision => 'गुच्छा बाँटकर';

  @override
  String get propagationCutting => 'कलम से';

  @override
  String propagationNursery(int min, int max) {
    return 'नर्सरी ट्रे में $min–$max दिन रखने के बाद रोपाई करें';
  }

  @override
  String get plantSectionCare => 'देखभाल के नोट्स';

  @override
  String get plantSectionPets => 'पालतू जानवर';

  @override
  String get petToxic => 'पालतू जानवरों के लिए ज़हरीला';

  @override
  String get petNonToxic => 'पालतू जानवरों के लिए ज़हरीला नहीं बताया गया';

  @override
  String get petNotAssessed => 'जाँच नहीं हुई';

  @override
  String get petScopeNote =>
      'पालतू जानवरों की जानकारी ASPCA से है और यह बच्चों पर लागू नहीं होती। अगर कोई व्यक्ति या पालतू जानवर पौधा खा ले, तो डॉक्टर या पशु डॉक्टर से संपर्क करें।';

  @override
  String get plantSectionSources => 'स्रोत';

  @override
  String get plantSourcesNote =>
      'यह जानकारी इन प्रकाशनों से संक्षेप में ली गई है।';

  @override
  String get plantAddToGarden => 'बगीचे में जोड़ें';

  @override
  String get plantNotFound => 'यह पौधा अब कैटलॉग में नहीं है।';

  @override
  String get recTitle => 'पौधों के सुझाव';

  @override
  String recSubtitle(String garden, String month) {
    return '$month में $garden के लिए';
  }

  @override
  String get recDisclaimer =>
      'आपके बगीचे की प्रोफ़ाइल और स्रोत-आधारित पौधों की जानकारी से क्रम दिया गया है। यह बस एक शुरुआत है, सफलता की गारंटी नहीं।';

  @override
  String get recCompleteProfile =>
      'बेहतर सुझावों के लिए धूप के घंटे और अपना शहर जोड़ें।';

  @override
  String get recGroupGoodNow => 'अभी के अच्छे विकल्प';

  @override
  String get recGroupLater => 'सही हैं, बाद में बोएँ';

  @override
  String get recGroupNotSuited => 'यहाँ के लिए सही नहीं';

  @override
  String get recSunMatches => 'रोशनी आपकी जगह के हिसाब से सही है';

  @override
  String get recSunNeedsMore =>
      '6+ घंटे धूप चाहिए; आपकी जगह को 3–6 घंटे मिलती है';

  @override
  String get recSunTooShady => 'आपकी जगह को 3 घंटे से कम धूप मिलती है';

  @override
  String get recSunPrefersIndirect =>
      'कड़ी धूप के बजाय उजली अप्रत्यक्ष रोशनी पसंद है';

  @override
  String get recSunGardenUnknown => 'रोशनी जाँचने के लिए धूप के घंटे जोड़ें';

  @override
  String get recSunSpeciesUnknown => 'धूप की ज़रूरत दर्ज नहीं';

  @override
  String get recSowNow => 'अभी बोएँ';

  @override
  String recSowSoon(String month) {
    return '$month से बोएँ';
  }

  @override
  String recSowLater(String month) {
    return 'अगली बुवाई: $month';
  }

  @override
  String get recNoRegion =>
      'आपके शहर के लिए अभी बुवाई का कोई स्रोत-आधारित कैलेंडर नहीं है';

  @override
  String get recNoSeasonData => 'आपके क्षेत्र के लिए बुवाई की जानकारी नहीं है';

  @override
  String recContainerFits(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'आपके $count कंटेनर काफ़ी बड़े हैं',
      one: 'आपका 1 कंटेनर काफ़ी बड़ा है',
    );
    return '$_temp0';
  }

  @override
  String get recContainerTooSmall =>
      'अभी आपका कोई भी कंटेनर काफ़ी बड़ा नहीं है';

  @override
  String get recNoContainers => 'आकार जाँचने के लिए डिज़ाइनर में कंटेनर जोड़ें';

  @override
  String get recContainerUnknown => 'कंटेनर का आकार दर्ज नहीं';

  @override
  String get recGoalMatch => 'आपके लक्ष्यों से मेल खाता है';

  @override
  String get caveatContainerProxy => 'कंटेनर का आकार मिलती-जुलती फसल से';

  @override
  String get caveatRegionFallback =>
      'बड़े क्षेत्र की बुवाई जानकारी इस्तेमाल हुई';

  @override
  String get caveatPetToxic => 'पालतू जानवरों के लिए ज़हरीला';

  @override
  String get caveatIncomplete => 'कुछ जानकारी दर्ज नहीं';

  @override
  String get recShortlistAdd => 'पसंदीदा सूची में सेव करें';

  @override
  String get recShortlistRemove => 'पसंदीदा सूची से हटाएँ';

  @override
  String get recShortlistOnly => 'पसंदीदा';

  @override
  String get recShortlistEmpty =>
      'अभी पसंदीदा सूची में कुछ नहीं है। किसी भी सुझाव को सेव करने के लिए उस पर बुकमार्क दबाएँ।';

  @override
  String plantingAddTitle(String plant) {
    return '$plant जोड़ें';
  }

  @override
  String plantingEditTitle(String plant) {
    return '$plant बदलें';
  }

  @override
  String get plantingGarden => 'बगीचा';

  @override
  String get plantingContainer => 'कंटेनर';

  @override
  String get plantingNotPlaced => 'अभी रखा नहीं गया';

  @override
  String get plantingQuantity => 'पौधों की संख्या';

  @override
  String get plantingPlantedOn => 'लगाने की तारीख';

  @override
  String get plantingStartedFrom => 'किससे शुरू किया';

  @override
  String get startSeed => 'बीज';

  @override
  String get startSeedling => 'पौध';

  @override
  String get startCutting => 'कलम';

  @override
  String get startPlant => 'बड़ा पौधा';

  @override
  String get plantingNotes => 'नोट्स (वैकल्पिक)';

  @override
  String get plantingSave => 'पौधा जोड़ें';

  @override
  String get plantingUpdate => 'बदलाव सेव करें';

  @override
  String plantingAdded(String plant, String garden) {
    return '$plant को $garden में जोड़ा गया';
  }

  @override
  String get plantingNoGardens => 'पहले एक बगीचा बनाएँ, फिर उसमें पौधे जोड़ें।';

  @override
  String plantingIssueLowVolume(String actual, String required) {
    return 'इस कंटेनर में लगभग $actual आता है; इस पौधे को कम से कम $required चाहिए।';
  }

  @override
  String plantingIssueShallow(String actual, String required) {
    return 'यह कंटेनर $actual गहरा है; इस पौधे को कम से कम $required गहराई चाहिए।';
  }

  @override
  String plantingIssueCrowded(int capacity) {
    return 'मोटा अंदाज़ा: इस कंटेनर में ऐसे लगभग $capacity पौधे आ सकते हैं (स्रोत में दिए प्रति-कंटेनर आँकड़े से निकाला गया)।';
  }

  @override
  String plantingIssueShared(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'इस कंटेनर में पहले से $count और पौधे लगे हैं।',
      one: 'इस कंटेनर में पहले से 1 और पौधा लगा है।',
    );
    return '$_temp0';
  }

  @override
  String get plantingIssueNoDepth =>
      'साइज़ जाँचने के लिए डिज़ाइनर में इस कंटेनर की मिट्टी की गहराई सेट करें।';

  @override
  String get quantityDecrease => 'कम';

  @override
  String get quantityIncrease => 'ज़्यादा';

  @override
  String get myPlantsTitle => 'मेरे पौधे';

  @override
  String get myPlantsEmpty =>
      'अभी कोई पौधा नहीं। इस जगह के लिए सही सुझाव देखें।';

  @override
  String plantingSummary(int count, String date) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count पौधे',
      one: '1 पौधा',
    );
    return '$_temp0 · $date से';
  }

  @override
  String get plantingContainerMissing => 'इसका कंटेनर लेआउट से हटा दिया गया';

  @override
  String get plantingRemove => 'पौधा हटाएँ';

  @override
  String plantingRemoveTitle(String plant) {
    return '$plant हटाएँ?';
  }

  @override
  String get plantingRemoveBody => 'इससे यह पौधा इस बगीचे से हट जाएगा।';

  @override
  String get plantingRemoved => 'पौधा हटाया गया';

  @override
  String get plantingUnknownSpecies => 'अनजान पौधा';

  @override
  String get digestTitle => 'आज आपका बगीचा';

  @override
  String digestBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'देखभाल के $count काम बाकी हैं। पानी देने से पहले मिट्टी जाँचें।',
      one: 'देखभाल का 1 काम बाकी है। पानी देने से पहले मिट्टी जाँचें।',
    );
    return '$_temp0';
  }

  @override
  String get taskCheckSoil => 'मिट्टी जाँचें';

  @override
  String get taskInspectPests => 'कीट देखें';

  @override
  String get taskFeed => 'खाद दें';

  @override
  String get taskTransplant => 'पौध की रोपाई करें';

  @override
  String get taskHarvest => 'तुड़ाई शुरू हो सकती है';

  @override
  String get taskPrune => 'छँटाई करें';

  @override
  String get guideCheckSoil =>
      'मिट्टी में उंगली 2–3 cm तक डालें, या गमले की लगभग एक-तिहाई गहराई तक। सूखी लगे तभी पानी दें, फिर धीरे-धीरे तब तक पानी दें जब तक नीचे से निकलने न लगे। सुबह जल्दी देना सबसे अच्छा है; पत्तों पर नहीं, जड़ के पास पानी दें।';

  @override
  String get guideCheckSoilDry =>
      'इस पौधे की मिट्टी को दो बार पानी देने के बीच सूखने देना चाहिए (सकुलेंट में पूरी तरह)। मिट्टी जाँचें और सूखी होने पर ही पानी दें; ज़्यादा पानी देना सबसे बड़ा खतरा है।';

  @override
  String get guideCheckSoilMoist =>
      'इस पौधे की मिट्टी को सूखने न दें। मिट्टी जाँचें और सूखने लगे तो पानी दें।';

  @override
  String get guideInspectPests =>
      'पत्तों के नीचे और नई बढ़त पर एफिड (माहू), माइट और सफ़ेद मक्खी देखें; एफिड हवा आने वाली तरफ़ जमा होते हैं। दिन में जल्दी पानी की तेज़ धार से कीटों को धो दें। हर तरह के कीड़े मारने वाले स्प्रे से बचें: इनसे माइट और बढ़ सकते हैं।';

  @override
  String get guideFeed =>
      'पौधा बढ़ते समय हर 2–4 हफ़्ते में, नम मिट्टी पर, प्रोडक्ट के लेबल पर लिखी मात्रा में खाद दें। अगर पौधे लंबे और पतले होने लगें या पत्तों के किनारे जले हुए दिखें, तो खाद कम दें।';

  @override
  String get guideTransplant =>
      'ट्रे में उगाई गई पौध को बुवाई के लगभग 25–30 दिन बाद उसके आखिरी कंटेनर में लगाया जाता है; ज़्यादातर सब्ज़ियाँ 2–3 असली पत्ते आने पर तैयार होती हैं।';

  @override
  String get guideHarvest =>
      'स्रोत में दी गई समय-सीमा के हिसाब से यह फसल अब तुड़ाई के लिए तैयार हो सकती है। समय किस्म और मौसम के साथ बदलता है और बुवाई से गिना जाता है, इसलिए पौध से शुरू किए गए पौधे जल्दी तैयार हो सकते हैं।';

  @override
  String get guidePrune =>
      'तमिलनाडु में मोगरा (Jasminum sambac) को नवंबर के आखिरी हफ़्ते में लगभग 50 cm तक काटा जाता है।';

  @override
  String guideSources(String publishers) {
    return 'स्रोत: $publishers';
  }

  @override
  String get todayOverdue => 'बकाया';

  @override
  String get todayDueToday => 'आज';

  @override
  String get todayUpcoming => 'आगे के काम';

  @override
  String get todayDoneToday => 'आज पूरे हुए';

  @override
  String get todayAllDone => 'आज के सारे काम हो गए';

  @override
  String get todayAllDoneBody => 'आज और कुछ बाकी नहीं है। आगे के काम नीचे हैं।';

  @override
  String todayTasksDue(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'आज $count काम बाकी',
      one: 'आज 1 काम बाकी',
      zero: 'आज कोई काम बाकी नहीं',
    );
    return '$_temp0';
  }

  @override
  String get taskMarkAllDone => 'सब हो गया';

  @override
  String get taskDone => 'हो गया';

  @override
  String get taskSkip => 'छोड़ें';

  @override
  String get taskMoveTomorrow => 'कल पर टालें';

  @override
  String get taskPickDate => 'दूसरी तारीख चुनें';

  @override
  String get taskHowTo => 'कैसे करें';

  @override
  String get taskActions => 'काम के विकल्प';

  @override
  String taskDueOn(String date) {
    return '$date को करना है';
  }

  @override
  String get skipReasonTitle => 'क्यों छोड़ रहे हैं?';

  @override
  String get skipRained => 'बारिश हुई';

  @override
  String get skipSoilMoist => 'मिट्टी अभी भी नम है';

  @override
  String get skipNotNeeded => 'ज़रूरत नहीं';

  @override
  String get skipOther => 'कोई और वजह';

  @override
  String get taskCompleted => 'पूरा हुआ';

  @override
  String get taskSkipped => 'छोड़ा गया';

  @override
  String taskMoved(String date) {
    return '$date पर टाला गया';
  }

  @override
  String get carePlan => 'देखभाल योजना';

  @override
  String carePlanTitle(String plant) {
    return 'देखभाल योजना: $plant';
  }

  @override
  String carePlanAfterDone(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'पिछला काम होने के बाद हर $days दिन',
      one: 'पिछला काम होने के बाद हर दिन',
    );
    return '$_temp0';
  }

  @override
  String carePlanEvery(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'हर $days दिन',
      one: 'हर दिन',
    );
    return '$_temp0';
  }

  @override
  String get carePlanWeekly => 'हर हफ़्ते';

  @override
  String carePlanOnce(String date) {
    return 'एक बार, $date को';
  }

  @override
  String carePlanYearly(String date) {
    return 'हर साल $date को';
  }

  @override
  String get carePlanNote =>
      'शुरुआती सेटिंग हर काम की गाइड में दिए स्रोतों से आती हैं। इन्हें अपने पौधों और मौसम के हिसाब से बदलें; मिट्टी की जाँच हमेशा सबसे पहले।';

  @override
  String get carePlanEmpty => 'पौधा जोड़ने के कुछ पल बाद देखभाल योजना दिखेगी।';

  @override
  String get intervalShorter => 'कम अंतराल';

  @override
  String get intervalLonger => 'ज़्यादा अंतराल';

  @override
  String get calendarTitle => 'देखभाल कैलेंडर';

  @override
  String get calendarNote =>
      'तय किए गए काम दिखाता है। दोहराई जाने वाली जाँच अपनी अगली तारीख पर दिखती है।';

  @override
  String get calendarNoTasks => 'इस दिन कुछ तय नहीं है।';

  @override
  String get calendarPrevMonth => 'पिछला महीना';

  @override
  String get calendarNextMonth => 'अगला महीना';

  @override
  String calendarTasksOn(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count काम',
      one: '1 काम',
    );
    return '$_temp0';
  }

  @override
  String get settingsReminders => 'रिमाइंडर';

  @override
  String get reminderDaily => 'रोज़ की देखभाल का सारांश';

  @override
  String reminderDailySubtitle(String time) {
    return 'जिन दिनों काम हों, $time पर एक नोटिफ़िकेशन';
  }

  @override
  String get reminderTime => 'रिमाइंडर का समय';

  @override
  String get reminderPermissionDenied =>
      'इस ऐप के नोटिफ़िकेशन बंद हैं। आप इन्हें सिस्टम सेटिंग्स में चालू कर सकते हैं।';

  @override
  String get reminderNote =>
      'रिमाइंडर कुछ मिनट देर से आ सकते हैं। \'आज\' स्क्रीन हमेशा अप-टू-डेट रहती है।';

  @override
  String get journalTitle => 'डायरी';

  @override
  String get journalAddEntry => 'नई एंट्री';

  @override
  String get journalNewTitle => 'नई डायरी एंट्री';

  @override
  String get journalFilterAll => 'सभी';

  @override
  String get journalWholeGarden => 'पूरा बगीचा';

  @override
  String get milestoneGerminated => 'अंकुर निकले';

  @override
  String get milestoneTransplanted => 'रोपाई हुई';

  @override
  String get milestoneFlowering => 'फूल आए';

  @override
  String get milestoneFirstFruit => 'पहला फल';

  @override
  String get milestoneHarvest => 'तुड़ाई';

  @override
  String get milestoneOther => 'अन्य';

  @override
  String get journalGarden => 'बगीचा';

  @override
  String get journalPlant => 'पौधा';

  @override
  String get journalDate => 'तारीख';

  @override
  String get journalMilestone => 'पड़ाव (वैकल्पिक)';

  @override
  String get journalNote => 'नोट';

  @override
  String get journalNoteHint => 'आपने क्या देखा?';

  @override
  String get journalPhotos => 'फ़ोटो';

  @override
  String get journalAddPhoto => 'फ़ोटो जोड़ें';

  @override
  String get journalRemovePhoto => 'फ़ोटो हटाएँ';

  @override
  String journalPhotoLimit(int max) {
    return 'हर एंट्री में ज़्यादा से ज़्यादा $max फ़ोटो';
  }

  @override
  String get journalHarvestAmount => 'फसल की मात्रा';

  @override
  String get unitGrams => 'ग्राम';

  @override
  String get unitPieces => 'पीस';

  @override
  String get unitBunches => 'गुच्छे';

  @override
  String journalHarvestGrams(String amount) {
    return '$amount g';
  }

  @override
  String journalHarvestPieces(String amount) {
    return '$amount पीस';
  }

  @override
  String journalHarvestBunches(String amount) {
    return '$amount गुच्छे';
  }

  @override
  String get journalSave => 'एंट्री सेव करें';

  @override
  String get journalSaved => 'एंट्री सेव हो गई';

  @override
  String get journalEmptyError => 'कोई नोट, पड़ाव या फ़ोटो जोड़ें।';

  @override
  String get journalQuantityError =>
      'शून्य से ज़्यादा मात्रा डालें और यूनिट चुनें।';

  @override
  String journalCareDone(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'देखभाल के $count काम हो गए',
      one: 'देखभाल का 1 काम हो गया',
    );
    return '$_temp0';
  }

  @override
  String get journalDeleteTitle => 'यह एंट्री हटाएँ?';

  @override
  String get journalDeleteBody => 'इसकी फ़ोटो भी इस डिवाइस से हट जाएँगी।';

  @override
  String get journalDeleted => 'एंट्री हटा दी गई';

  @override
  String get journalNoMatches => 'इस फ़िल्टर के लिए अभी यहाँ कुछ नहीं है।';

  @override
  String get journalAddForPlant => 'डायरी एंट्री जोड़ें';

  @override
  String get statsTitle => 'आपकी प्रगति';

  @override
  String get statTasks => 'देखभाल के काम पूरे';

  @override
  String get statStreak => 'लगातार दिन';

  @override
  String get statEntries => 'डायरी एंट्री';

  @override
  String get statPhotos => 'फ़ोटो';

  @override
  String get statHarvested => 'तोड़ी गई फसल';

  @override
  String get compareAction => 'फ़ोटो की तुलना करें';

  @override
  String get compareTitle => 'फ़ोटो की तुलना करें';

  @override
  String get compareHint => 'दो फ़ोटो चुनें और उन्हें साथ-साथ देखें।';

  @override
  String get compareNeedTwo =>
      'प्रगति की तुलना के लिए कम से कम दो फ़ोटो जोड़ें।';

  @override
  String get compareAgain => 'दूसरी फ़ोटो चुनें';

  @override
  String get compareSelected => 'चुनी गई';

  @override
  String todayHeadlineSoil(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count पौधों को मिट्टी की जाँच चाहिए',
      one: '1 पौधे को मिट्टी की जाँच चाहिए',
    );
    return '$_temp0';
  }

  @override
  String todayHeadlineTasks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'आज $count काम करने हैं',
      one: 'आज 1 काम करना है',
    );
    return '$_temp0';
  }

  @override
  String get todayHeadlineDone => 'आज के सारे काम हो गए';

  @override
  String get todayWaterTip =>
      'सुबह जाँचें: पानी देने का सबसे अच्छा समय यही है · Royal Horticultural Society';

  @override
  String get todayDrawTitle => 'आइए, अपनी छत का नक्शा बनाएँ';

  @override
  String get todayDrawBody =>
      'बस एक बार फ़र्श नापें। हम आपके गमलों, आपकी धूप और आपके शहर के मौसम के हिसाब से पौधे सुझाएँगे, और मिट्टी जाँचने की याद दिलाएँगे।';

  @override
  String get todayDrawStart => 'अपनी छत से शुरू करें';

  @override
  String get todayDrawExplore => 'पहले पौधे देखें';

  @override
  String get todayNoLayoutTitle =>
      'इसे यहाँ देखने के लिए अपनी छत का नक्शा बनाएँ';

  @override
  String get todayNoLayoutBody =>
      'अपने गमले और ग्रो बैग सही नाप में जोड़ें। आपके पौधे और उनकी जाँच नक्शे पर दिखेंगी।';

  @override
  String get todayDesignLayout => 'अपना लेआउट बनाएँ';

  @override
  String get todayEditLayout => 'लेआउट बदलें';

  @override
  String get todayGardenDetails => 'बगीचे की जानकारी';

  @override
  String get todaySwitchGarden => 'बगीचा बदलें';

  @override
  String get todayAllGardens => 'सभी बगीचे';

  @override
  String todayPlanLabel(String garden) {
    return '$garden का नक्शा';
  }

  @override
  String get planDue => 'जाँच बाकी';

  @override
  String get planDone => 'आज हो गया';

  @override
  String get planEmpty => 'खाली';

  @override
  String get checkedToday => 'आज जाँचा';

  @override
  String get checkedYesterday => 'कल जाँचा';

  @override
  String checkedDaysAgo(int days) {
    return '$days दिन पहले जाँचा';
  }

  @override
  String get checkedNever => 'पहली जाँच';

  @override
  String dueSince(String date) {
    return '$date से बाकी';
  }

  @override
  String soilSheetLabel(String container) {
    return 'मिट्टी की जाँच · $container';
  }

  @override
  String get soilDry => 'सूखी थी, मैंने पानी दिया';

  @override
  String get soilMoist => 'अभी नम है, आज छोड़ें';

  @override
  String get soilMorning =>
      'पानी देने का सबसे अच्छा समय सुबह है · Royal Horticultural Society';

  @override
  String get soilDiagramLabel =>
      'गमले का क्रॉस-सेक्शन: मिट्टी में 2 से 3 सेंटीमीटर तक डाली गई उंगली, जहाँ ऊपरी परत ज़्यादा सूखी है';

  @override
  String get soilDryOnTop => 'ऊपर से सूखी?';

  @override
  String get soilFeelBelow => 'नीचे छूकर देखें';

  @override
  String get seasonsTitle => 'मौसम';

  @override
  String seasonsSubtitle(String city, String region) {
    return '$city · $region कैलेंडर';
  }

  @override
  String get seasonsSowNow => 'अभी बोएँ';

  @override
  String get seasonsNothingNow =>
      'कैटलॉग में किसी भी पौधे की बुवाई का समय इस महीने आपके क्षेत्र में नहीं है।';

  @override
  String get seasonsYourPlants => 'आपके पौधे और सेव किए गए';

  @override
  String get seasonsWindowLegend => 'बुवाई का समय';

  @override
  String get seasonsNoCalendar => 'हमारे स्रोतों में बुवाई का कैलेंडर नहीं है';

  @override
  String get seasonsNoRegion =>
      'आपके शहर के लिए अभी स्रोत वाला बुवाई कैलेंडर नहीं है, इसलिए मौसम नहीं दिखाए जा सकते। उत्तर भारत, दक्षिण भारत, तेलंगाना, तमिलनाडु और केरल शामिल हैं।';

  @override
  String get seasonsNoGarden =>
      'हर महीने क्या बोना है, यह देखने के लिए अपने शहर के साथ एक बगीचा जोड़ें।';

  @override
  String get seasonsFootnote =>
      'बुवाई का समय स्रोतों वाली क्षेत्रीय तालिकाओं से लिया गया है। सही तारीखें किस्म और मौसम पर निर्भर करती हैं।';

  @override
  String get seasonsEmptyPlants =>
      'आप जो पौधे जोड़ेंगे या सेव करेंगे, वे अपने बुवाई के महीनों के साथ यहाँ दिखेंगे।';

  @override
  String get settingsData => 'आपका डेटा';

  @override
  String get exportData => 'मेरा डेटा एक्सपोर्ट करें';

  @override
  String get exportDataSubtitle =>
      'आपके बगीचों, पौधों, देखभाल के रिकॉर्ड, डायरी और फ़ोटो वाली एक ZIP फ़ाइल';

  @override
  String get exportPreparing => 'आपका एक्सपोर्ट तैयार हो रहा है…';

  @override
  String get exportFailed => 'एक्सपोर्ट नहीं बन सका। कृपया फिर से कोशिश करें।';

  @override
  String get exportSubject => 'Terrace Garden डेटा एक्सपोर्ट';

  @override
  String get deleteAllData => 'सारा डेटा हटाएँ';

  @override
  String get deleteAllDataSubtitle =>
      'इस डिवाइस पर बगीचे, पौधे, देखभाल का रिकॉर्ड, डायरी और फ़ोटो';

  @override
  String get deleteAllTitle => 'सब कुछ हटाएँ?';

  @override
  String get deleteAllBody =>
      'इससे इस ऐप में सेव हर बगीचा, पौधा, देखभाल का काम, डायरी एंट्री और फ़ोटो हमेशा के लिए हट जाएगी, और आपकी सेटिंग्स रीसेट हो जाएँगी। इसे वापस नहीं किया जा सकता।';

  @override
  String get deleteAllConfirm => 'सब कुछ हटाएँ';

  @override
  String get deleteAllFailed =>
      'कुछ डेटा नहीं हटाया जा सका। कृपया फिर से कोशिश करें।';

  @override
  String get plantSoilCheckDue => 'मिट्टी की जाँच बाकी';

  @override
  String journeyDay(int day) {
    return 'दिन $day';
  }

  @override
  String journeyStartsOn(String date) {
    return '$date से शुरू';
  }

  @override
  String get journeySown => 'बोया';

  @override
  String get journeyPlanted => 'लगाया';

  @override
  String get journeyTransplant => 'रोपाई';

  @override
  String get journeyHarvest => 'तुड़ाई शुरू हो सकती है';

  @override
  String get journeyVaries => 'किस्म और मौसम के हिसाब से फ़र्क होता है।';

  @override
  String get journeyUndocumented =>
      'हमारे स्रोतों में अभी इस पौधे के अगले चरणों की जानकारी नहीं है।';

  @override
  String journeyLabel(String plant, String steps) {
    return '$plant का सफ़र: $steps';
  }

  @override
  String get careRhythm => 'देखभाल का क्रम';

  @override
  String get rhythmToday => 'आज';

  @override
  String get rhythmTomorrow => 'कल';

  @override
  String rhythmInDays(int count) {
    return '$count दिन में';
  }

  @override
  String factSoil(String volume) {
    return '$volume+ मिट्टी';
  }

  @override
  String plantArtLabel(String plant) {
    return '$plant का चित्र';
  }

  @override
  String plantSourcesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count स्रोत',
      one: '1 स्रोत',
    );
    return '$_temp0';
  }

  @override
  String get plantingWhichContainer => 'कौन-सा कंटेनर?';

  @override
  String plantingNeedsBoth(String plant, String volume, String depth) {
    return '$plant को कम से कम $volume और $depth गहरी मिट्टी चाहिए।';
  }

  @override
  String plantingNeedsVolume(String plant, String volume) {
    return '$plant को कम से कम $volume मिट्टी चाहिए।';
  }

  @override
  String plantingNeedsDepth(String plant, String depth) {
    return '$plant को कम से कम $depth गहरी मिट्टी चाहिए।';
  }

  @override
  String plantingNeedsUnknown(String plant) {
    return 'हमारे स्रोतों में $plant के लिए कंटेनर का साइज़ नहीं दिया गया है, इसलिए हम नहीं जाँच सकते कि यह फ़िट होगा या नहीं।';
  }

  @override
  String plantingPlanLabel(String garden) {
    return '$garden के नक्शे पर एक कंटेनर चुनें';
  }

  @override
  String plantingSaveIn(String container) {
    return '$container में लगाएँ';
  }

  @override
  String get fitFits => 'फ़िट है';

  @override
  String get fitTooSmall => 'बहुत छोटा';

  @override
  String get fitTooShallow => 'बहुत उथला';

  @override
  String get fitFull => 'भरा हुआ';

  @override
  String get fitUnknown => 'जाँचा नहीं';

  @override
  String fitHas(String plant) {
    return 'इसमें $plant है';
  }

  @override
  String get recBestMatch => 'सबसे सही';

  @override
  String get recSowNowFilter => 'सभी सुझाव';

  @override
  String recSowIn(String months) {
    return '$months में बोएँ';
  }

  @override
  String recReadyIn(int min, int max) {
    return '$min–$max दिन में तैयार';
  }

  @override
  String get journalThenNow => 'पहले और अब';

  @override
  String journalThenNowLabel(String date) {
    return '$date की फ़ोटो';
  }

  @override
  String get journalEntryShort => 'एंट्री';
}
