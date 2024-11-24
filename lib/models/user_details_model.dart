import 'package:equatable/equatable.dart';

class UserDetails extends Equatable {
  final int? id;
  final int? userId;
  final String? profileFor;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? role;
  final String? uniqueId;
  final double? amount;
  final String? password;
  final String? typeOfUser;
  final String? otp;
  final DateTime? createdAt;
  final bool? paymentStatus;
  final String? paymentMethod;
  final String? whomToContact;
  final String? contactPersonName;
  final String? availableTimeToCall;
  final String? comments;
  final String? familyStatus;
  final String? aboutYourSelf;
  final String? govtIdProof;
  final String? idImage;
  final String? country;
  final String? state;
  final String? pincode;
  final String? city;
  final String? flatNumber;
  final String? address;
  final String? ownHouse;
  final String? currentLocation;
  final String? gender;
  final String? dateOfBirth;
  final int? age;
  final String? height;
  final String? weight;
  final String? physicalStatus;
  final String? maritalStatus;
  final String? noOfChildren;
  final String? skinTone;
  final String? eatingHabits;
  final String? drinkingHabits;
  final String? smokingHabits;
  final String? education;
  final String? employedType;
  final String? occupation;
  final String? annualIncomeCurrency;
  final String? annualIncome;
  final String? citizenShip;
  final String? motherTongue;
  final String? religion;
  final String? caste;
  final String? subcaste;
  final String? division;
  final String? star;
  final String? raasi;
  final String? willingToMarryFromOtherCommunities;
  final List<String>? images;
  final bool? educationStatus;
  final bool? incomeStatus;
  final bool? pnoStatus;
  final bool? photoStatus;
  final bool? govtIdProofStatus;

  const UserDetails({
    this.id,
    this.userId,
    this.profileFor,
    this.name,
    this.email,
    this.phoneNumber,
    this.role,
    this.uniqueId,
    this.amount,
    this.password,
    this.typeOfUser,
    this.otp,
    this.createdAt,
    this.paymentStatus,
    this.paymentMethod,
    this.whomToContact,
    this.contactPersonName,
    this.availableTimeToCall,
    this.comments,
    this.familyStatus,
    this.aboutYourSelf,
    this.govtIdProof,
    this.idImage,
    this.country,
    this.state,
    this.pincode,
    this.city,
    this.flatNumber,
    this.address,
    this.ownHouse,
    this.currentLocation,
    this.gender,
    this.dateOfBirth,
    this.age,
    this.height,
    this.weight,
    this.physicalStatus,
    this.maritalStatus,
    this.noOfChildren,
    this.skinTone,
    this.eatingHabits,
    this.drinkingHabits,
    this.smokingHabits,
    this.education,
    this.employedType,
    this.occupation,
    this.annualIncomeCurrency,
    this.annualIncome,
    this.citizenShip,
    this.motherTongue,
    this.religion,
    this.caste,
    this.subcaste,
    this.division,
    this.star,
    this.raasi,
    this.willingToMarryFromOtherCommunities,
    this.images,
    this.photoStatus,
    this.govtIdProofStatus,
    this.pnoStatus,
    this.incomeStatus,
    this.educationStatus,
  });

  UserDetails copyWith({
    int? id,
    int? userId,
    String? profileFor,
    String? name,
    String? email,
    String? phoneNumber,
    String? role,
    String? uniqueId,
    double? amount,
    String? password,
    String? typeOfUser,
    String? otp,
    DateTime? createdAt,
    bool? paymentStatus,
    String? paymentMethod,
    String? whomToContact,
    String? contactPersonName,
    String? availableTimeToCall,
    String? comments,
    String? familyStatus,
    String? aboutYourSelf,
    String? govtIdProof,
    String? idImage,
    String? country,
    String? state,
    String? pincode,
    String? city,
    String? flatNumber,
    String? address,
    String? ownHouse,
    String? currentLocation,
    String? gender,
    String? dateOfBirth,
    int? age,
    String? height,
    String? weight,
    String? physicalStatus,
    String? maritalStatus,
    String? noOfChildren,
    String? skinTone,
    String? eatingHabits,
    String? drinkingHabits,
    String? smokingHabits,
    String? education,
    String? employedType,
    String? occupation,
    String? annualIncomeCurrency,
    String? annualIncome,
    String? citizenShip,
    String? motherTongue,
    String? religion,
    String? caste,
    String? subcaste,
    String? division,
    String? star,
    String? raasi,
    String? willingToMarryFromOtherCommunities,
    List<String>? images,
    bool? govtIdProofStatus,
    bool? photoStatus,
    bool? pnoStatus,
    bool? incomeStatus,
    bool? educationStatus,
  }) {
    return UserDetails(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        profileFor: profileFor ?? this.profileFor,
        name: name ?? this.name,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        role: role ?? this.role,
        uniqueId: uniqueId ?? this.uniqueId,
        amount: amount ?? this.amount,
        password: password ?? this.password,
        typeOfUser: typeOfUser ?? this.typeOfUser,
        otp: otp ?? this.otp,
        createdAt: createdAt ?? this.createdAt,
        paymentStatus: paymentStatus ?? this.paymentStatus,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        whomToContact: whomToContact ?? this.whomToContact,
        contactPersonName: contactPersonName ?? this.contactPersonName,
        availableTimeToCall: availableTimeToCall ?? this.availableTimeToCall,
        comments: comments ?? this.comments,
        familyStatus: familyStatus ?? this.familyStatus,
        aboutYourSelf: aboutYourSelf ?? this.aboutYourSelf,
        govtIdProof: govtIdProof ?? this.govtIdProof,
        idImage: idImage ?? this.idImage,
        country: country ?? this.country,
        state: state ?? this.state,
        pincode: pincode ?? this.pincode,
        city: city ?? this.city,
        flatNumber: flatNumber ?? this.flatNumber,
        address: address ?? this.address,
        ownHouse: ownHouse ?? this.ownHouse,
        currentLocation: currentLocation ?? this.currentLocation,
        gender: gender ?? this.gender,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        age: age ?? this.age,
        height: height ?? this.height,
        weight: weight ?? this.weight,
        physicalStatus: physicalStatus ?? this.physicalStatus,
        maritalStatus: maritalStatus ?? this.maritalStatus,
        noOfChildren: noOfChildren ?? this.noOfChildren,
        skinTone: skinTone ?? this.skinTone,
        eatingHabits: eatingHabits ?? this.eatingHabits,
        drinkingHabits: drinkingHabits ?? this.drinkingHabits,
        smokingHabits: smokingHabits ?? this.smokingHabits,
        education: education ?? this.education,
        employedType: employedType ?? this.employedType,
        occupation: occupation ?? this.occupation,
        annualIncomeCurrency: annualIncomeCurrency ?? this.annualIncomeCurrency,
        annualIncome: annualIncome ?? this.annualIncome,
        citizenShip: citizenShip ?? this.citizenShip,
        motherTongue: motherTongue ?? this.motherTongue,
        religion: religion ?? this.religion,
        caste: caste ?? this.caste,
        subcaste: subcaste ?? this.subcaste,
        division: division ?? this.division,
        star: star ?? this.star,
        raasi: raasi ?? this.raasi,
        willingToMarryFromOtherCommunities:
            willingToMarryFromOtherCommunities ??
                this.willingToMarryFromOtherCommunities,
        images: images ?? this.images,
        govtIdProofStatus: govtIdProofStatus ?? this.govtIdProofStatus,
        educationStatus: educationStatus ?? this.educationStatus,
        incomeStatus: incomeStatus ?? this.incomeStatus,
        photoStatus: photoStatus ?? this.photoStatus,
        pnoStatus: pnoStatus ?? this.pnoStatus);
  }

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    try {
      final registrationDetails = json['registrationDetails'] ?? {};
      final additionalInformation = json['additionalInformation'] ?? {};
      final locationInformation = json['locationInformation'] ?? {};
      final personalDetails = json['personalDetails'] ?? {};
      final religiousInformation = json['religiousInformation'] ?? {};
      final professionalInformation = json['professionalInformation'] ?? {};
      final photo = json['photo'] ?? {};
      final govtIdProof = json['govtIdProof'] ?? {};

      return UserDetails(
          id: registrationDetails['id'],
          userId: registrationDetails['userId'],
          profileFor: registrationDetails['profileFor'],
          name: registrationDetails['name'],
          email: registrationDetails['email'],
          phoneNumber: registrationDetails['phoneNumber'],
          role: registrationDetails['role'],
          uniqueId: registrationDetails['uniqueId'],
          amount: (registrationDetails['amount'] as num?)?.toDouble(),
          password: registrationDetails['password'],
          typeOfUser: registrationDetails['typeOfUser'],
          otp: registrationDetails['otp'],
          createdAt: registrationDetails['createdAt'] != null
              ? DateTime.parse(registrationDetails['createdAt'])
              : null,
          paymentStatus: registrationDetails['paymentStatus'],
          paymentMethod: registrationDetails['paymentMethod'],
          whomToContact: registrationDetails['whomToContact'],
          contactPersonName: registrationDetails['contactPersonName'],
          availableTimeToCall: registrationDetails['availableTimeToCall'],
          comments: registrationDetails['comments'],
          familyStatus: additionalInformation['familyStatus'],
          aboutYourSelf: additionalInformation['aboutYourSelf'],
          govtIdProof: govtIdProof['govtIdProof'],
          idImage: govtIdProof['idImage'],
          country: locationInformation['country'],
          state: locationInformation['state'],
          pincode: locationInformation['pincode'],
          city: locationInformation['city'],
          flatNumber: locationInformation['flatNumber'],
          address: locationInformation['address'],
          ownHouse: locationInformation['ownHouse'],
          currentLocation: locationInformation['currentLocation'],
          gender: personalDetails['gender'],
          dateOfBirth: personalDetails['dateOfBirth'],
          age: personalDetails['age'],
          height: personalDetails['height'],
          weight: personalDetails['weight'],
          physicalStatus: personalDetails['physicalStatus'],
          maritalStatus: personalDetails['maritalStatus'],
          noOfChildren: personalDetails['noOfChildren'],
          skinTone: personalDetails['skinTone'],
          eatingHabits: personalDetails['eatingHabits'],
          drinkingHabits: personalDetails['drinkingHabits'],
          smokingHabits: personalDetails['smokingHabits'],
          education: professionalInformation['education'],
          employedType: professionalInformation['employedType'],
          occupation: professionalInformation['occupation'],
          annualIncomeCurrency: professionalInformation['annualIncomeCurrency'],
          annualIncome: professionalInformation['annualIncome'],
          citizenShip: professionalInformation['citizenShip'],
          motherTongue: religiousInformation['motherTongue'],
          religion: religiousInformation['religion'],
          caste: religiousInformation['caste'],
          subcaste: religiousInformation['subcaste'],
          division: religiousInformation['division'],
          star: religiousInformation['star'],
          raasi: religiousInformation['raasi'],
          willingToMarryFromOtherCommunities:
              religiousInformation['willingToMarryFromOtherCommunities'],
          images:
              (photo['images'] as List?)?.whereType<String>().toList() ?? [],
          educationStatus: professionalInformation['educationStatus'],
          pnoStatus: registrationDetails['pnoStatus'],
          photoStatus: photo['photoStatus'],
          incomeStatus: professionalInformation['incomeStatus'],
          govtIdProofStatus: govtIdProof['govtIdProofStatus']);
    } catch (e, stackTrace) {
      print('Error parsing UserDetails: $e');
      print(stackTrace);
      return const UserDetails(
        id: null,
        userId: null,
        profileFor: null,
        name: null,
        email: null,
        phoneNumber: null,
        role: null,
        uniqueId: null,
        amount: null,
        password: null,
        typeOfUser: null,
        otp: null,
        createdAt: null,
        paymentStatus: null,
        paymentMethod: null,
        whomToContact: null,
        contactPersonName: null,
        availableTimeToCall: null,
        comments: null,
        familyStatus: null,
        aboutYourSelf: null,
        govtIdProof: null,
        idImage: null,
        country: null,
        state: null,
        pincode: null,
        city: null,
        flatNumber: null,
        address: null,
        ownHouse: null,
        currentLocation: null,
        gender: null,
        dateOfBirth: null,
        age: null,
        height: null,
        weight: null,
        physicalStatus: null,
        maritalStatus: null,
        noOfChildren: null,
        skinTone: null,
        eatingHabits: null,
        drinkingHabits: null,
        smokingHabits: null,
        education: null,
        employedType: null,
        occupation: null,
        annualIncomeCurrency: null,
        annualIncome: null,
        citizenShip: null,
        motherTongue: null,
        religion: null,
        caste: null,
        subcaste: null,
        division: null,
        star: null,
        raasi: null,
        willingToMarryFromOtherCommunities: null,
        images: [],
        govtIdProofStatus: null,
        incomeStatus: null,
        photoStatus: null,
        pnoStatus: null,
        educationStatus: null,
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'profileFor': profileFor,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'role': role,
      'uniqueId': uniqueId,
      'amount': amount,
      'password': password,
      'typeOfUser': typeOfUser,
      'otp': otp,
      'createdAt': createdAt?.toIso8601String(),
      'paymentStatus': paymentStatus,
      'paymentMethod': paymentMethod,
      'whomToContact': whomToContact,
      'contactPersonName': contactPersonName,
      'availableTimeToCall': availableTimeToCall,
      'comments': comments,
      'familyStatus': familyStatus,
      'aboutYourSelf': aboutYourSelf,
      'govtIdProof': govtIdProof,
      'idImage': idImage,
      'country': country,
      'state': state,
      'pincode': pincode,
      'city': city,
      'flatNumber': flatNumber,
      'address': address,
      'ownHouse': ownHouse,
      'currentLocation': currentLocation,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
      'age': age,
      'height': height,
      'weight': weight,
      'physicalStatus': physicalStatus,
      'maritalStatus': maritalStatus,
      'noOfChildren': noOfChildren,
      'skinTone': skinTone,
      'eatingHabits': eatingHabits,
      'drinkingHabits': drinkingHabits,
      'smokingHabits': smokingHabits,
      'education': education,
      'employedType': employedType,
      'occupation': occupation,
      'annualIncomeCurrency': annualIncomeCurrency,
      'annualIncome': annualIncome,
      'citizenShip': citizenShip,
      'motherTongue': motherTongue,
      'religion': religion,
      'caste': caste,
      'subcaste': subcaste,
      'division': division,
      'star': star,
      'raasi': raasi,
      'images': images,
      'photoStatus': photoStatus,
      'pnoStatus': pnoStatus,
      'govtIdProofStatus': govtIdProofStatus,
      'educationStatus': educationStatus,
      'incomeStatus': incomeStatus
    };
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        profileFor,
        name,
        email,
        phoneNumber,
        role,
        uniqueId,
        amount,
        password,
        typeOfUser,
        otp,
        createdAt,
        paymentStatus,
        paymentMethod,
        whomToContact,
        contactPersonName,
        availableTimeToCall,
        comments,
        familyStatus,
        aboutYourSelf,
        govtIdProof,
        idImage,
        country,
        state,
        pincode,
        city,
        flatNumber,
        address,
        ownHouse,
        currentLocation,
        gender,
        dateOfBirth,
        age,
        height,
        weight,
        physicalStatus,
        maritalStatus,
        noOfChildren,
        skinTone,
        eatingHabits,
        drinkingHabits,
        smokingHabits,
        education,
        employedType,
        occupation,
        annualIncomeCurrency,
        annualIncome,
        citizenShip,
        motherTongue,
        religion,
        caste,
        subcaste,
        division,
        star,
        raasi,
        images,
        govtIdProofStatus,
        photoStatus,
        pnoStatus,
        incomeStatus,
        educationStatus
      ];
}
