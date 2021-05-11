import 'package:flutter/cupertino.dart';
import 'package:myceleb/model/model.dart';

class RequestsProvider extends ChangeNotifier {
  var _currentCelebUser = UserModel(
    accountBalance: 250000,
    isCelebrity: true,
    name: 'Jose Chameleon',
    profileImage: 'assets/jose_chameleon.jpg',
    category: ['Musician'],
    price: 80000,
    estimatedDeliveryTime: 3,
    description:
        'Terrel Eldorado Owens, popularly known by his initials, T.O., is a former American football wide receiver who played in the National Football League for 16 seasons.',
  );
  UserModel get getCurrentCelebUser => _currentCelebUser;

  List<Reviews> get currentCelebReviews => reviews
      .where((review) => review.celebrityName == _currentCelebUser.name)
      .toList();

  var _currentFan = UserModel(
    name: 'Angela Naluhi',
    profileImage: 'assets/user_z.jpg',
    accountBalance: 65000,
    isCelebrity: false,
    email: 'naluhi@gmail.com',
  );

  UserModel get getCurrentFan => _currentFan;

  List<Request> _requests = [
    Request(
      createdTime: DateTime.now(),
      requesterProfilePicture: '',
      fanEmail: 'crea@gmail.com',
      fanProfileImage: 'assets/user_z.jpg',
      celebrityName: 'Aga Naga',
      requestFromName: 'Tom',
      requestForName: 'Jane',
      message:
          'Happy birthday Jane, hope you have a great day and keep being a legend',
      requestDate: '11/04/2021',
    ),
    Request(
      createdTime: DateTime.now(),
      requesterProfilePicture: '',
      fanEmail: 'bob@gmail.com',
      fanProfileImage: 'assets/user_z.jpg',
      celebrityName: 'Nina Roz',
      requestFromName: 'Justin',
      requestForName: 'Kahuma',
      message:
          'I love you Kahuma, hope you have a great day and keep being a legend',
      requestDate: '16/05/2021',
    ),
    Request(
      createdTime: DateTime.now(),
      requesterProfilePicture: '',
      fanEmail: 'luke@gmail.com',
      fanProfileImage: 'assets/user_z.jpg',
      celebrityName: 'Jose Chameleon',
      requestFromName: 'Shadia',
      requestForName: 'Ndahiro',
      message:
          'Happy birthday Ndahiro, hope you have a great day and keep being a legend',
      requestDate: '11/04/2021',
    ),
    Request(
      createdTime: DateTime.now(),
      requesterProfilePicture: '',
      fanEmail: 'daud@gmail.com',
      fanProfileImage: '',
      celebrityName: 'Spice Diana',
      requestFromName: 'Phillip',
      requestForName: 'Angela',
      message:
          'Pretty Angela, hope you have a great day and keep being a legend',
      requestDate: '11/04/2021',
    ),
  ];
  List<Request> get requests =>
      _requests.where((request) => request.isCompleted == false).toList();

  void addRequest(Request request) {
    _requests.add(request);
    notifyListeners();
  }

  List<Request> celebRequestList(String celebrityName) {
    return _requests
        .where((request) => request.celebrityName == celebrityName)
        .toList();
  }

  void updateRequest(
      {required Request request,
      required String message,
      required String requestForName,
      required String requestFromName,
      required String requestDate}) {
    request.message = message;
    request.requestForName = requestForName;
    request.requestFromName = requestFromName;
    request.requestDate = requestDate;
    notifyListeners();
  }

  bool isCompleted(Request request) {
    request.isCompleted = !request.isCompleted;
    notifyListeners();
    return request.isCompleted;
  }

  List<Request> get completedRequests =>
      _requests.where((request) => request.isCompleted == true).toList();

  List<UserModel> get celebritiesList => _celebritiesList;

  /// Used by typeAheadField to search on CelebritiesScreen
  List<UserModel> getSuggestions(String query) =>
      List.of(celebritiesList).where((user) {
        String? userLower = user.name.toLowerCase();
        String? queryLower = query.toLowerCase();
        return userLower.contains(queryLower);
      }).toList();

  void addReview(Reviews review) {
    _reviews.add(review);
    notifyListeners();
  }

  List<Reviews> get reviews => _reviews;
  List<Reviews> _reviews = [
    Reviews(
      celebrityName: 'Nina Roz',
      fanName: 'Jessy',
      rating: 3,
      message: 'What a brilliant thing to do. Highly recommend it to anyone.',
    ),
    Reviews(
      celebrityName: 'Jose Chameleon',
      fanName: 'Fred',
      rating: 4,
      message: 'Made for a perfect present',
    ),
    Reviews(
      celebrityName: 'Aga Naga',
      fanName: 'Gerald',
      rating: 5,
      message: 'Will be buying more!',
    ),
  ];
  List<UserModel> _celebritiesList = [
    UserModel(
      name: 'Nina Roz',
      profileImage: 'assets/nina_roz.jpg',
      category: ['Musician'],
      price: 80000,
      accountBalance: 100000,
      isCelebrity: true,
      phoneNumber: '2567895417893',
      estimatedDeliveryTime: 7,
      description:
          'Terrel Eldorado Owens, popularly known by his initials, T.O., is a former American football wide receiver who played in the National Football League for 16 seasons.',
    ),
    UserModel(
      name: 'Aga Naga',
      profileImage: 'assets/aga_naga.jpg',
      category: ['Musician'],
      price: 50000,
      accountBalance: 590000,
      isCelebrity: true,
      phoneNumber: '2567895417893',
      estimatedDeliveryTime: 2,
      description:
          'Terrel Eldorado Owens, popularly known by his initials, T.O., is a former American football wide receiver who played in the National Football League for 16 seasons.',
    ),
    UserModel(
      name: 'Grace Nakimera',
      profileImage: 'assets/grace_nakimera.jpg',
      category: ['Musician'],
      price: 40000,
      accountBalance: 200000,
      isCelebrity: true,
      phoneNumber: '2567895417893',
      estimatedDeliveryTime: 7,
      description:
          'Terrel Eldorado Owens, popularly known by his initials, T.O., is a former American football wide receiver who played in the National Football League for 16 seasons.',
    ),
    UserModel(
      name: 'Jose Chameleon',
      profileImage: 'assets/jose_chameleon.jpg',
      category: ['Musician'],
      price: 100000,
      accountBalance: 85000,
      isCelebrity: true,
      phoneNumber: '2567895417893',
      estimatedDeliveryTime: 6,
      description:
          'Terrel Eldorado Owens, popularly known by his initials, T.O., is a former American football wide receiver who played in the National Football League for 16 seasons.',
    ),
    UserModel(
      name: 'Bizonto',
      profileImage: 'assets/bizonto.jpg',
      category: ['Political commentators'],
      price: 80000,
      accountBalance: 250000,
      isCelebrity: true,
      phoneNumber: '2567895417893',
      estimatedDeliveryTime: 2,
      description:
          'Terrel Eldorado Owens, popularly known by his initials, T.O., is a former American football wide receiver who played in the National Football League for 16 seasons.',
    ),
    UserModel(
      name: 'Spice Diana',
      profileImage: 'assets/spice.jpg',
      category: ['Musician'],
      price: 80000,
      accountBalance: 90000,
      isCelebrity: true,
      phoneNumber: '2567895417893',
      estimatedDeliveryTime: 3,
      description:
          'Terrel Eldorado Owens, popularly known by his initials, T.O., is a former American football wide receiver who played in the National Football League for 16 seasons.',
    ),
    UserModel(
      name: 'Pallaso',
      profileImage: 'assets/pallaso.jpg',
      category: ['Musician'],
      price: 80000,
      accountBalance: 62000,
      isCelebrity: true,
      phoneNumber: '2567895417893',
      estimatedDeliveryTime: 1,
      description:
          'Terrel Eldorado Owens, popularly known by his initials, T.O., is a former American football wide receiver who played in the National Football League for 16 seasons.',
    ),
    UserModel(
      name: 'Zahara Toto',
      profileImage: 'assets/zahara_toto.jpg',
      category: ['Musician'],
      price: 80000,
      accountBalance: 480000,
      isCelebrity: true,
      phoneNumber: '2567895417893',
      estimatedDeliveryTime: 7,
      description:
          'Terrel Eldorado Owens, popularly known by his initials, T.O., is a former American football wide receiver who played in the National Football League for 16 seasons.',
    ),
    UserModel(
      name: 'Zuli Tums',
      profileImage: 'assets/zuli_tums.jpg',
      category: ['Musician'],
      price: 80000,
      accountBalance: 99000,
      isCelebrity: true,
      phoneNumber: '2567895417893',
      estimatedDeliveryTime: 5,
      description:
          'Terrel Eldorado Owens, popularly known by his initials, T.O., is a former American football wide receiver who played in the National Football League for 16 seasons.',
    ),
    UserModel(
      name: 'Stecia Mayanja',
      profileImage: 'assets/stecia_mayanja.jpg',
      category: ['Musician'],
      price: 80000,
      accountBalance: 600000,
      isCelebrity: true,
      phoneNumber: '2567895417893',
      estimatedDeliveryTime: 7,
      description:
          'Terrel Eldorado Owens, popularly known by his initials, T.O., is a former American football wide receiver who played in the National Football League for 16 seasons.',
    ),
    UserModel(
      name: 'Kabako',
      profileImage: 'assets/kabako.jpg',
      category: ['Musician'],
      price: 80000,
      accountBalance: 68000,
      isCelebrity: true,
      phoneNumber: '2567895417893',
      description:
          'Terrel Eldorado Owens, popularly known by his initials, T.O., is a former American football wide receiver who played in the National Football League for 16 seasons.',
      estimatedDeliveryTime: 7,
    ),
  ];

  var spiceDiana = UserModel(
    accountBalance: 250000,
    isCelebrity: true,
    name: 'Spice Diana',
    profileImage: 'assets/spice.jpg',
    category: ['Musician'],
    price: 80000,
    estimatedDeliveryTime: 3,
    description:
        'Terrel Eldorado Owens, popularly known by his initials, T.O., is a former American football wide receiver who played in the National Football League for 16 seasons.',
  );
}
