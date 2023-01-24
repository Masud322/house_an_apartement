class House {
  String name;
  String address;
  String imageUrl;

  House(this.name, this.address, this.imageUrl);

  static List<House> generateRecommended() {
    return [
      House('House_1', 'Shonadanga,Boyra,Khulna',
          'assets/images/1.jpg'),
      House('House_2', 'Newmarket,Khulna',
          'assets/images/2.jpg'),
    ];
  }

  static List<House> generateBestOffer() {
    return [
      House('House_1', 'Shonadanga, Boyra, Khulna',
          'assets/images/1.jpg'),
      House('House_2', 'Newmarket,Khulna',
          'assets/images/2.jpg'),
    ];
  }
}